import pymysql

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

try:
    with connection.cursor() as cursor:

        # ----------------------------------------------------
        # 1. INSERTAR CARRERAS
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

        sql = "INSERT INTO Carreras (nombre) VALUES (%s)"
        for c in carreras:
            cursor.execute(sql, (c,))
        print("✔ Carreras insertadas.")


        # ----------------------------------------------------
        # 2. INSERTAR UN ESTUDIANTE DE PRUEBA
        # ----------------------------------------------------
        sql_est = """
        INSERT INTO Estudiantes 
        (codigo_universitario, dni, nombre, apellidop, apellidom, id_carrera)
        VALUES (%s, %s, %s, %s, %s, %s)
        """

        cursor.execute(sql_est, (
            "20250001",
            "12345678",
            "Luis",
            "Ramírez",
            "Torres",
            3  # Ingeniería de Sistemas (posición 3 en la lista)
        ))
        print("✔ Estudiante insertado.")


        # ----------------------------------------------------
        # 3. INSERTAR CURSOS DEL PRIMER SEMESTRE DE SISTEMAS
        # ----------------------------------------------------
        cursos_sistemas_1 = [
            ("ALGORITMOS", 3),
            ("CULTURA DE PAZ Y DEFENSA NACIONAL", 2),
            ("REDACCION TECNICA Y CIENTIFICA", 2),
            ("COMPLEMENTO DE MATEMATICA", 4),
            ("LENGUAJE Y COMUNICACION", 3),
            ("INTRODUCCION A INGENIERIA DE SISTEMAS", 3),
            ("ECOLOGIA GENERAL Y RECURSOS NATURALES", 3),
            ("ACTIVIDADES CULTURALES Y/O DEPORTIVAS", 2)
        ]

        sql_curso = """
        INSERT INTO Cursos (nombre, creditos, silabo)
        VALUES (%s, %s, 'Silabo por definir')
        """

        for nombre, creditos in cursos_sistemas_1:
            cursor.execute(sql_curso, (nombre, creditos))

        print("✔ Cursos del 1er semestre insertados (el trigger generó unidades).")


        # ----------------------------------------------------
        # 4. CREAR EL PLAN DE ESTUDIOS PARA ESTOS CURSOS
        # ----------------------------------------------------
        # Obtener id_carrera de Ingeniería de Sistemas
        cursor.execute("SELECT id_carrera FROM Carreras WHERE nombre='Ingeniería de Sistemas e Informática'")
        id_carrera_sis = cursor.fetchone()["id_carrera"]

        # Obtener id_semestre = 1 (si no existe lo creamos)
        cursor.execute("SELECT id_semestre FROM Semestres WHERE numero=1")
        result_sem = cursor.fetchone()

        if result_sem:
            id_sem = result_sem["id_semestre"]
        else:
            cursor.execute("INSERT INTO Semestres (numero, descripcion) VALUES (1, 'Primer Semestre')")
            id_sem = cursor.lastrowid

        print("✔ Semestre 1 verificado.")

        # Obtener cursos recién insertados:
        cursor.execute("""
        SELECT id_curso, nombre FROM Cursos 
        WHERE nombre IN (
            'ALGORITMOS',
            'CULTURA DE PAZ Y DEFENSA NACIONAL',
            'REDACCION TECNICA Y CIENTIFICA',
            'COMPLEMENTO DE MATEMATICA',
            'LENGUAJE Y COMUNICACION',
            'INTRODUCCION A INGENIERIA DE SISTEMAS',
            'ECOLOGIA GENERAL Y RECURSOS NATURALES',
            'ACTIVIDADES CULTURALES Y/O DEPORTIVAS'
        )
        """)
        cursos = cursor.fetchall()

        sql_plan = """
        INSERT INTO Plan_Estudios (id_carrera, id_curso, id_semestre)
        VALUES (%s, %s, %s)
        """

        for c in cursos:
            cursor.execute(sql_plan, (id_carrera_sis, c["id_curso"], id_sem))

        print("✔ Plan de estudios del 1er semestre creado.")

        # ----------------------------------------------------
        # CONFIRMAR TODOS LOS CAMBIOS
        # ----------------------------------------------------
        connection.commit()
        print("\n✔✔ TODOS LOS DATOS HAN SIDO INSERTADOS CORRECTAMENTE ✔✔")

finally:
    connection.close()
    print("Conexión cerrada.")
