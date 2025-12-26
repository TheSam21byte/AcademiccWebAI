import os
import google.generativeai as genai
from core.config import settings

# Limpieza de entorno para asegurar el uso de API KEY
if "GOOGLE_APPLICATION_CREDENTIALS" in os.environ:
    del os.environ["GOOGLE_APPLICATION_CREDENTIALS"]

genai.configure(api_key=settings.GEMINI_API_KEY)

def build_prompt(user_message: str, academic_record: dict | None = None) -> str:
    estudiante = academic_record.get("estudiante", {}) if academic_record else {}
    cursos = academic_record.get("cursos", []) if academic_record else []
    
    nombre = estudiante.get('nombre', 'Estudiante')
    carrera = estudiante.get('carrera', 'tu carrera')
    
    cursos_txt = "\n".join([
        f"- {c['nombre']}: Nota {c['promedio_final']} ({c['estado']})" 
        for c in cursos
    ])

    # Si es el primer mensaje del sistema
    if user_message == "/start_greeting":
        return f"""
Eres MIYABI, un asesor académico experto y amable. 
El estudiante {nombre} de la carrera de {carrera} acaba de entrar al chat.

Tu tarea es:
1. Saludarlo cálidamente por su nombre.
2. Hacer un resumen rápido de su situación actual basado en estos datos:
{cursos_txt}

3. Si tiene notas bajas (menores a 11 o 12), anímalo. Si va bien, felicítalo.
4. Termina preguntando en qué curso específico desea ayuda hoy.

Sé breve, profesional y motivador. No inventes datos que no estén en la lista.
""".strip()

    # Prompt normal para el resto de la conversación
    return f"""
Eres MIYABI. Estudiante: {nombre}. 
Datos académicos:
{cursos_txt}

Pregunta del usuario: {user_message}
Responde de forma concisa.
""".strip()
async def get_ai_answer(user_message: str, academic_record: dict | None = None) -> str:
    final_prompt = build_prompt(user_message, academic_record)
    
    try:
        # --- LÓGICA DE AUTO-DETECCIÓN ---
        # Listamos los modelos para ver cuáles tienes permitidos
        available_models = [m.name for m in genai.list_models() if 'generateContent' in m.supported_generation_methods]
        
        if not available_models:
            return "Error: No se encontraron modelos disponibles para esta API Key."

        # Elegimos el modelo más moderno de tu lista (priorizando flash)
        # Si 'gemini-1.5-flash' está en tu lista, lo usará.
        selected_model = next((m for m in available_models if "1.5-flash" in m), available_models[0])
        
        print(f"DEBUG: Usando el modelo detectado: {selected_model}")

        model = genai.GenerativeModel(selected_model)
        response = model.generate_content(final_prompt)
        
        if response and response.text:
            return response.text
        return "MIYABI recibió el mensaje pero no pudo generar texto."
        
    except Exception as e:
        print(f"DEBUG ERROR: {str(e)}")
        return f"Error de configuración: {str(e)}"