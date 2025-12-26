from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from core.dependencies import get_db, get_current_student
from repositories.student_repository import get_academic_record_by_student
from services.student_service import transform_academic_record
from schemas.chat_schema import ChatRequest, ChatResponse
# 1. IMPORTANTE: Cambiamos simple_mock_answer por get_ai_answer
from services.chat_services import build_prompt, get_ai_answer 

router = APIRouter(prefix="/ai", tags=["ai"])

def _get_academic_record(db: Session, student_id: int) -> dict | None:
    rows = get_academic_record_by_student(db, student_id)
    if not rows:
        return None
    return transform_academic_record(rows)

# 2. CAMBIO: Agregamos 'async' para manejar la espera de la IA
@router.post("/chat", response_model=ChatResponse)
async def chat(
    payload: ChatRequest,
    db: Session = Depends(get_db),
    current_student: dict = Depends(get_current_student)
):
    """
    Endpoint de conversación MIYABI conectado a Gemini 2.5 Flash.
    """
    student_id = current_student["id_estudiante"]
    record = _get_academic_record(db, student_id)

    # 3. CAMBIO: Llamamos a la función real de IA con 'await'
    # Esta función utiliza el GEMINI_MODEL y GEMINI_API_URL definidos en tu .env
    answer = await get_ai_answer(payload.message, record)

    return {"response": answer}