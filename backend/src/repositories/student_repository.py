from sqlalchemy.orm import Session
from models.student import Student

def get_student_by_codigo(db: Session, codigo: str):
    return (
        db.query(Student)
        .filter(Student.codigo_universitario == codigo)
        .first()
    )
