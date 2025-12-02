import pymysql
import random
import os
import sys

# ----------------------------------------------------
# CONFIGURACIÓN DE CONEXIÓN
# ----------------------------------------------------
# NOTA: Asegúrate de que tu servidor MySQL esté corriendo.
try:
    connection = pymysql.connect(
        host="localhost",
        user="root",
        password="1234",
        database="uniia",
        charset="utf8mb4",
        cursorclass=pymysql.cursors.DictCursor
    )
    print("Conexión a MySQL exitosa.")
except pymysql.err.OperationalError as e:
    print(f"Error al conectar a MySQL. Asegúrate de que el servidor esté activo y las credenciales sean correctas: {e}")
    sys.exit(1) # Salir si no se puede conectar

# ----------------------------------------------------
# CONFIGURACIÓN DE RUTAS DE SILABOS
# ----------------------------------------------------
DISCO_UNIDAD = r'D:\8VO SEMESTRE\IA\DB Prueba Insertación de Datos' 
DIRECTORIO_SILABOS = r'\database\S2022-2'

# Datos base para generar estudiantes aleatorios
NOMBRES = ['Alejandro', 'Sofía', 'Daniel', 'Valentina', 'Mateo', 'Isabella', 'Sebastián', 'Camila', 'Gabriel', 'Luciana', 
            'Adrián', 'Valeria', 'Javier', 'María', 'Emilio', 'Elena', 'Diego', 'Paula', 'Nicolás', 'Andrea']
APELLIDOS = ['García', 'Rodríguez', 'González', 'Fernández', 'López', 'Martínez', 'Sánchez', 'Pérez', 'Gómez', 'Díaz', 
             'Vargas', 'Torres', 'Castro', 'Mendoza', 'Rojas', 'Flores', 'Silva', 'Espinoza', 'Herrera', 'Acuña']

# Docentes base: 8 para S1, 7 para S2 (Total 15)
# Formato: (DNI, Nombre, Apellido Paterno, Apellido Materno, Celular)
DOCENTES_DATA = [
    # Docentes para el 1er Semestre (8)
    ('70000001', 'Ricardo', 'Vargas', 'Torres', '91000001'),
    ('70000002', 'Luisa', 'Mendoza', 'Rojas', '91000002'),
    ('70000003', 'Carlos', 'Flores', 'Silva', '91000003'),
    ('70000004', 'Elena', 'Espinoza', 'Herrera', '91000004'),
    ('70000005', 'Javier', 'Acuña', 'López', '91000005'),
    ('70000006', 'Ana', 'Sánchez', 'Díaz', '91000006'),
    ('70000007', 'Miguel', 'Pérez', 'Gómez', '91000007'),
    ('70000008', 'Teresa', 'Martínez', 'Castro', '91000008'),
    # Docentes para el 2do Semestre (7)
    ('70000009', 'Héctor', 'Fernández', 'García', '91000009'),
    ('70000010', 'Sofía', 'Rodríguez', 'González', '91000010'),
    ('70000011', 'Jorge', 'Gómez', 'Vargas', '91000011'),
    ('70000012', 'Marta', 'Díaz', 'Torres', '91000012'),
    ('70000013', 'Andrés', 'Castro', 'Mendoza', '91000013'),
    ('70000014', 'Laura', 'Rojas', 'Flores', '91000014'),
    ('70000015', 'Pedro', 'Silva', 'Espinoza', '91000015')
]


# Parámetros de generación (Originales)
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
            "Ingeniería Agroindustrial", "Ingeniería Forestal", "Ingeniería de Sistemas e Informática",
            "Medicina Veterinaria", "Educación Matemática", "Derecho", "Enfermería",
            "Ecoturismo", "Administración", "Contabilidad"
        ]
        
        sql_carrera = "INSERT IGNORE INTO Carreras (id_carrera, nombre) VALUES (%s, %s)"
        for i, c in enumerate(carreras, 1):
            cursor.execute(sql_carrera, (i, c))
        print("✔ 1. Carreras insertadas o verificadas (usando INSERT IGNORE).")

        # ----------------------------------------------------
        # 2. INSERTAR DOCENTES (NUEVO)
        # ----------------------------------------------------
        sql_docentes = """
        INSERT IGNORE INTO Docentes 
        (dni, nombre, apellidop, apellidom, celular)
        VALUES (%s, %s, %s, %s, %s)
        """
        
        cursor.executemany(sql_docentes, DOCENTES_DATA)
        print(f"✔ 2. {len(DOCENTES_DATA)} Docentes insertados o verificados (usando INSERT IGNORE).")
        
        # Obtener los id_docente recién insertados o existentes
        dnis_docentes = [d[0] for d in DOCENTES_DATA]
        placeholders_dni = ', '.join(['%s'] * len(dnis_docentes))
        
        cursor.execute(f"SELECT id_docente FROM Docentes WHERE dni IN ({placeholders_dni}) ORDER BY dni", dnis_docentes)
        docente_ids = [row["id_docente"] for row in cursor.fetchall()]
        
        if len(docente_ids) == 0:
            print("❌ ERROR CRÍTICO: No se pudieron obtener IDs de docentes. La base de datos está vacía o hay un problema con la consulta.")
            # Lanzamos una excepción para detener el commit
            raise Exception("No se encontraron IDs de docentes para la asignación.")
            
        # OBTENER ID DEL PRIMER DOCENTE PARA USAR COMO TEMPORAL (SOLUCIONA EL ERROR 1364)
        placeholder_docente_id = docente_ids[0]

        # Dividir IDs de docentes para S1 (primeros 8) y S2 (últimos 7)
        docente_ids_s1 = docente_ids[:8]
        docente_ids_s2 = docente_ids[8:]


        # ----------------------------------------------------
        # 3. INSERTAR 30 ESTUDIANTES ALEATORIOS (Bloque original, re-numerado)
        # ----------------------------------------------------
        sql_est = """
        INSERT IGNORE INTO Estudiantes 
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
        print(f"✔ 3. {NUM_ESTUDIANTES} Estudiantes de Ingeniería de Sistemas insertados o verificados.")


        # ----------------------------------------------------
        # 4. INSERTAR CURSOS DEL PRIMER SEMESTRE DE SISTEMAS 
        #    (SE INSERTA id_docente TEMPORALMENTE para evitar el error NOT NULL)
        # ----------------------------------------------------
        cursos_sistemas_1 = [
            "ALGORITMOS INTRODUCTORIOS", "CULTURA DE PAZ Y DEFENSA NACIONAL",
            "REDACCION TECNICA Y CIENTIFICA", "COMPLEMENTO DE MATEMATICA",
            "LENGUAJE Y COMUNICACION", "INTRODUCCION A INGENIERIA DE SISTEMAS",
            "ECOLOGIA GENERAL Y RECURSOS NATURALES", "ACTIVIDADES CULTURALES Y/O DEPORTIVAS"
        ] # 8 Cursos
        creditos_s1 = [3, 2, 2, 4, 3, 3, 3, 2] # Créditos correspondientes

        # MODIFICACIÓN: Incluir id_docente con el valor placeholder
        sql_curso_1 = """
        INSERT INTO Cursos (nombre, creditos, silabo, id_docente)
        VALUES (%s, %s, 'Silabo por definir', %s)
        ON DUPLICATE KEY UPDATE creditos=VALUES(creditos) 
        """

        for nombre, creditos in zip(cursos_sistemas_1, creditos_s1):
            # Se pasa el id_docente temporal
            cursor.execute(sql_curso_1, (nombre, creditos, placeholder_docente_id))

        print("✔ 4. Cursos del 1er semestre insertados/actualizados con id_docente temporal.")

        # Obtener los IDs de los cursos insertados de S1
        placeholders_s1 = ', '.join(['%s'] * len(cursos_sistemas_1))
        cursor.execute(f"""
        SELECT id_curso, nombre FROM Cursos 
        WHERE nombre IN ({placeholders_s1})
        ORDER BY nombre
        """, tuple(cursos_sistemas_1))
        cursos_s1_map = cursor.fetchall()

        # ----------------------------------------------------
        # 5. ASIGNAR DOCENTES A CURSOS DE S1 (AHORA SE HACE LA ASIGNACIÓN DEFINITIVA)
        # ----------------------------------------------------
        if len(cursos_s1_map) == len(docente_ids_s1):
            print(f"   Iniciando asignación de {len(cursos_s1_map)} docentes a cursos de S1...")
            
            # Crear una lista de tuplas (id_docente, id_curso)
            updates_s1 = []
            for i, curso in enumerate(cursos_s1_map):
                id_curso = curso['id_curso']
                # Se asigna el ID de docente definitivo de la lista
                id_docente = docente_ids_s1[i] 
                updates_s1.append((id_docente, id_curso))
            
            sql_update_s1 = "UPDATE Cursos SET id_docente = %s WHERE id_curso = %s"
            cursor.executemany(sql_update_s1, updates_s1)
            print("✔ 5. Docentes asignados definitivamente a los cursos del 1er semestre.")
        else:
            print("⚠️ ERROR: El número de cursos y docentes de S1 no coincide. No se realizó la asignación definitiva.")


        # ----------------------------------------------------
        # 6. CREAR EL PLAN DE ESTUDIOS PARA S1 (Bloque original, re-numerado)
        # ----------------------------------------------------
        cursor.execute("SELECT id_carrera FROM Carreras WHERE nombre='Ingeniería de Sistemas e Informática'")
        id_carrera_sis = cursor.fetchone()["id_carrera"]

        cursor.execute("INSERT IGNORE INTO Semestres (numero, descripcion) VALUES (1, 'Primer Semestre')")
        cursor.execute("SELECT id_semestre FROM Semestres WHERE numero=1")
        id_sem = cursor.fetchone()["id_semestre"]

        print("✔ 6. Semestre 1 verificado.")

        sql_plan = """
        INSERT INTO Plan_Estudios (id_carrera, id_curso, id_semestre)
        VALUES (%s, %s, %s)
        ON DUPLICATE KEY UPDATE id_carrera=id_carrera
        """

        for c in cursos_s1_map:
            cursor.execute(sql_plan, (id_carrera_sis, c["id_curso"], id_sem))

        print("✔ 6. Plan de estudios del 1er semestre creado.")
        
        
        # ====================================================
        # CONTINUACIÓN PARA EL SEGUNDO SEMESTRE
        # ====================================================

        # ----------------------------------------------------
        # 7. INSERTAR CURSOS DEL SEGUNDO SEMESTRE DE SISTEMAS 
        #    (SE INSERTA id_docente TEMPORALMENTE para evitar el error NOT NULL)
        # ----------------------------------------------------
        cursos_sistemas_2_data = [
            ("DISEÑO PARA INGENIERIA", 2, "DISEÑO.pdf"),
            ("QUIMICA GENERAL", 4, "QUIMICA_GENERAL.pdf"),
            ("SOCIOLOGIA RURAL Y AMAZONICA", 2, "SOCIOLOGIA.pdf"),
            ("ALGORITMOS Y PROGRAMACIÓN", 3, "ALGORITMOS.pdf"),
            ("CALCULO I", 4, "CALCULI.pdf"),
            ("ALGEBRA LINEAL", 4, "ALGEBRA_LINEAL.pdf"),
            ("FISICA I", 4, "FISICAI.pdf")
        ] # 7 Cursos

        # MODIFICACIÓN: Incluir id_docente con el valor placeholder
        sql_curso_2 = """
        INSERT INTO Cursos (nombre, creditos, silabo, id_docente)
        VALUES (%s, %s, %s, %s)
        ON DUPLICATE KEY UPDATE creditos=VALUES(creditos), silabo=VALUES(silabo) 
        """

        for nombre, creditos, archivo_silabo in cursos_sistemas_2_data:
            ruta_silabo = os.path.join(DISCO_UNIDAD, DIRECTORIO_SILABOS, archivo_silabo)
            # Se pasa el id_docente temporal
            cursor.execute(sql_curso_2, (nombre, creditos, ruta_silabo, placeholder_docente_id))

        print("✔ 7. Cursos del 2do semestre insertados/actualizados con la ruta del silabo y id_docente temporal.")
        
        # Obtener los IDs de los cursos insertados de S2
        nombres_cursos_2 = [c[0] for c in cursos_sistemas_2_data]
        placeholders_s2 = ', '.join(['%s'] * len(nombres_cursos_2))
        cursor.execute(f"""
        SELECT id_curso, nombre FROM Cursos 
        WHERE nombre IN ({placeholders_s2})
        ORDER BY nombre
        """, tuple(nombres_cursos_2))
        cursos_s2_map = cursor.fetchall()
        
        
        # ----------------------------------------------------
        # 8. ASIGNAR DOCENTES A CURSOS DE S2 (ASIGNACIÓN DEFINITIVA)
        # ----------------------------------------------------
        if len(cursos_s2_map) == len(docente_ids_s2):
            print(f"   Iniciando asignación de {len(cursos_s2_map)} docentes a cursos de S2...")
            
            # Crear una lista de tuplas (id_docente, id_curso)
            updates_s2 = []
            for i, curso in enumerate(cursos_s2_map):
                id_curso = curso['id_curso']
                # Se asigna el ID de docente definitivo de la lista
                id_docente = docente_ids_s2[i]
                updates_s2.append((id_docente, id_curso))
            
            sql_update_s2 = "UPDATE Cursos SET id_docente = %s WHERE id_curso = %s"
            cursor.executemany(sql_update_s2, updates_s2)
            print("✔ 8. Docentes asignados definitivamente a los cursos del 2do semestre.")
        else:
            print("⚠️ ERROR: El número de cursos y docentes de S2 no coincide. No se realizó la asignación definitiva.")
        
        
        # ----------------------------------------------------
        # 9. CREAR EL PLAN DE ESTUDIOS PARA S2 (Bloque original, re-numerado)
        # ----------------------------------------------------
        cursor.execute("INSERT IGNORE INTO Semestres (numero, descripcion) VALUES (2, 'Segundo Semestre')")
        cursor.execute("SELECT id_semestre FROM Semestres WHERE numero=2")
        id_sem_2 = cursor.fetchone()["id_semestre"]

        print("✔ 9. Semestre 2 verificado.")

        # Usamos el mismo SQL para el plan de estudios
        sql_plan_2 = """
        INSERT INTO Plan_Estudios (id_carrera, id_curso, id_semestre)
        VALUES (%s, %s, %s)
        ON DUPLICATE KEY UPDATE id_carrera=id_carrera
        """

        for c in cursos_s2_map:
            cursor.execute(sql_plan_2, (id_carrera_sis, c["id_curso"], id_sem_2))

        print("✔ 9. Plan de estudios del 2do semestre creado.")


        # ----------------------------------------------------
        # CONFIRMAR TODOS LOS CAMBIOS
        # ----------------------------------------------------
        connection.commit()
        print("\n✔✔ TODOS LOS DATOS HAN SIDO INSERTADOS Y ACTUALIZADOS CORRECTAMENTE (incluyendo docentes) ✔✔")


finally:
    connection.close()
    print("Conexión cerrada.")