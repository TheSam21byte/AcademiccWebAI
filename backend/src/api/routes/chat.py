from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from core.dependencies import get_db, get_current_student
from repositories.student_repository import get_academic_record_by_student
from services.student_service import transform_academic_record
from schemas.chat_schema import ChatRequest, ChatResponse
from services.chat_services import build_prompt, simple_mock_answer

router = APIRouter(prefix="/ai", tags=["ai"])


def _get_academic_record(db: Session, student_id: int) -> dict | None:
    rows = get_academic_record_by_student(db, student_id)
    if not rows:
        return None
    return transform_academic_record(rows)


@router.post("/chat", response_model=ChatResponse)
def chat(
    payload: ChatRequest,
    db: Session = Depends(get_db),
    current_student: dict = Depends(get_current_student)
):
    """
    Endpoint de conversación MIYABI (protegido).
    - Obtiene id_estudiante del JWT
    - Construye contexto académico
    - Devuelve respuesta (mock por ahora)
    """
    student_id = current_student["id_estudiante"]
    record = _get_academic_record(db, student_id)

    # Prompt listo para Gemini (todavía no se llama)
    _prompt = build_prompt(payload.message, record)

    # Respuesta mock para probar el frontend ya mismo
    answer = simple_mock_answer(payload.message, record)

    return {"response": answer}
