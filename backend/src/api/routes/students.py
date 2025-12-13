from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from core.dependencies import get_db, get_current_student
from repositories.student_repository import (
    get_academic_record_by_student
)
from services.student_service import (
    transform_academic_record,
    get_student_basic_info,            
    get_student_courses,
    get_student_course_detail,
    get_student_dashboard
)

def _get_academic_record(db: Session, student_id: int):
    rows = get_academic_record_by_student(db, student_id)
    
    if not rows:
        raise HTTPException(
            status_code=404,
            detail="No se encontraron registros académicos"
        )
    return transform_academic_record(rows)

router = APIRouter(
    prefix="/students",
    tags=["students"]
)

@router.get("/me/academic-record")
def get_my_academic_record(
    db: Session = Depends(get_db),
    current_student: dict = Depends(get_current_student)
):
    return _get_academic_record(db, current_student["id_estudiante"])

@router.get("/me/basic")
def get_basic_info(
    db: Session = Depends(get_db),
    current_student: dict = Depends(get_current_student)
):
    record = _get_academic_record(db, current_student["id_estudiante"])
    return get_student_basic_info(record)

@router.get("/me/courses")
def get_courses(
    db: Session = Depends(get_db),
    current_student: dict = Depends(get_current_student)
):
    record = _get_academic_record(db, current_student["id_estudiante"])
    return get_student_courses(record)

@router.get("/me/courses/{curso}")
def get_course_detail(
    curso: str,
    db: Session = Depends(get_db),
    current_student: dict = Depends(get_current_student)
):
    record = _get_academic_record(db, current_student["id_estudiante"])
    course = get_student_course_detail(record, curso)

    if not course:
        raise HTTPException(404, "Curso no encontrado")

    return course

@router.get("/me/dashboard")
def get_dashboard(
    db: Session = Depends(get_db),
    current_student: dict = Depends(get_current_student)
):
    record = _get_academic_record(db, current_student["id_estudiante"])
    return get_student_dashboard(record)
