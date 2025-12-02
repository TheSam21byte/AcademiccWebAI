import "../styles/dashboard.css";
import { NavLink } from "react-router-dom";

export default function Sidebar() {
  // Función para determinar las clases del NavLink
  // 'isActive' es proporcionada automáticamente por NavLink
  const getNavLinkClass = ({ isActive }) => {
    // Si isActive es true, añade la clase 'active' a 'sidebar-link'
    // De lo contrario, solo usa 'sidebar-link'
    return isActive ? "sidebar-link active" : "sidebar-link";
  };

  return (
    <aside className="sidebar">

      {/* <h2 className="sidebar-title">M.I.Y.A.B.I</h2> */}

      <nav className="sidebar-nav">
        {/* Usamos la función 'getNavLinkClass' en lugar de la clase estática */}
        
        {/* NOTA: Usa 'end' en el enlace raíz para que no esté activo en todas las subrutas */}
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

    </aside>
  );
}