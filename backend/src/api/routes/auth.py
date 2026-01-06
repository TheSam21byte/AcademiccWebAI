from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from jose import jwt
from datetime import datetime, timedelta

from src.schemas.auth_schema import LoginRequest, TokenResponse
from src.core.dependencies import get_db
from src.core.config import settings
# Corregido: Importamos Student, que es el nombre real en tu archivo
from src.models.student import Student 

router = APIRouter(prefix="/auth", tags=["auth"])

def create_access_token(data: dict):
    to_encode = data.copy()
    expire = datetime.utcnow() + timedelta(minutes=int(settings.JWT_EXPIRE_MINUTES))
    to_encode.update({"exp": expire})
    return jwt.encode(to_encode, settings.JWT_SECRET_KEY, algorithm=settings.JWT_ALGORITHM)

@router.post("/login", response_model=TokenResponse)
def login(data: LoginRequest, db: Session = Depends(get_db)):
    student = db.query(Student).filter(Student.codigo_universitario == data.codigo).first()

    if not student or str(student.dni) != str(data.password):
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Código universitario o DNI incorrectos"
        )

    token = create_access_token(data={"sub": str(student.id_estudiante)})

    # IMPORTANTE: Agrega "nombre" al return
    return {
        "access_token": token,
        "token_type": "bearer",
        "nombre": student.nombre  # <--- Esto es lo que lee el Navbar
    }