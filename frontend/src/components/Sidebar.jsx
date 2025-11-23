import "../styles/dashboard.css";
import { NavLink } from "react-router-dom";

export default function Sidebar() {
  return (
    <aside className="sidebar">

      {/* <h2 className="sidebar-title">M.I.Y.A.B.I</h2> */}

      <nav className="sidebar-nav">
        <NavLink to="/dashboard" className="sidebar-link">
          Inicio
        </NavLink>

        <NavLink to="/dashboard/cursos" className="sidebar-link">
          Mis Cursos
        </NavLink>

        <NavLink to="/dashboard/rendimiento" className="sidebar-link">
          Mi Rendimiento
        </NavLink>
    
        <NavLink to="/dashboard/chat" className="sidebar-link">
          Asesor IA
        </NavLink>

        <NavLink to="/dashboard/configuracion" className="sidebar-link">
          Configuración
        </NavLink>
      </nav>

    </aside>
  );
}
