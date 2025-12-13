# Entry point FastAPI

from fastapi import FastAPI
from core.database import engine
from api.router import api_router

app = FastAPI(
    docs_url=None,
    redoc_url=None,
    openapi_url=None
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