📘 Guía de Desarrollo – AcademicWeb AI / M.I.Y.A.B.I

Manual de configuración, trabajo colaborativo y buenas prácticas

#️⃣ 1. Introducción

Este documento describe las consideraciones técnicas, pasos de instalación, estructura del proyecto y buenas prácticas para trabajar en el sistema:

AcademicWeb AI — Plataforma Inteligente de Asesoría y Predicción Académica,
impulsado por el middleware M.I.Y.A.B.I.

Su objetivo es asegurar que todos los integrantes del proyecto tengan un entorno homogéneo, seguro y fácil de reproducir.

#️⃣ 2. Requisitos Previos

Antes de iniciar, cada desarrollador debe contar con:

🔹 Software necesario

Python 3.13.7

Node.js 22.20.0 (para React)

Npm 11.6.2

MySQL Server / MariaDB

Git

Entornos virtuales

Variables de entorno

Git/GitHub

#️⃣ 3. Estructura del Proyecto

/ACADEMICWEBAI
│
├── backend/                # Backend FastAPI + IA (M.I.Y.A.B.I)
│   ├── venv/               # Entorno virtual (NO se sube)
│   ├── app/                # Código del backend
│   ├── requirements.txt    # Dependencias Python
│   └── ...
│
├── frontend/               # Aplicación React
│   ├── src/
│   ├── .env                # Variables frontend (NO se sube)
│   └── ...
│
├── database/
│   └── schema.sql          # Estructura inicial BD (opcional)
│
├── .env                    # Variables reales (NO se sube)
├── .env.example            # Plantilla de variables (SÍ se sube)
├── .gitignore              # Archivo de exclusiones (SÍ se sube)
└── README.md


#️⃣ 4. Uso de .env y .env.example
✔ .env.example

Este archivo sí se sube al repositorio
→ Contiene solo la estructura de las variables de entorno
→ NO contiene credenciales reales
→ Sirve como plantilla para nuevos desarrolladores

Ejemplo:

APP_ENV=development
API_BASE_URL=http://localhost:8000

DB_HOST=localhost
DB_PORT=3306
DB_NAME=academic_ai
DB_USER=your_user
DB_PASSWORD=your_password

AI_MODE=local
GEMINI_API_KEY=your_api_key_here
JWT_SECRET=your_jwt_secret_here
JWT_ALGORITHM=HS256

✔ .env

Este archivo NO se sube al repositorio.
Contiene credenciales reales del backend, base de datos y servicios IA.

#️⃣ 5. Creación del entorno virtual de Python

Cada integrante debe crear su propio entorno virtual, NO se comparte ni se sube.

✔ Ubicación recomendada:

Siempre dentro de /backend

/backend/venv

#️⃣ 6. Instalación de dependencias Python

Una vez activado el entorno:

pip install -r requirements.txt

Si instalas una librería nueva:

pip install fastapi
pip freeze > requirements.txt

Luego se sube solo requirements.txt.

(...)

#️⃣ 10. Buenas prácticas del equipo
✔ Nunca subir .env
✔ Nunca subir venv/ ni node_modules
✔ Siempre actualizar requirements.txt al instalar algo
✔ Commits claros y descriptivos
✔ Usar ramas (branches) por funcionalidad
✔ Hacer pull antes de comenzar a trabajar
✔ No subir archivos generados automáticamente
✔ Mantener estructura organizada













**** cambios realiazados

-Modificaciones en services auth, students,
-Modificacion en main --- tambien moverlo a la raiz central de backend
-Realizar una copia de venv en el backend
-Modificaciones en routes como auth y students
-
-
-