import pymysql
import random
import os

# ----------------------------------------------------
# CONFIGURACIÓN DE CONEXIÓN
# ----------------------------------------------------
connection = pymysql.connect(
    host="localhost",
    user="root",
    password="1234",
    database="uniia",
    charset="utf8mb4",
    cursorclass=pymysql.cursors.DictCursor
)

print("Conexión a MySQL exitosa.")

# ----------------------------------------------------
# CONFIGURACIÓN DE RUTAS DE SILABOS
# ----------------------------------------------------
# Variable que representa el disco y el directorio base, que debe ser cambiada según la máquina.
# Usamos r'' (raw string) para manejar las barras invertidas de Windows como texto literal.
DISCO_UNIDAD = r'D:\8VO SEMESTRE\IA\DB Prueba Insertación de Datos' 
# Directorio fijo del repositorio.
DIRECTORIO_SILABOS = r'\database\S2022-2'

# Datos base para generar estudiantes aleatorios
NOMBRES = ['Alejandro', 'Sofía', 'Daniel', 'Valentina', 'Mateo', 'Isabella', 'Sebastián', 'Camila', 'Gabriel', 'Luciana', 
           'Adrián', 'Valeria', 'Javier', 'María', 'Emilio', 'Elena', 'Diego', 'Paula', 'Nicolás', 'Andrea']
APELLIDOS = ['García', 'Rodríguez', 'González', 'Fernández', 'López', 'Martínez', 'Sánchez', 'Pérez', 'Gómez', 'Díaz', 
             'Vargas', 'Torres', 'Castro', 'Mendoza', 'Rojas', 'Flores', 'Silva', 'Espinoza', 'Herrera', 'Acuña']

# Parámetros de generación
NUM_ESTUDIANTES = 30
ID_CARRERA_SISTEMAS = 3 
CODIGO_UNIVERSITARIO_INICIAL = 20250001
DNI_INICIAL = 40000000 

try:
    with connection.cursor() as cursor:

        # ----------------------------------------------------
        # 1. INSERTAR CARRERAS (Bloque original)
        # ----------------------------------------------------
        carreras = [
            "Ingeniería Agroindustrial",
            "Ingeniería Forestal",
            "Ingeniería de Sistemas e Informática",
            "Medicina Veterinaria",
            "Educación Matemática",
            "Derecho",
            "Enfermería",
            "Ecoturismo",
            "Administración",
            "Contabilidad"
        ]
        
        # Opcional: Borrar datos de prueba para empezar limpio (descomentar si es necesario)
        # cursor.execute("DELETE FROM Plan_Estudios WHERE id_carrera = %s AND id_semestre IN (1, 2)", (ID_CARRERA_SISTEMAS,))
        # cursor.execute("DELETE FROM Estudiantes WHERE id_carrera = %s", (ID_CARRERA_SISTEMAS,))
        # cursor.execute("DELETE FROM Cursos WHERE nombre IN ('DISEÑO PARA INGENIERIA', 'QUIMICA GENERAL', 'SOCIOLOGIA RURAL Y AMAZONICA', 'ALGORITMOS Y PROGRAMACIÓN', 'CALCULO I', 'ALGEBRA LINEAL', 'FISICA I')")


        sql_carrera = "INSERT IGNORE INTO Carreras (id_carrera, nombre) VALUES (%s, %s)"
        for i, c in enumerate(carreras, 1):
            cursor.execute(sql_carrera, (i, c))
        print("✔ Carreras insertadas o verificadas (usando INSERT IGNORE).")


        # ----------------------------------------------------
        # 2. INSERTAR 30 ESTUDIANTES ALEATORIOS (Bloque original)
        # ----------------------------------------------------
        sql_est = """
        INSERT INTO Estudiantes 
        (codigo_universitario, dni, nombre, apellidop, apellidom, id_carrera)
        VALUES (%s, %s, %s, %s, %s, %s)
        """
        
        datos_estudiantes = []
        for i in range(NUM_ESTUDIANTES):
            codigo = str(CODIGO_UNIVERSITARIO_INICIAL + i)
            dni = str(DNI_INICIAL + i) 

            nombre = random.choice(NOMBRES)
            apellidop = random.choice(APELLIDOS)
            apellidom = random.choice(APELLIDOS)
            
            while apellidop == apellidom:
                apellidom = random.choice(APELLIDOS)

            datos_estudiantes.append((codigo, dni, nombre, apellidop, apellidom, ID_CARRERA_SISTEMAS))
        
        cursor.executemany(sql_est, datos_estudiantes)
        print(f"✔ {NUM_ESTUDIANTES} Estudiantes de Ingeniería de Sistemas insertados exitosamente.")


        # ----------------------------------------------------
        # 3. INSERTAR CURSOS DEL PRIMER SEMESTRE DE SISTEMAS 
        # ----------------------------------------------------
        # El curso "ALGORITMOS" se modificó en el paso anterior a "ALGORITMOS INTRODUCTORIOS"
        cursos_sistemas_1 = [
            ("ALGORITMOS INTRODUCTORIOS", 3), 
            ("CULTURA DE PAZ Y DEFENSA NACIONAL", 2),
            ("REDACCION TECNICA Y CIENTIFICA", 2),
            ("COMPLEMENTO DE MATEMATICA", 4),
            ("LENGUAJE Y COMUNICACION", 3),
            ("INTRODUCCION A INGENIERIA DE SISTEMAS", 3),
            ("ECOLOGIA GENERAL Y RECURSOS NATURALES", 3),
            ("ACTIVIDADES CULTURALES Y/O DEPORTIVAS", 2)
        ]

        sql_curso_1 = """
        INSERT INTO Cursos (nombre, creditos, silabo)
        VALUES (%s, %s, 'Silabo por definir')
        ON DUPLICATE KEY UPDATE nombre=nombre 
        """

        for nombre, creditos in cursos_sistemas_1:
            cursor.execute(sql_curso_1, (nombre, creditos))

        print("✔ Cursos del 1er semestre insertados (el trigger generó unidades).")


        # ----------------------------------------------------
        # 4. CREAR EL PLAN DE ESTUDIOS PARA S1 (Bloque original)
        # ----------------------------------------------------
        # Obtener id_carrera de Ingeniería de Sistemas
        cursor.execute("SELECT id_carrera FROM Carreras WHERE nombre='Ingeniería de Sistemas e Informática'")
        id_carrera_sis = cursor.fetchone()["id_carrera"]

        # Obtener id_semestre = 1
        cursor.execute("SELECT id_semestre FROM Semestres WHERE numero=1")
        result_sem = cursor.fetchone()

        if result_sem:
            id_sem = result_sem["id_semestre"]
        else:
            cursor.execute("INSERT INTO Semestres (numero, descripcion) VALUES (1, 'Primer Semestre')")
            id_sem = cursor.lastrowid

        print("✔ Semestre 1 verificado.")

        # Obtener cursos recién insertados:
        nombres_cursos = [c[0] for c in cursos_sistemas_1]
        
        # Crear un string con placeholders para la consulta IN
        placeholders = ', '.join(['%s'] * len(nombres_cursos))
        
        cursor.execute(f"""
        SELECT id_curso, nombre FROM Cursos 
        WHERE nombre IN ({placeholders})
        """, nombres_cursos)
        
        cursos = cursor.fetchall()

        sql_plan = """
        INSERT INTO Plan_Estudios (id_carrera, id_curso, id_semestre)
        VALUES (%s, %s, %s)
        ON DUPLICATE KEY UPDATE id_carrera=id_carrera
        """

        for c in cursos:
            cursor.execute(sql_plan, (id_carrera_sis, c["id_curso"], id_sem))

        print("✔ Plan de estudios del 1er semestre creado.")
        
        
        
        # ====================================================
        # NUEVOS BLOQUES PARA EL SEGUNDO SEMESTRE
        # ====================================================


        # ----------------------------------------------------
        # 5. INSERTAR CURSOS DEL SEGUNDO SEMESTRE DE SISTEMAS (CRÉDITOS ACTUALIZADOS)
        # ----------------------------------------------------
        # Cursos: (Nombre, Créditos, Nombre del Archivo PDF del Silabo)
        # Actualizado según los datos del usuario:
        # Diseño (2), Química (4), Sociología (2), Algoritmos (3), Cálculo I (4), Álgebra (4), Física I (4)
        cursos_sistemas_2 = [
            ("DISEÑO PARA INGENIERIA", 2, "DISEÑO.pdf"),          # Actualizado de 4 a 2
            ("QUIMICA GENERAL", 4, "QUIMICA_GENERAL.pdf"),
            ("SOCIOLOGIA RURAL Y AMAZONICA", 2, "SOCIOLOGIA.pdf"),# Actualizado de 3 a 2
            ("ALGORITMOS Y PROGRAMACIÓN", 3, "ALGORITMOS.pdf"),   # Actualizado de 4 a 3
            ("CALCULO I", 4, "CALCULI.pdf"),
            ("ALGEBRA LINEAL", 4, "ALGEBRA_LINEAL.pdf"),
            ("FISICA I", 4, "FISICAI.pdf")
        ]

        # La consulta ahora insertará la ruta del silabo. 
        # Se usa ON DUPLICATE KEY UPDATE para actualizar explícitamente los campos.
        sql_curso_2 = """
        INSERT INTO Cursos (nombre, creditos, silabo)
        VALUES (%s, %s, %s)
        ON DUPLICATE KEY UPDATE creditos=VALUES(creditos), silabo=VALUES(silabo) 
        """

        for nombre, creditos, archivo_silabo in cursos_sistemas_2:
            # Construir la ruta completa usando las variables base y la fija
            ruta_silabo = f"{DISCO_UNIDAD}{DIRECTORIO_SILABOS}\\{archivo_silabo}"
            
            cursor.execute(sql_curso_2, (nombre, creditos, ruta_silabo))

        print("✔ Cursos del 2do semestre insertados con la ruta del silabo (el trigger generó unidades).")


        # ----------------------------------------------------
        # 6. CREAR EL PLAN DE ESTUDIOS PARA S2 (NUEVO)
        # ----------------------------------------------------
        # Obtener id_semestre = 2 (si no existe lo creamos)
        cursor.execute("SELECT id_semestre FROM Semestres WHERE numero=2")
        result_sem_2 = cursor.fetchone()

        if result_sem_2:
            id_sem_2 = result_sem_2["id_semestre"]
        else:
            cursor.execute("INSERT INTO Semestres (numero, descripcion) VALUES (2, 'Segundo Semestre')")
            id_sem_2 = cursor.lastrowid

        print("✔ Semestre 2 verificado.")

        # Obtener cursos recién insertados del S2:
        nombres_cursos_2 = [c[0] for c in cursos_sistemas_2]

        # Crear un string con placeholders para la consulta IN
        placeholders_2 = ', '.join(['%s'] * len(nombres_cursos_2))

        cursor.execute(f"""
        SELECT id_curso, nombre FROM Cursos 
        WHERE nombre IN ({placeholders_2})
        """, nombres_cursos_2)

        cursos_2 = cursor.fetchall()

        # Usamos el mismo SQL para el plan de estudios
        sql_plan_2 = """
        INSERT INTO Plan_Estudios (id_carrera, id_curso, id_semestre)
        VALUES (%s, %s, %s)
        ON DUPLICATE KEY UPDATE id_carrera=id_carrera
        """

        for c in cursos_2:
            # Insertamos con el id_semestre 2
            cursor.execute(sql_plan_2, (id_carrera_sis, c["id_curso"], id_sem_2))

        print("✔ Plan de estudios del 2do semestre creado.")


        # ----------------------------------------------------
        # CONFIRMAR TODOS LOS CAMBIOS
        # ----------------------------------------------------
        connection.commit()
        print("\n✔✔ TODOS LOS DATOS HAN SIDO INSERTADOS CORRECTAMENTE (incluyendo S2) ✔✔")


finally:
    connection.close()
    print("Conexión cerrada.")