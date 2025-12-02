export default function DashboardPage() {
    const features = [
        {
            title: "Recomendaciones Personalizadas",
            description: "Basadas en tu rendimiento y hábitos de aprendizaje para optimizar tu estudio.",
            icon: "💡"
        },
        {
            title: "Alertas y Recordatorios",
            description: "Fechas importantes para exámenes y entregas de trabajos, nunca te perderás una fecha límite.",
            icon: "⏰"
        },
        {
            title: "Organización de Calendario",
            description: "Asistencia para organizar y visualizar de manera eficiente tu calendario académico completo.",
            icon: "🗓️"
        },
        {
            title: "Recursos Educativos",
            description: "Acceso a material de estudio y recursos adaptados precisamente a tus necesidades.",
            icon: "📚"
        },
        {
            title: "Soporte 24/7",
            description: "Asistencia ininterrumpida para responder cualquier pregunta académica que tengas, día y noche.",
            icon: "💬"
        },
    ];

    return (
        <>
            <h2 className="page-title">Bienvenido a AcademicWeb AI</h2>
            <p className="page-text">
                Aquí podrás visualizar tu rendimiento, recomendaciones personalizadas y estadísticas.
            </p>
            
            <div className="description-section">
                <strong>¿Qué es M.I.Y.A.B.I?</strong>
                <p>
                    M.I.Y.A.B.I es un asistente de inteligencia artificial diseñado para ayudarte a mejorar tu experiencia académica. Utilizando algoritmos avanzados, M.I.Y.A.B.I analiza tus patrones de estudio y rendimiento para ofrecerte **recomendaciones personalizadas** que te ayudarán a alcanzar tus objetivos educativos de manera más eficiente.
                </p>
            </div>
            
            <h3 className="section-subtitle">Funcionalidades Clave de M.I.Y.A.B.I</h3>
            
            <div className="feature-cards-grid">
                {features.map((feature, index) => (
                    <div 
                        key={index}
                        className="feature-card" 
                        style={{ animationDelay: `${index * 0.1}s` }}
                    >
                        <div className="card-icon">{feature.icon}</div>
                        <h4 className="card-title">{feature.title}</h4>
                        <p className="card-description">{feature.description}</p>
                    </div>
                ))}
            </div>
        </>
    );
}