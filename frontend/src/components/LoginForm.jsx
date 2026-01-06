import React, { useState } from "react";
import InputField from "./InputField";
import "../styles/loginForm.css";
import Swal from "sweetalert2";
import { useNavigate } from "react-router-dom";

export default function LoginForm() {
  const navigate = useNavigate();

  // Estados para capturar los datos
  const [username, setUsername] = useState(""); // Este será el Código Universitario
  const [password, setPassword] = useState(""); // Este será el DNI

  const handleLogin = async (e) => {
    e.preventDefault(); // Evita que la página se recargue

    // Validación básica antes de enviar
    if (!username || !password) {
      Swal.fire({
        icon: "warning",
        title: "Campos incompletos",
        text: "Por favor, ingresa tu código y DNI",
      });
      return;
    }

    try {
      // Petición al backend
      const response = await fetch("http://127.0.0.1:8000/auth/login", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          codigo: username, // Enviamos como 'codigo' según tu auth_schema
          password: password, // Enviamos como 'password' (el DNI)
        }),
      });

      const data = await response.json();

      if (response.ok) {
        // 1. Guardamos el Token JWT en el almacenamiento del navegador
        localStorage.setItem("token", data.access_token);
        localStorage.setItem("user_name", data.nombre); // <--- Guarda el nombre aquí

        Swal.fire({ icon: "success", title: "Bienvenido" }).then(() => {
          navigate("/dashboard");
        });

        // 2. Opcional: Guardar el nombre o ID del usuario si el backend lo envía
        // localStorage.setItem("user_id", data.user_id);

        // Modal de éxito
        Swal.fire({
          icon: "success",
          title: "Bienvenido",
          text: "Inicio de sesión correcto",
          timer: 2000,
          showConfirmButton: false,
        }).then(() => {
          navigate("/dashboard");
        });
      } else {
        // Modal de error (credenciales incorrectas 401)
        Swal.fire({
          icon: "error",
          title: "Acceso Denegado",
          text: data.detail || "Código universitario o DNI incorrectos",
        });
      }
    } catch (error) {
      // Error de conexión (Backend apagado o problemas de red)
      console.error("Error en el login:", error);
      Swal.fire({
        icon: "error",
        title: "Error de conexión",
        text: "Verifica que el servidor backend esté encendido.",
      });
    }
  };

  return (
    <form className="login-form" onSubmit={handleLogin}>
      <InputField
        type="text"
        placeholder="Código Universitario"
        value={username}
        onChange={(e) => setUsername(e.target.value)}
        icon="user"
      />

      <InputField
        type="password"
        placeholder="DNI"
        value={password}
        onChange={(e) => setPassword(e.target.value)}
        icon="lock"
      />

      {/* Eliminamos el onClick del botón para que no se duplique con el onSubmit del form */}
      <button type="submit" className="login-button">
        INGRESAR
      </button>

      <a href="/recover" className="login-recover">
        ¿Olvidaste tu contraseña?
      </a>
    </form>
  );
}
