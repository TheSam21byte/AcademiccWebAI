import React, { useState, useEffect } from "react"; // IMPORTANTE: Asegúrate de tener useState aquí
import { useNavigate } from "react-router-dom";
import "../styles/dashboard.css";
import iconUnamad from "../assets/assets-dashboard/unamad-icon.png";

export default function Navbar() {
  const navigate = useNavigate();

  // Definición del estado
  const [nombre, setNombre] = useState("Usuario");

  useEffect(() => {
    // Intentamos recuperar el nombre del localStorage
    const nombreGuardado = localStorage.getItem("user_name");

    // Solo actualizamos si el valor existe y es válido
    if (nombreGuardado && nombreGuardado !== "undefined") {
      setNombre(nombreGuardado);
    }
  }, []); // El arreglo vacío asegura que solo se ejecute al cargar el componente

  const handleLogout = () => {
    localStorage.clear();
    navigate("/");
  };

  return (
    <header className="navbar">
      <div className="navbar-left">
        <img src={iconUnamad} alt="UNAMAD Logo" className="navbar-logo" />
        <h1 className="navbar-title">M.I.Y.A.B.I</h1>
      </div>

      <div className="navbar-right">
        <div className="navbar-user">
          <span className="user-name">{nombre}</span>
          <img
            src={`https://ui-avatars.com/api/?name=${nombre}&background=ffffff&color=ef3e71`}
            alt="User Avatar"
            className="navbar-avatar"
          />
        </div>
      </div>
    </header>
  );
}
