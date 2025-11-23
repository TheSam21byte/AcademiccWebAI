import LoginForm from "../components/LoginForm";
import "../styles/login.css";

import bgImage from "../assets/assets-login/background-login.png";
import logoUnamad from "../assets/assets-login/logo-unamad.png";

export default function LoginPage() {
  return (
    <div className="login-container">

      {/* Left side */}
      <div className="login-left">
        <img
          src={logoUnamad}
          alt="Logo"
          className="login-logo"
        />

        <h1 className="login-title">Iniciar Sesión</h1>

        <LoginForm />
      </div>

      {/* Right side */}
      <div className="login-right">
        <img
          src={bgImage}
          alt="Side"
          className="login-image"
        />
        <div className="login-overlay"></div>
      </div>

    </div>
  );
}
