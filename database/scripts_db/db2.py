import pymysql
import random
from datetime import date

# ----------------- CONEXIÓN -----------------
# Variables de conexión, por favor verifica que sean correctas.
conn = pymysql.connect(
    host="localhost",
    user="root",
    password="1234",
    database="uniia",
    charset="utf8mb4",
    cursorclass=pymysql.cursors.DictCursor
)

cursor = conn.cursor()

# =====================================================
# 1. INSERTAR PERIODOS 2025-1 y 2025-2
# =====================================================

periodos = [
    ("2025-1", "2025-03-01", "2025-07-31"),
    ("2025-2", "2025-08-01", "2025-12-20")
]

# Usamos INSERT IGNORE para que si ya existen, no falle.
cursor.executemany("""
    INSERT IGNORE INTO Periodos (nombre, fecha_inicio, fecha_fin, activo)
    VALUES (%s, %s, %s, TRUE)
""", periodos)

conn.commit()
print("✔ Periodos 2025-1 y 2025-2 verificados/insertados.")


# =====================================================
# 2. OBTENER PERIODO ACTUAL O PREDETERMINADO
# =====================================================

# Intentamos obtener el periodo activo según la fecha actual.
cursor.execute("""
    SELECT id_periodo
    FROM Periodos
    WHERE CURDATE() BETWEEN fecha_inicio AND fecha_fin;
""")

periodo = cursor.fetchone()

if periodo is None:
    # Si no hay periodo activo según la fecha actual, forzamos el uso del 2025-2 (Segundo Semestre)
    print("⚠ No hay un periodo activo para la fecha actual según CURDATE(). Usando 2025-2 por defecto para la prueba.")
    cursor.execute("SELECT id_periodo FROM Periodos WHERE nombre = '2025-2'")
    periodo = cursor.fetchone()
    if periodo is None:
        raise Exception("No se pudo encontrar el periodo 2025-2. Verifica la base de datos.")

id_periodo_actual = periodo["id_periodo"]
print(f"✔ Periodo actual o seleccionado: ID {id_periodo_actual}.")


# =====================================================
# 3. MATRICULAR AUTOMÁTICAMENTE A LOS ESTUDIANTES
#    (Usando cursos del SEGUNDO SEMESTRE)
# =====================================================

# Obtener Carrera de Sistemas (asumimos que existe)
cursor.execute("SELECT id_carrera FROM Carreras WHERE nombre = 'Ingeniería de Sistemas e Informática'")
carrera = cursor.fetchone()

if carrera is None:
    raise Exception("La carrera 'Ingeniería de Sistemas e Informática' no existe. Verifica los datos insertados en el script anterior.")

id_carrera_sistemas = carrera["id_carrera"]

# CAMBIO CLAVE: Obtener cursos del 2do semestre según Plan_Estudios
cursor.execute("""
    SELECT id_curso 
    FROM Plan_Estudios
    WHERE id_carrera = %s AND id_semestre = 2 -- FILTRO POR SEMESTRE 2
""", (id_carrera_sistemas,))

cursos_sem2 = cursor.fetchall()

# Obtener estudiantes de Sistemas
cursor.execute("""
    SELECT id_estudiante 
    FROM Estudiantes 
    WHERE id_carrera = %s
""", (id_carrera_sistemas,))

estudiantes = cursor.fetchall()


# ----------------------------------------------------------------------
# ⚡️ VERIFICACIÓN CLAVE PARA EL USUARIO ⚡️
num_cursos = len(cursos_sem2)
num_estudiantes = len(estudiantes)

print("\n--- INICIO DE VERIFICACIÓN DE MATRÍCULA ---")
print(f" - Carrera a matricular: Ingeniería de Sistemas (ID: {id_carrera_sistemas})")
print(f" - Cursos del SEGUNDO Semestre encontrados en Plan_Estudios: {num_cursos}")
print(f" - Estudiantes de Sistemas encontrados en Estudiantes: {num_estudiantes}")
print("------------------------------------------")

if num_estudiantes == 0 or num_cursos == 0:
    print("⚠ No hay estudiantes o cursos para matricular. Saltando la inserción de Matrículas.")
    matriculas_ids = []
else:
    # Registrar matrículas (usando executemany para mayor eficiencia)
    matriculas_data = []

    for est in estudiantes:
        id_est = est["id_estudiante"]
        for curso in cursos_sem2: # Usamos cursos del S2
            id_curso = curso["id_curso"]
            matriculas_data.append((id_est, id_curso, id_periodo_actual))
    
    # Ejecutar todas las inserciones de matrícula en un solo paso
    cursor.executemany("""
        INSERT IGNORE INTO Matriculas (id_estudiante, id_curso, id_periodo)
        VALUES (%s, %s, %s)
    """, matriculas_data)

    conn.commit()
    
    # El número total de filas a insertar es: num_estudiantes * num_cursos
    total_esperado = num_estudiantes * num_cursos
    
    print(f"✔ Matrículas intentadas (total): {total_esperado}")
    print(f"   El proceso ha intentado matricular a TODOS los {num_estudiantes} estudiantes")
    print(f"   en los {num_cursos} cursos del SEGUNDO semestre de Sistemas.")


    # Obtener todos los IDs de las matrículas (nuevas y existentes) para el siguiente paso (Notas)
    estudiante_ids = [est["id_estudiante"] for est in estudiantes]
    
    # Esto es crucial para la inserción de notas
    placeholders = ', '.join(['%s'] * len(estudiante_ids))

    cursor.execute(f"""
        SELECT id_matricula
        FROM Matriculas
        WHERE id_estudiante IN ({placeholders}) 
        AND id_periodo = %s
    """, estudiante_ids + [id_periodo_actual])
    
    matriculas_ids = [m["id_matricula"] for m in cursor.fetchall()]
    print(f" - Total de IDs de Matrícula recuperados para notas (nuevos y existentes): {len(matriculas_ids)}")
# ----------------------------------------------------------------------


# =====================================================
# 4. INSERTAR NOTAS ALEATORIAS 0–20 EN NOTAS_UNIDAD
#    (Las notas se asignan a los cursos matriculados en el punto 3)
# =====================================================

notas_data = []

for id_matricula in matriculas_ids:

    # obtener curso asociado
    cursor.execute("""
        SELECT id_curso FROM Matriculas WHERE id_matricula = %s
    """, (id_matricula,))
    
    # Si la matrícula aún existe, obtenemos su curso
    curso_data = cursor.fetchone()
    if curso_data:
        id_curso = curso_data["id_curso"]

        # obtener unidades del curso (generadas automáticamente por el trigger)
        cursor.execute("""
            SELECT id_unidad FROM Curso_Unidades WHERE id_curso = %s
        """, (id_curso,))

        unidades = cursor.fetchall()

        for u in unidades:
            id_unid = u["id_unidad"]

            # generar notas aleatorias
            n1 = round(random.uniform(0, 20), 2)
            n2 = round(random.uniform(0, 20), 2)
            n3 = round(random.uniform(0, 20), 2)

            # Recolectar los datos
            notas_data.append((id_matricula, id_unid, n1, n2, n3))
    
# Inserción masiva de notas
if notas_data:
    cursor.executemany("""
        INSERT IGNORE INTO Notas_Unidad 
        (id_matricula, id_unidad, nota_actitudinal, nota_procedimental, nota_conceptual)
        VALUES (%s, %s, %s, %s, %s)
    """, notas_data)
    
    print(f"\n✔ Notas aleatorias insertadas/actualizadas para {len(notas_data)} registros de unidad (cursos del S2).")

# CONFIRMAR TODAS LAS TRANSACCIONES FINALES (Matrículas y Notas)
conn.commit()

cursor.close()
conn.close()

print("\n✔✔ PROCESO COMPLETADO CORRECTAMENTE. ✔✔")