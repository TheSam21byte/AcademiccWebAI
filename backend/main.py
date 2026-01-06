from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
import uvicorn

# --- IMPORTACIONES LIMPIAS ---
# Importamos directamente los objetos 'router' de cada archivo
from src.api.routes.auth import router as auth_router
from src.api.routes.chat import router as chat_router
from src.api.routes.students import router as students_router # Importación clara

app = FastAPI(title="AcademicWeb AI")

# --- MIDDLEWARE ---
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# --- REGISTRO DE RUTAS ---
# Al usar estos objetos, FastAPI mapea los prefijos definidos dentro de cada archivo
app.include_router(auth_router)
app.include_router(chat_router)
app.include_router(students_router) # Ahora sí registrará /students/me/...

@app.get("/")
def home():
    return {"message": "API is running"}

if __name__ == "__main__":
    # Asegúrate de que el nombre del archivo sea 'main.py' para que "main:app" funcione
    uvicorn.run("main:app", host="127.0.0.1", port=8000, reload=True)