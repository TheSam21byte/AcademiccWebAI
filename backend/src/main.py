# Entry point FastAPI

from fastapi import FastAPI
from core.database import engine
from api.router import api_router

app = FastAPI(
    title="AcademicWeb AI - M.I.Y.A.B.I.",
    description="Plataforma Inteligente de Asesoría Académica",
    version="1.0.0"
    # Al quitar los None, FastAPI activará las rutas por defecto
)
@app.get("/health/db")
def check_db():
    try:
        connection = engine.connect()
        connection.close()
        return {"status": "Database connected"}
    except Exception as e:
        return {"error": str(e)}
    
app.include_router(api_router)