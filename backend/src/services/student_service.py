from sqlalchemy.orm import Session
from sqlalchemy import text

def transform_academic_record(rows):
    if not rows:
        return None
    
    first = rows[0]
    response = {
        "estudiante": {
            "id": first["id_estudiante"],
            "codigo": first["codigo_universitario"],
            "nombre": first["nombre_completo"],
            "carrera": first["nombre_carrera"]
        },
        "periodo": first["periodo_academico"],
        "cursos": []
    }

    cursos = {}
    for row in rows:
        curso_key = row["nombre_curso"]
        if curso_key not in cursos:
            cursos[curso_key] = {
                "nombre": row["nombre_curso"],
                "creditos": row["creditos"],
                "semestre": row["semestre_malla"],
                "docente": row["docente_curso"],
                "promedio_final": float(row["promedio_final"]) if row["promedio_final"] else 0.0,
                "estado": row["estado_final_curso"],
                "unidades": []
            }

        unidades_existentes = [u["numero"] for u in cursos[curso_key]["unidades"]]
        if row["numero_unidad"] not in unidades_existentes:
            cursos[curso_key]["unidades"].append({
                "numero": row["numero_unidad"],
                "nota_actitudinal": float(row["nota_actitudinal"]) if row["nota_actitudinal"] else 0.0,
                "nota_procedimental": float(row["nota_procedimental"]) if row["nota_procedimental"] else 0.0,
                "nota_conceptual": float(row["nota_conceptual"]) if row["nota_conceptual"] else 0.0,
                "promedio": float(row["promedio_unidad"]) if row["promedio_unidad"] else 0.0
            })

    response["cursos"] = list(cursos.values())
    return response

# --- FUNCIONES REQUERIDAS POR EL ROUTER ---

def get_student_dashboard(academic_record: dict):
    cursos = academic_record["cursos"]
    total = len(cursos)
    aprobados = sum(1 for c in cursos if c["estado"] == "APROBADO")
    promedio_general = sum(c["promedio_final"] for c in cursos) / total if total > 0 else 0
    return {
        "total_cursos": total,
        "aprobados": aprobados,
        "desaprobados": total - aprobados,
        "promedio_general": round(promedio_general, 2)
    }

def get_student_basic_info(academic_record: dict):
    est = academic_record["estudiante"]
    return {
        "nombre": est["nombre"],
        "codigo": est["codigo"],
        "carrera": est["carrera"]
    }

def get_student_courses(academic_record: dict):
    return [
        {
            "nombre": c["nombre"],
            "creditos": c["creditos"],
            "estado": c["estado"],
            "promedio_final": c["promedio_final"]
        }
        for c in academic_record["cursos"]
    ]

def get_student_course_detail(academic_record: dict, course_name: str):
    for c in academic_record["cursos"]:
        if c["nombre"].lower() == course_name.lower():
            return c
    return None

def get_full_academic_data(db: Session, student_id: int):
    query = text("SELECT * FROM perfil_estudiante_completo WHERE id_estudiante = :id")
    result = db.execute(query, {"id": student_id}).mappings().all()
    if not result:
        return None
    return transform_academic_record(result)