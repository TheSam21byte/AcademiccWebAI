import pymysql
import sys

# --- CONFIGURACIÓN DE CONEXIÓN (Reemplaza con tus credenciales) ---
DB_HOST = "localhost"
DB_USER = "root"
DB_PASSWORD = "1234"
DB_NAME = "uniia"

# DATOS PARA DOCENTES (15 Docentes)
DOCENTES_DATA = [
    # Docentes S1 (8)
    ('70000001', 'Ricardo', 'Vargas', 'Torres', '91000001'),
    ('70000002', 'Luisa', 'Mendoza', 'Rojas', '91000002'),
    ('70000003', 'Carlos', 'Flores', 'Silva', '91000003'),
    ('70000004', 'Elena', 'Espinoza', 'Herrera', '91000004'),
    ('70000005', 'Javier', 'Acuña', 'López', '91000005'),
    ('70000006', 'Ana', 'Sánchez', 'Díaz', '91000006'),
    ('70000007', 'Miguel', 'Pérez', 'Gómez', '91000007'),
    ('70000008', 'Teresa', 'Martínez', 'Castro', '91000008'),
    # Docentes S2 (7)
    ('70000009', 'Héctor', 'Fernández', 'García', '91000009'),
    ('70000010', 'Sofía', 'Rodríguez', 'González', '91000010'),
    ('70000011', 'Jorge', 'Gómez', 'Vargas', '91000011'),
    ('70000012', 'Marta', 'Díaz', 'Torres', '91000012'),
    ('70000013', 'Andrés', 'Castro', 'Mendoza', '91000013'),
    ('70000014', 'Laura', 'Rojas', 'Flores', '91000014'),
    ('70000015', 'Pedro', 'Silva', 'Espinoza', '91000015')
]

# Nombres de cursos del S1 y S2 en el ORDEN en que serán asignados
CURSOS_NOMBRES_ORDENADOS = [
    "ALGORITMOS INTRODUCTORIOS", "CULTURA DE PAZ Y DEFENSA NACIONAL",
    "REDACCION TECNICA Y CIENTIFICA", "COMPLEMENTO DE MATEMATICA",
    "LENGUAJE Y COMUNICACION", "INTRODUCCION A INGENIERIA DE SISTEMAS",
    "ECOLOGIA GENERAL Y RECURSOS NATURALES", "ACTIVIDADES CULTURALES Y/O DEPORTIVAS",
    "DISEÑO PARA INGENIERIA", "QUIMICA GENERAL", "SOCIOLOGIA RURAL Y AMAZONICA",
    "ALGORITMOS Y PROGRAMACIÓN", "CALCULO I", "ALGEBRA LINEAL", "FISICA I"
]


try:
    connection = pymysql.connect(
        host=DB_HOST, user=DB_USER, password=DB_PASSWORD, database=DB_NAME,
        charset="utf8mb4", cursorclass=pymysql.cursors.DictCursor
    )
    print("Conexión a MySQL exitosa.")
except pymysql.err.OperationalError as e:
    print(f"Error al conectar a MySQL: {e}")
    sys.exit(1)

try:
    with connection.cursor() as cursor:

        print("--- INICIANDO PROCESO DE DOCENTES Y ASIGNACIÓN ---")

        # 1. INSERTAR DOCENTES
        sql_docentes = """
        INSERT IGNORE INTO Docentes 
        (dni, nombre, apellidop, apellidom, celular)
        VALUES (%s, %s, %s, %s, %s)
        """
        cursor.executemany(sql_docentes, DOCENTES_DATA)
        print(f"✔ 1. {len(DOCENTES_DATA)} Docentes insertados o verificados (INSERT IGNORE).")

        # 2. OBTENER IDs DE DOCENTES (Crucial para el paso 4)
        dnis_docentes = [d[0] for d in DOCENTES_DATA]
        placeholders_dni = ', '.join(['%s'] * len(dnis_docentes))
        
        # Recuperamos IDs y nos aseguramos de que el orden de los IDs coincida con el orden de DOCENTES_DATA
        cursor.execute(f"""
            SELECT id_docente FROM Docentes WHERE dni IN ({placeholders_dni}) 
            ORDER BY id_docente ASC
        """, dnis_docentes)
        docente_ids = [row["id_docente"] for row in cursor.fetchall()]

        if len(docente_ids) != len(DOCENTES_DATA):
            print("❌ ERROR: No se recuperaron todos los IDs de docentes. La asignación 1:1 podría fallar.")
        
        print(f"✔ 2. IDs de docentes recuperados: {len(docente_ids)}")

        # 3. OBTENER IDs DE CURSOS (En el orden de asignación)
        placeholders_cursos = ', '.join(['%s'] * len(CURSOS_NOMBRES_ORDENADOS))
        
        # OBTENEMOS LOS IDs de curso y los mapeamos por su nombre
        cursos_query = f"""
            SELECT id_curso, nombre FROM Cursos 
            WHERE nombre IN ({placeholders_cursos})
        """
        cursor.execute(cursos_query, tuple(CURSOS_NOMBRES_ORDENADOS))
        cursos_data = cursor.fetchall()
        
        # Convertir a un diccionario para obtener los IDs en el orden exacto de CURSOS_NOMBRES_ORDENADOS
        cursos_map = {row['nombre']: row['id_curso'] for row in cursos_data}
        
        # Creamos la lista de IDs de cursos en el orden EXACTO deseado para la asignación
        curso_ids_ordenados = [cursos_map.get(nombre) for nombre in CURSOS_NOMBRES_ORDENADOS if cursos_map.get(nombre) is not None]

        if len(curso_ids_ordenados) != len(CURSOS_NOMBRES_ORDENADOS):
             print(f"❌ ERROR: Solo se encontraron {len(curso_ids_ordenados)} de {len(CURSOS_NOMBRES_ORDENADOS)} cursos.")
             raise Exception("Faltan cursos en la tabla 'Cursos'.")

        print(f"✔ 3. IDs de cursos recuperados y ordenados: {len(curso_ids_ordenados)}")


        # 4. ASIGNAR 1 DOCENTE POR 1 CURSO
        updates = []
        
        # Emparejamos Docente 1 con Curso 1, Docente 2 con Curso 2, etc.
        for id_docente, id_curso in zip(docente_ids, curso_ids_ordenados):
            updates.append((id_docente, id_curso)) 
        
        sql_update = "UPDATE Cursos SET id_docente = %s WHERE id_curso = %s"
        
        # Ejecutamos las actualizaciones
        cursor.executemany(sql_update, updates)
        
        print(f"✔ 4. Asignación completada: {len(updates)} cursos actualizados con su docente único.")

        connection.commit()
        print("\n✔✔ PROCESO FINALIZADO: ¡Docentes listos y Cursos asignados! ✔✔")

except Exception as e:
    print(f"\n❌ OCURRIÓ UN ERROR CRÍTICO: {e}")
    connection.rollback()
finally:
    connection.close()
    print("Conexión cerrada.")