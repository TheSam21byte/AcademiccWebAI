import React, { useState } from "react";
import InputField from "./InputField";
import "../styles/loginForm.css";
import Swal from "sweetalert2";
import { useNavigate } from "react-router-dom";

export default function LoginForm() {

  const navigate = useNavigate();

  const [username, setUsername] = useState("");
  const [password, setPassword] = useState("");

  const handleLogin = (e) => {
    e.preventDefault();

    if (username === "admin" && password === "123") {

      // Modal de éxito
      Swal.fire({
        icon: "success",
        title: "Bienvenido",
        text: "Inicio de sesión correcto",
      }).then(() => {
        navigate("/dashboard");
      });

    } else {

      // Modal de error
      Swal.fire({
        icon: "error",
        title: "Credenciales incorrectas",
        text: "El usuario o la contraseña no coinciden",
      });

    }
  };

  return (
    <form className="login-form" onSubmit={handleLogin}>
      <InputField
        type="text"
        value={username}
        onChange={(e) => setUsername(e.target.value)}
        icon="user"
      />

      <InputField
        type="password"
        value={password}
        onChange={(e) => setPassword(e.target.value)}
        icon="lock"
      />

      <button type="submit" className="login-button" onClick={handleLogin}>
        INGRESAR
      </button>

      <a href="/recover" className="login-recover">
        ¿Olvidaste tu contraseña?
      </a>
    </form>
  );
}
