from sqlalchemy.orm import Session
from repositories.student_repository import get_student_by_codigo
from core.security import create_access_token

def authenticate_student(db: Session, codigo: str, password: str):
    student = get_student_by_codigo(db, codigo)

    if not student:
        return None

    if student.dni != password:
        return None

    token_data = {
        "sub": str(student.id_estudiante),
        "codigo": student.codigo_universitario,
        "nombre": student.nombre,
        "id_carrera": student.id_carrera
    }

    return create_access_token(token_data)
