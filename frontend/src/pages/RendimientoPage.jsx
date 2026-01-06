import React, { useEffect, useState } from "react";
import "../styles/dashboard.css";
import "../styles/rendimiento.css";

// Componentes internos para asegurar que los props sean correctos
const MetricCard = ({ title, value, icon, color }) => (
  <div
    className="metric-card page-card"
    style={{ borderLeft: `5px solid ${color}` }}
  >
    <div className="metric-info">
      <p className="metric-title">{title}</p>
      <h3 className="metric-value" style={{ color: color }}>
        {value}
      </h3>
    </div>
    <div
      className="metric-icon"
      style={{ backgroundColor: `${color}1A`, color: color }}
    >
      {icon}
    </div>
  </div>
);

const IndividualCoursePerformanceCard = ({
  title,
  grade,
  status,
  focus,
  color,
}) => (
  <div className="course-performance-card page-card">
    <h4 className="course-performance-title" style={{ color: color }}>
      {title}
    </h4>
    <div className="performance-metrics">
      <p>
        <strong>Nota Final:</strong>{" "}
        <span style={{ color: color, fontWeight: "bold" }}>
          {grade.toFixed(1)}
        </span>
      </p>
      <p>
        <strong>Estado:</strong> {status}
      </p>
      <p style={{ fontSize: "0.85rem", color: "#666" }}>{focus}</p>
    </div>
    <button className="btn-details" style={{ marginTop: "10px" }}>
      Ver Unidades
    </button>
  </div>
);

export default function RendimientoPage() {
  const [academicData, setAcademicData] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    const fetchRendimiento = async () => {
      try {
        const token = localStorage.getItem("token");
        if (!token) throw new Error("No hay sesión activa");

        const response = await fetch(
          "http://127.0.0.1:8000/students/me/academic-record",
          {
            headers: { Authorization: `Bearer ${token}` },
          }
        );

        if (!response.ok)
          throw new Error("Error al obtener datos del servidor");

        const data = await response.json();
        setAcademicData(data);
      } catch (err) {
        setError(err.message);
      } finally {
        setLoading(false);
      }
    };
    fetchRendimiento();
  }, []);

  if (loading)
    return (
      <div className="loading-container">Cargando progreso académico...</div>
    );
  if (error) return <div className="error-container">Error: {error}</div>;
  if (!academicData)
    return <div className="error-container">No se encontraron registros.</div>;

  // Cálculos dinámicos basados en la estructura del service
  const cursos = academicData.cursos || [];
  const promedioGeneral = (
    cursos.reduce((acc, c) => acc + c.promedio_final, 0) / (cursos.length || 1)
  ).toFixed(2);
  const aprobados = cursos.filter((c) => c.estado === "APROBADO").length;

  const summaryMetrics = [
    {
      title: "Promedio Global",
      value: `${promedioGeneral}`,
      icon: "⭐",
      color: "#4CAF50",
    },
    {
      title: "Cursos Aprobados",
      value: `${aprobados}`,
      icon: "✅",
      color: "#1a73e8",
    },
    {
      title: "Periodo",
      value: academicData.periodo,
      icon: "📅",
      color: "#FFB800",
    },
  ];

  return (
    <div className="rendimiento-page">
      <h2 className="page-title">Rendimiento Académico</h2>
      <p className="page-subtitle">
        Estudiante: <strong>{academicData.estudiante?.nombre}</strong>
      </p>

      <div className="metrics-grid">
        {summaryMetrics.map((m, i) => (
          <MetricCard key={i} {...m} />
        ))}
      </div>

      <h3 className="section-subtitle">Tus Asignaturas</h3>
      <div className="course-performance-grid">
        {cursos.map((curso, index) => (
          <IndividualCoursePerformanceCard
            key={index}
            title={curso.nombre}
            grade={curso.promedio_final}
            status={curso.estado}
            focus={curso.docente}
            color={curso.promedio_final >= 10.5 ? "#4CAF50" : "#EF3E71"}
          />
        ))}
      </div>
    </div>
  );
}
