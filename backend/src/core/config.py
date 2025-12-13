import os 
from dotenv import load_dotenv

load_dotenv()

class Settings:
    """Configuration settings for the application."""

    APP_ENV: str = os.getenv("APP_ENV", "development")
    API_BASE_URL: str = os.getenv("API_BASE_URL")

    DB_HOST: str = os.getenv("DB_HOST")
    DB_PORT: int = int(os.getenv("DB_PORT", 3306))
    DB_NAME: str = os.getenv("DB_NAME")
    DB_USER: str = os.getenv("DB_USER")
    DB_PASSWORD: str = os.getenv("DB_PASSWORD")

settings = Settings()