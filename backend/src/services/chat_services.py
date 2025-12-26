def build_prompt(user_message: str, academic_record: dict | None = None) -> str:
    """
    Construye el prompt que se enviaría a Gemini.
    Por ahora sirve para mantener la estructura lista.
    """
    if not academic_record:
        return f"Usuario: {user_message}\nAsistente:"

    # Contexto mínimo (puedes enriquecerlo luego)
    estudiante = academic_record.get("estudiante", {})
    cursos = academic_record.get("cursos", [])

    cursos_txt = "\n".join(
        [f"- {c['nombre']} (estado: {c['estado']}, promedio: {c['promedio_final']})" for c in cursos]
    )

    prompt = f"""
Eres MIYABI, un asesor académico.
Estudiante: {estudiante.get('nombre')} ({estudiante.get('codigo')})
Carrera: {estudiante.get('carrera')}
Periodo: {academic_record.get('periodo')}

Cursos:
{cursos_txt}

Pregunta del estudiante: {user_message}

Responde de forma clara y breve, con recomendaciones accionables.
""".strip()

    return prompt


def simple_mock_answer(user_message: str, academic_record: dict | None = None) -> str:
    """
    Respuesta mock (sin IA) para validar frontend/back.
    """
    msg = user_message.lower().strip()

    if academic_record:
        # Ejemplo: si pregunta por "cursos"
        if "cursos" in msg or "llevo" in msg:
            cursos = academic_record.get("cursos", [])
            nombres = [c["nombre"] for c in cursos]
            return f"Estás llevando {len(nombres)} cursos: " + ", ".join(nombres)

        # Ejemplo: si menciona un curso por nombre parcial
        cursos = academic_record.get("cursos", [])
        for c in cursos:
            if c["nombre"].lower() in msg:
                return (f"En {c['nombre']} tu estado es {c['estado']} con promedio final "
                        f"{c['promedio_final']}. ¿Quieres ver el detalle por unidades?")

    return "Te leo 👀. ¿Tu duda es sobre cursos, notas, unidades o tu promedio?"
