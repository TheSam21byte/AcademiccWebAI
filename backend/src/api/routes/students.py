from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from src.core.dependencies import get_db, get_current_student
# DAO: Acceso a datos

from repositories.student_repository import (
    get_academic_record_by_student
)
from src.services.student_service import (
    transform_academic_record,
    get_student_dashboard,
    get_student_courses,
    get_student_basic_info, # <--- Verifica que esté escrita IGUAL en el service
    get_student_course_detail
)

def _get_academic_record(db: Session, student_id: int):

    """
    Obtiene el registro académico base del estudiante autenticado.

    - Ejecuta la consulta a la vista SQL
    - Valida que existan resultados
    - Transforma la data plana en JSON jerárquico

    Este helper se reutiliza en todos los endpoints del módulo
    para evitar duplicar consultas y lógica.
    """

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
    
    """
    Devuelve el registro académico completo del estudiante autenticado.

    Uso:
    - Reportes académicos
    - Exportación de datos
    - Análisis con IA (Gemini)
    - Auditoría académica

    Retorna:
    - Información del estudiante
    - Periodo académico
    - Cursos, unidades y notas
    """

    return _get_academic_record(db, current_student["id_estudiante"])

@router.get("/me/basic")
def get_basic_info(
    db: Session = Depends(get_db),
    current_student: dict = Depends(get_current_student)
):
    
    """
    Devuelve información básica del estudiante autenticado.

    Uso:
    - Header de la aplicación
    - Sidebar
    - Perfil resumido

    Retorna:
    - Nombre completo
    - Código universitario
    - Carrera
    """

    record = _get_academic_record(db, current_student["id_estudiante"])
    return get_student_basic_info(record)

@router.get("/me/courses")
def get_courses(
    db: Session = Depends(get_db),
    current_student: dict = Depends(get_current_student)
):
    
    """
    Devuelve la lista de cursos matriculados por el estudiante
    en el periodo académico actual.

    Uso:
    - Vista general de cursos
    - Selección de curso
    - Resumen académico

    Retorna:
    - Nombre del curso
    - Créditos
    - Estado final
    - Promedio final
    """

    record = _get_academic_record(db, current_student["id_estudiante"])
    return get_student_courses(record)

@router.get("/me/courses/{curso}")
def get_course_detail(
    curso: str,
    db: Session = Depends(get_db),
    current_student: dict = Depends(get_current_student)
):
    
    """
    Devuelve el detalle completo de un curso específico del estudiante.

    Uso:
    - Vista detallada del curso
    - Análisis por unidades
    - Seguimiento del rendimiento

    Parámetros:
    - curso: nombre del curso (URL encoded)

    Retorna:
    - Información del curso
    - Docente
    - Estado y promedio final
    - Unidades con notas
    """

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
    
    """
    Devuelve un resumen académico agregado del estudiante.

    Uso:
    - Dashboard principal
    - Indicadores académicos
    - Alertas tempranas
    - Visualizaciones y métricas

    Retorna:
    - Total de cursos
    - Cursos aprobados
    - Cursos desaprobados
    - Promedio general
    """

    record = _get_academic_record(db, current_student["id_estudiante"])
    return get_student_dashboard(record)
