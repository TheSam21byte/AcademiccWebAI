import React, { useState, useEffect } from "react";
import "../styles/cursos.css";

// --- COMPONENTE: MODAL DE DETALLE DE NOTAS ---
function CourseDetailModal({ course, onClose }) {
  if (!course) return null;

  return (
    <div className="modal-overlay" onClick={onClose}>
      <div
        className="modal-content course-modal"
        onClick={(e) => e.stopPropagation()}
      >
        <button className="close-btn" onClick={onClose}>
          &times;
        </button>
        <div className="modal-header">
          <h2>{course.nombre.toUpperCase()}</h2>
          <p className="modal-teacher">Profesor: {course.docente}</p>
        </div>

        <div className="modal-body">
          {course.unidades.map((u, idx) => (
            <div key={idx} className="unit-card">
              <h4 className="unit-title-modal">Unidad {u.numero}</h4>

              <div className="grades-container">
                <div className="grade-item-modal">
                  <span>CONCEPTUAL</span>
                  <p>{u.nota_conceptual}</p>
                </div>
                <div className="grade-item-modal">
                  <span>PROCEDIM.</span>
                  <p>{u.nota_procedimental}</p>
                </div>
                <div className="grade-item-modal">
                  <span>ACTITUD.</span>
                  <p>{u.nota_actitudinal}</p>
                </div>
              </div>

              <div className="unit-avg-badge">
                <span>PROMEDIO</span>
                <p>{u.promedio}</p>
              </div>
            </div>
          ))}
        </div>

        <div className="modal-footer-stats">
          <div className="final-score-text">
            Promedio Final: <strong>{course.promedio_final}</strong>
          </div>
          <div
            className={`status-box ${
              course.estado?.toLowerCase() === "aprobado"
                ? "bg-success"
                : "bg-danger"
            }`}
          >
            {course.estado?.toUpperCase()}
          </div>
        </div>
      </div>
    </div>
  );
}

// --- COMPONENTE PRINCIPAL ---
export default function CursosPage() {
  const [courses, setCourses] = useState([]);
  const [selectedCourse, setSelectedCourse] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchCourses = async () => {
      try {
        const token = localStorage.getItem("token");
        // IMPORTANTE: Cambiamos /ai/chat por el endpoint de tu record académico
        const response = await fetch(
          "http://127.0.0.1:8000/students/me/academic-record",
          {
            method: "GET",
            headers: {
              Authorization: `Bearer ${token}`,
              "Content-Type": "application/json",
            },
          }
        );

        if (!response.ok) throw new Error("Error al obtener datos");

        const data = await response.json();
        // Según tu student_service.py, el JSON tiene una clave "cursos"
        setCourses(data.cursos || []);
      } catch (error) {
        console.error("Error cargando cursos:", error);
      } finally {
        setLoading(false);
      }
    };
    fetchCourses();
  }, []);

  if (loading)
    return <div className="loading-state">Cargando tus cursos...</div>;

  return (
    <div className="cursos-container">
      <h2 className="page-title">Mis Cursos Activos</h2>
      <p className="page-text">
        Selecciona un curso para ver el desglose de tus notas.
      </p>

      <div className="courses-grid">
        {courses.map((course, index) => (
          <div key={index} className="course-card page-card">
            <div className="card-header">
              <h3 className="course-title">{course.nombre}</h3>
              <span className="course-code">{course.promedio_final}</span>
            </div>
            <p className="course-teacher">Prof: {course.docente}</p>

            <div className="progress-section">
              <div className="progress-bar-container">
                <div
                  className="progress-bar-fill"
                  style={{
                    width: `${(course.promedio_final / 20) * 100}%`,
                    backgroundColor:
                      course.promedio_final >= 10.5 ? "#4CAF50" : "#EF3E71",
                  }}
                ></div>
              </div>
            </div>

            <button
              className="btn-access"
              onClick={() => setSelectedCourse(course)}
            >
              Acceder al Curso
            </button>
          </div>
        ))}
      </div>

      {/* Modal de detalle */}
      <CourseDetailModal
        course={selectedCourse}
        onClose={() => setSelectedCourse(null)}
      />
    </div>
  );
}
