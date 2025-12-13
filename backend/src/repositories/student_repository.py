from sqlalchemy import text
from sqlalchemy.orm import Session
from models.student import Student

def get_academic_record_by_student(
    db: Session, 
    student_id: int    
):
    query = text("""
        SELECT *
        FROM uniia.perfil_estudiante_completo
        WHERE id_estudiante = :student_id
        ORDER BY nombre_curso, numero_unidad
    """)

    result = db.execute(
        query,
        {"student_id": student_id}
    )
    
    return [dict(row._mapping) for row in result]

def get_student_by_codigo(db: Session, codigo: str):
    return (
        db.query(Student)
        .filter(Student.codigo_universitario == codigo)
        .first()
    )
