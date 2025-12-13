from sqlalchemy import Column, Integer, String
from core.database import Base

class Student(Base):
    __tablename__ = "estudiantes"

    id_estudiante = Column(Integer, primary_key=True, index=True)
    codigo_universitario = Column(String(20), unique=True, index=True)
    dni = Column(String(20))
    nombre = Column(String(50))
    apellidop = Column(String(50))
    apellidom = Column(String(50))
    id_carrera = Column(Integer)
