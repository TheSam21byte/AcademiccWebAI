import "../styles/dashboard.css";
import { NavLink, useNavigate } from "react-router-dom";

export default function Sidebar() {
  const navigate = useNavigate();

  const getNavLinkClass = ({ isActive }) => {
    return isActive ? "sidebar-link active" : "sidebar-link";
  };

  const handleLogout = () => {
    // 1. Limpiamos el almacenamiento local
    localStorage.clear();
    // 2. Redirigimos al Login
    navigate("/");
  };

  return (
    <aside className="sidebar">
      <nav className="sidebar-nav">
        <NavLink to="/dashboard" className={getNavLinkClass} end>
          Inicio
        </NavLink>

        <NavLink to="/dashboard/cursos" className={getNavLinkClass}>
          Mis Cursos
        </NavLink>

        <NavLink to="/dashboard/rendimiento" className={getNavLinkClass}>
          Mi Rendimiento
        </NavLink>

        <NavLink to="/dashboard/chat" className={getNavLinkClass}>
          Asesor IA
        </NavLink>

        <NavLink to="/dashboard/configuracion" className={getNavLinkClass}>
          Configuración
        </NavLink>
      </nav>

      {/* Botón de Salir al final del Sidebar */}
      <div className="sidebar-footer">
        <button
          onClick={handleLogout}
          className="sidebar-link logout-button-sidebar"
        >
          Salir
        </button>
      </div>
    </aside>
  );
}
