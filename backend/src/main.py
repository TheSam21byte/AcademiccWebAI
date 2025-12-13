# Entry point FastAPI

from fastapi import FastAPI
from core.database import engine

app = FastAPI()

@app.get("/health/db")
def check_db():
    try:
        connection = engine.connect()
        connection.close()
        return {"status": "Database connected"}
    except Exception as e:
        return {"error": str(e)}