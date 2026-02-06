import os
import re
import unicodedata
from pypdf import PdfReader
import google.generativeai as genai
from src.core.config import settings

# --- CONFIGURACIÓN INICIAL ---
if "GOOGLE_APPLICATION_CREDENTIALS" in os.environ:
    del os.environ["GOOGLE_APPLICATION_CREDENTIALS"]

genai.configure(api_key=settings.GEMINI_API_KEY)

# --- NUEVAS FUNCIONES PARA LEER SÍLABOS ---

def normalize_text(text: str) -> str:
    """
    Función maestra de normalización:
    1. Quita tildes y convierte Ñ -> N.
    2. Elimina caracteres no alfanuméricos.
    3. Todo a mayúsculas.
    """
    if not text:
        return ""
    # Quitar tildes y normalizar Ñ
    text = unicodedata.normalize('NFKD', text).encode('ASCII', 'ignore').decode('utf-8')
    # Mayúsculas y quitar basura
    text = text.upper().strip()
    # Reemplazar espacios por guiones bajos para estandarizar
    text = re.sub(r'[^A-Z0-9]+', '_', text)
    return text.strip('_')

def get_syllabus_text(periodo: str, courses: list) -> str:
    """
    Busca los PDFs con una lógica de coincidencia flexible y un mapeo manual de emergencia.
    """
    script_dir = os.path.dirname(os.path.abspath(__file__)) 
    project_root = os.path.abspath(os.path.join(script_dir, "..", "..", "..")) 
    base_path = os.path.join(project_root, "database", f"S{periodo}")
    
    # --- MAPEO MANUAL DE EMERGENCIA ---
    # Esto asegura que si la búsqueda automática falla por caracteres especiales, se encuentre el archivo.
    MAPEO_MANUAL = {
        "DISEÑO PARA INGENIERIA": "DISEÑO.pdf",
        "SOCIOLOGIA RURAL Y AMAZONICA": "SOCIOLOGIA.pdf",
        "ALGORITMOS Y PROGRAMACIÓN": "ALGORITMOS.pdf"
    }

    combined_text = ""
    
    if not os.path.exists(base_path):
        print(f"DEBUG ERROR: No se encontró la carpeta en {base_path}")
        return "" 

    try:
        archivos_en_carpeta = os.listdir(base_path)
    except Exception as e:
        print(f"Error accediendo a la carpeta: {e}")
        return ""

    for course in courses:
        nombre_curso_bd = course['nombre']
        target_pdf = None

        # 1. INTENTO POR MAPEO MANUAL (Prioridad para evitar errores de tildes/eñes)
        if nombre_curso_bd.upper() in MAPEO_MANUAL:
            posible_path = os.path.join(base_path, MAPEO_MANUAL[nombre_curso_bd.upper()])
            if os.path.exists(posible_path):
                target_pdf = posible_path

        # 2. BÚSQUEDA INTELIGENTE (Si no está en el mapa manual)
        if not target_pdf:
            curso_clean = normalize_text(nombre_curso_bd)
            primera_palabra_curso = curso_clean.split("_")[0]

            for archivo in archivos_en_carpeta:
                if not archivo.lower().endswith(".pdf"):
                    continue
                
                nombre_archivo_base = archivo.rsplit('.', 1)[0]
                archivo_clean = normalize_text(nombre_archivo_base)
                
                if (archivo_clean == curso_clean or 
                    archivo_clean == primera_palabra_curso or 
                    archivo_clean in curso_clean or
                    curso_clean.startswith(archivo_clean)):
                    
                    target_pdf = os.path.join(base_path, archivo)
                    break

        # LECTURA DEL PDF ENCONTRADO
        if target_pdf:
            try:
                reader = PdfReader(target_pdf)
                text = ""
                for page in reader.pages[:3]: 
                    content = page.extract_text()
                    if content:
                        text += content + "\n"
                
                combined_text += f"\n--- SÍLABO DETECTADO: {nombre_curso_bd} ---\n{text}\n"
                print(f"DEBUG: PDF detectado y leído con éxito: {os.path.basename(target_pdf)}")
            except Exception as e:
                print(f"DEBUG ERROR: Error leyendo {target_pdf}: {e}")
        else:
            print(f"DEBUG: No se pudo localizar el PDF para: {nombre_curso_bd}")

    return combined_text

# --- LÓGICA DEL PROMPT ---

# --- LÓGICA DEL PROMPT (ACTUALIZADA PARA PÁRRAFOS CORTOS) ---

def build_prompt(user_message: str, academic_record: dict | None = None) -> str:
    estudiante = academic_record.get("estudiante", {}) if academic_record else {}
    cursos = academic_record.get("cursos", []) if academic_record else []
    
    periodo_actual = "2022-2"
    nombre = estudiante.get('nombre', 'Estudiante')
    carrera = estudiante.get('carrera', 'tu carrera')
    
    cursos_txt = "\n".join([
        f"- {c['nombre']}: Nota {c['promedio_final']} ({c['estado']})" 
        for c in cursos
    ])

    silabos_txt = ""
    if user_message == "/start_greeting":
        silabos_txt = get_syllabus_text(periodo_actual, cursos)

    # Estructura para el saludo inicial con instrucciones de formato
    if user_message == "/start_greeting":
        return f"""
Eres MIYABI, una asesora académica experta. Tu objetivo es ayudar a {nombre} ({carrera}).

DATOS ACADÉMICOS:
{cursos_txt}

CONTENIDO DE SÍLABOS:
{silabos_txt}

INSTRUCCIONES DE FORMATO OBLIGATORIAS:
1. Divide la información en PÁRRAFOS CORTOS Y SEPARADOS (máximo 3 líneas por párrafo).
2. Usa un lenguaje sencillo, directo y motivador. Evita bloques de texto gigantes.
3. Para cada análisis de curso, usa un párrafo independiente.

TAREA:
- Saluda brevemente.
- Resume las notas de forma clara.
- Para los cursos con nota menor a 12, menciona 2 o 3 temas clave del sílabo que debe estudiar, explicando por qué son importantes de forma simple.
- Despídete animando al estudiante.
""".strip()

    # Estructura para preguntas de seguimiento
    return f"""
Eres MIYABI. Responde a {nombre} de forma sencilla y en párrafos cortos.

Contexto académico:
{cursos_txt}

Pregunta: {user_message}

Responde de manera muy concisa, usando máximo 2 párrafos.
""".strip()

# --- CONEXIÓN CON IA ---
async def get_ai_answer(user_message: str, academic_record: dict | None = None, history: list = None) -> str:
    """
    history: lista de mensajes previos enviada por el frontend.
    Formato esperado: [{"role": "user", "parts": ["..."]}, {"role": "model", "parts": ["..."]}]
    """
    # 1. Generamos el prompt (que incluye los datos académicos y sílabos)
    final_prompt = build_prompt(user_message, academic_record)
    
    try:
        available_models = [m.name for m in genai.list_models() if 'generateContent' in m.supported_generation_methods]
        selected_model = next((m for m in available_models if "1.5-flash" in m), available_models[0])
        
        model = genai.GenerativeModel(selected_model)
        
        # 2. INICIAMOS EL CHAT CON EL HISTORIAL RECIBIDO
        # Si history es None, empieza vacío.
        chat = model.start_chat(history=history or [])
        
        # 3. ENVIAMOS EL MENSAJE ACTUAL
        response = chat.send_message(final_prompt)
        
        if response and response.text:
            return response.text
        return "MIYABI recibió el mensaje pero no pudo generar texto."
        
    except Exception as e:
        print(f"DEBUG ERROR: {str(e)}")
        return f"Error de configuración: {str(e)}"