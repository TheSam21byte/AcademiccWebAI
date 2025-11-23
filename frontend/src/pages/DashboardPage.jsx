export default function DashboardPage(){
  return (
    <>
      <h2 className="page-title">Bienvenido a AcademicWeb AI</h2>
      <p className="page-text">
        Aquí podrás visualizar tu rendimiento, recomendaciones personalizadas y estadísticas.
      </p>

      <strong>
        ¿Qué es M.I.Y.A.B.I?
        M.I.Y.A.B.I es un asistente de inteligencia artificial diseñado para ayudarte a mejorar tu experiencia académica. Utilizando algoritmos avanzados, M.I.Y.A.B.I analiza tus patrones de estudio y rendimiento para ofrecerte recomendaciones personalizadas que te ayudarán a alcanzar tus objetivos educativos de manera más eficiente.
        {/* TODO: completar sección descriptiva */}
      </strong>

      <p>
        Algunas de las funcionalidades clave de M.I.Y.A.B.I incluyen:
        <ul>
          <li>Recomendaciones de estudio personalizadas basadas en tu rendimiento y hábitos de aprendizaje.</li>
          <li>Recordatorios y alertas para fechas importantes como exámenes y entregas de trabajos.</li>
          <li>Asistencia en la organización de tu calendario académico.</li>
          <li>Acceso a recursos educativos adaptados a tus necesidades.</li>
          <li>Soporte 24/7 para responder a tus preguntas académicas.</li>
        </ul>
      </p>
    </>
  );
}