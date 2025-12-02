import React from 'react';
import '../styles/dashboard.css'; 
import '../styles/rendimiento.css'; 

function MetricCard({ title, value, icon, color }) {
    return (
        <div className="metric-card page-card" style={{ borderLeft: `5px solid ${color}` }}>
            <div className="metric-info">
                <p className="metric-title">{title}</p>
                <h3 className="metric-value" style={{ color: color }}>{value}</h3>
            </div>
            <div className="metric-icon" style={{ backgroundColor: color + '1A', color: color }}>
                {icon}
            </div>
        </div>
    );
}

function IndividualCoursePerformanceCard({ title, grade, focus, status, color }) {
    return (
        <div className="course-performance-card page-card">
            <h4 className="course-performance-title" style={{ color: color }}>{title}</h4>
            <div className="performance-metrics">
                <p><strong>Nota Actual:</strong> <span style={{ color: color }}>{grade} / 10</span></p>
                <p><strong>Foco:</strong> {focus}</p>
                <p><strong>Estado:</strong> {status}</p>
            </div>
            
            <div className="details-button-area">
                <button className="btn-details">Ver Detalles y Gráfico</button>
            </div>
            
        </div>
    );
}

export default function RendimientoPage() {
    const metrics = [
        { title: "Nota Promedio Global", value: "8.7 / 10", icon: "⭐", color: "#4CAF50" }, 
        { title: "Cursos Pendientes", value: "2", icon: "📚", color: "#FFB800" }, 
        { title: "Compromiso IA", value: "Alto (92%)", icon: "🧠", color: "#1a73e8" }, 
        { title: "Horas de Estudio Semanal", value: "15.5 hrs", icon: "⏱️", color: "#EF3E71" }, 
    ];

    const coursePerformance = [
        { title: "Cálculo Avanzado I", grade: 9.5, focus: "Sólido", status: "Terminando Módulo 5", color: "#1a73e8" },
        { title: "Programación Orientada a Objetos", grade: 7.2, focus: "Necesita Refuerzo (Polimorfismo)", status: "En Módulo 3", color: "#FFB800" },
        { title: "Historia del Arte Moderno", grade: 6.5, focus: "Riesgo de Atraso", status: "Recién Iniciado", color: "#EF3E71" },
        { title: "Marketing Digital Estratégico", grade: 9.8, focus: "Excelente", status: "Finalizado / Proyecto Aprobado", color: "#4CAF50" },
    ];

    return (
        <>
            <h2 className="page-title">Panel de Rendimiento Global</h2>
            <p className="page-text">Análisis detallado de tu progreso y áreas de enfoque.</p>
            
            <div className="metrics-grid">
                {metrics.map((metric, index) => (
                    <MetricCard 
                        key={index}
                        title={metric.title}
                        value={metric.value}
                        icon={metric.icon}
                        color={metric.color}
                    />
                ))}
            </div>

            <h3 className="section-subtitle">Rendimiento Detallado por Curso</h3>

            <div className="course-performance-grid">
                {coursePerformance.map((course, index) => (
                        <IndividualCoursePerformanceCard
                            key={index}
                            title={course.title}
                            grade={course.grade}
                            focus={course.focus}
                            status={course.status}
                            color={course.color}
                        />
                ))}
            </div>
            
            <h3 className="section-subtitle recommendation-subtitle">Recomendaciones Personalizadas M.I.Y.A.B.I</h3>
            
            <div className="recommendation-box page-card">
                <p><strong>⚠️ Foco: Programación Orientada a Objetos</strong></p>
                <p>Tu tiempo de estudio en el módulo de 'Herencia y Polimorfismo' es 30% menor que el promedio. Te recomendamos:</p>
                <ul>
                    <li>Revisar el **Recurso Interactivo sobre Herencia** (5 videos, 20 minutos).</li>
                    <li>Programar una sesión con el **Asesor IA** mañana a las 19:00 para resolver dudas específicas.</li>
                    <li>Repasar los ejercicios del capítulo 4 antes del examen.</li>
                </ul>
            </div>
        </>
    );
}