import pymysql
import random
from datetime import date

# ----------------- CONEXIÓN -----------------
conn = pymysql.connect(
    host="localhost",
    user="root",
    password="1234",
    database="uniia",
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

cursor.executemany("""
    INSERT INTO Periodos (nombre, fecha_inicio, fecha_fin, activo)
    VALUES (%s, %s, %s, TRUE)
""", periodos)

conn.commit()


# =====================================================
# 2. OBTENER PERIODO ACTUAL SEGÚN FECHA DEL SISTEMA
# =====================================================

cursor.execute("""
    SELECT id_periodo
    FROM Periodos
    WHERE CURDATE() BETWEEN fecha_inicio AND fecha_fin;
""")

periodo = cursor.fetchone()

if periodo is None:
    raise Exception("No hay un periodo activo para la fecha actual.")

id_periodo_actual = periodo["id_periodo"]


# =====================================================
# 3. MATRICULAR AUTOMÁTICAMENTE A LOS ESTUDIANTES
#    SOLO CURSOS DEL 1er SEMESTRE DE SISTEMAS
# =====================================================

# Obtener Carrera de Sistemas (asumimos que existe)
cursor.execute("SELECT id_carrera FROM Carreras WHERE nombre = 'Ingenieria de Sistemas e Informatica'")
carrera = cursor.fetchone()

if carrera is None:
    raise Exception("La carrera Sistemas no existe.")

id_carrera_sistemas = carrera["id_carrera"]

# Obtener cursos del 1er semestre según Plan_Estudios
cursor.execute("""
    SELECT id_curso 
    FROM Plan_Estudios
    WHERE id_carrera = %s AND id_semestre = 1
""", (id_carrera_sistemas,))

cursos_sem1 = cursor.fetchall()

# Obtener estudiantes de Sistemas
cursor.execute("""
    SELECT id_estudiante 
    FROM Estudiantes 
    WHERE id_carrera = %s
""", (id_carrera_sistemas,))

estudiantes = cursor.fetchall()


# Registrar matrículas
matriculas_ids = []  # guardamos los ID generados

for est in estudiantes:
    id_est = est["id_estudiante"]

    for curso in cursos_sem1:
        id_curso = curso["id_curso"]

        cursor.execute("""
            INSERT IGNORE INTO Matriculas (id_estudiante, id_curso, id_periodo)
            VALUES (%s, %s, %s)
        """, (id_est, id_curso, id_periodo_actual))

        conn.commit()

        # Obtener id_matricula recién creado
        cursor.execute("""
            SELECT id_matricula 
            FROM Matriculas
            WHERE id_estudiante = %s AND id_curso = %s AND id_periodo = %s
        """, (id_est, id_curso, id_periodo_actual))

        matricula = cursor.fetchone()
        matriculas_ids.append(matricula["id_matricula"])


# =====================================================
# 4. INSERTAR NOTAS ALEATORIAS 0–20 EN NOTAS_UNIDAD
# =====================================================

for id_matricula in matriculas_ids:

    # obtener curso asociado
    cursor.execute("""
        SELECT id_curso FROM Matriculas WHERE id_matricula = %s
    """, (id_matricula,))
    id_curso = cursor.fetchone()["id_curso"]

    # obtener unidades del curso
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

        cursor.execute("""
            INSERT IGNORE INTO Notas_Unidad 
            (id_matricula, id_unidad, nota_actitudinal, nota_procedimental, nota_conceptual)
            VALUES (%s, %s, %s, %s, %s)
        """, (id_matricula, id_unid, n1, n2, n3))

conn.commit()

cursor.close()
conn.close()

print("Proceso completado correctamente.")
