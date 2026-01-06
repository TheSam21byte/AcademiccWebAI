from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

# Importaciones estandarizadas con el prefijo src.
from src.core.dependencies import get_db, get_current_student
from src.repositories.student_repository import get_academic_record_by_student
from src.services.student_service import transform_academic_record
from src.schemas.chat_schema import ChatRequest, ChatResponse
from src.services.chat_services import get_ai_answer

router = APIRouter(prefix="/ai", tags=["ai"])

def _get_academic_record(db: Session, student_id: int) -> dict | None:
    """Obtiene y transforma el récord académico desde la base de datos."""
    rows = get_academic_record_by_student(db, student_id)
    if not rows:
        return None
    return transform_academic_record(rows)

@router.post("/chat", response_model=ChatResponse)
async def chat(
    payload: ChatRequest,
    db: Session = Depends(get_db),
    current_student: dict = Depends(get_current_student) 
):
    """
    Endpoint del chat que utiliza la identidad del estudiante logueado.
    """
    # SOLUCIÓN AL ERROR: Accedemos como diccionario usando ['id'] o .get('id')
    student_id = current_student.get("id")
    
    if not student_id:
        # Si tu base de datos usa 'id_estudiante' en lugar de 'id', cámbialo aquí
        student_id = current_student.get("id_estudiante")

    if not student_id:
        raise HTTPException(
            status_code=401, 
            detail="No se pudo identificar el ID del estudiante en el token."
        )

    # 1. Obtener datos reales de la base de datos para ESTE estudiante
    record = _get_academic_record(db, student_id)

    # 2. Si no hay record, creamos uno básico con su nombre real
    if not record:
        record = {
            "estudiante": {
                "nombre": current_student.get("nombre_completo", "Estudiante"),
                "carrera": current_student.get("carrera", "tu carrera")
            },
            "cursos": []
        }

    # 3. Extraer el historial de mensajes (si existe en el schema)
    history = getattr(payload, 'history', [])
    
    # 4. Llamar a la IA con los datos reales
    try:
        answer = await get_ai_answer(
            user_message=payload.message, 
            academic_record=record,
            history=history
        )
        return {"response": answer}
        
    except Exception as e:
        print(f"Error en chat_service: {str(e)}")
        raise HTTPException(status_code=500, detail="Error al procesar la respuesta de la IA")