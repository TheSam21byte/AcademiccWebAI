import "../styles/dashboard.css";
import iconUnamad from "../assets/assets-dashboard/unamad-icon.png";

export default function Navbar() {
  return (
    <header className="navbar">

      <div className="navbar-left">
        <img src={iconUnamad} alt="UNAMAD Logo" className="navbar-logo" />
        <h1 className="navbar-title">M.I.Y.A.B.I</h1>
      </div>

      <div className="navbar-user">
        <span>Alexander</span>
        <img
          src="https://ui-avatars.com/api/?name=Alexander&background=ffffff&color=ef3e71"
          className="navbar-avatar"
        />
      </div>

    </header>
  );
}
