import React from 'react';
import '../styles/cursos.css'; 


/* Componente individual para la tarjeta de cada curso */
function CourseCard({ title, progress, lastActivity, code, teacher }) {
    /* Determina un color para la barra de progreso basado en el avance */
    const getProgressColor = (p) => {
        if (p < 30) return '#EF3E71'; 
        if (p < 70) return '#FFB800'; 
        return '#4CAF50'; 
    };

    const progressColor = getProgressColor(progress);

    return (
        <div className="course-card page-card">
            <div className="card-header">
                <h3 className="course-title">{title}</h3>
                <span className="course-code">{code}</span>
            </div>
            
            <p className="course-teacher">Profesor: {teacher}</p>

            <div className="progress-section">
                <p className="progress-label">Progreso del Curso: <strong>{progress}%</strong></p>
                <div className="progress-bar-container">
                    <div 
                        className="progress-bar-fill" 
                        style={{ 
                            width: `${progress}%`, 
                            backgroundColor: progressColor 
                        }}
                    ></div>
                </div>
            </div>
            
            <p className="last-activity">Última actividad: {lastActivity}</p>
            
            <button className="btn-access">Acceder al Curso</button>
        </div>
    );
}

/* Componente principal de la página */
export default function CursosPage() {
    const courses = [
        /* Array de cursos de ejemplo */
        { 
            id: 1, 
            title: "Cálculo Avanzado I", 
            progress: 85, 
            lastActivity: "Lección 5 completada", 
            code: "MAT-301",
            teacher: "Dr. Elena García"
        },
        { 
            id: 2, 
            title: "Programación Orientada a Objetos", 
            progress: 45, 
            lastActivity: "Examen Parcial pendiente", 
            code: "CS-205",
            teacher: "Ing. Juan Pérez"
        },
        { 
            id: 3, 
            title: "Historia del Arte Moderno", 
            progress: 20, 
            lastActivity: "Módulo 1 iniciado", 
            code: "HMA-102",
            teacher: "Lic. Carla Soto"
        },
        { 
            id: 4, 
            title: "Marketing Digital Estratégico", 
            progress: 98, 
            lastActivity: "Proyecto Final enviado", 
            code: "MKT-410",
            teacher: "Msc. Ricardo León"
        },
    ];

    return (
        <>
            <h2 className="page-title">Mis Cursos Activos</h2>
            <p className="page-text">Visualiza el avance de tus cursos y accede a las últimas actividades.</p>
            
            /* Contenedor Grid para los cursos */
            <div className="courses-grid">
                {courses.map(course => (
                    <CourseCard 
                        key={course.id}
                        title={course.title}
                        progress={course.progress}
                        lastActivity={course.lastActivity}
                        code={course.code}
                        teacher={course.teacher}
                    />
                ))}
            </div>
        </>
    );
}