from fastapi import APIRouter
from api.routes import auth, students, chat

api_router = APIRouter()
api_router.include_router(auth.router)
api_router.include_router(students.router)
api_router.include_router(chat.router)