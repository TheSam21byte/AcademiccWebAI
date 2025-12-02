import userIcon from "../assets/assets-login/user.svg";
import passIcon from "../assets/assets-login/pass.svg";
import "../styles/input.css";

export default function InputField({ label, type, value, onChange, icon }) {
  
  const iconSrc = icon === "user" ? userIcon : passIcon;

  return (
    <div className="input-group">
      {label && <label className="input-label">{label}</label>}

      <div className="input-wrapper">
        <input
          className="input-line"
          type={type}
          value={value}
          onChange={onChange}
        />

        <img src={iconSrc} alt="icon" className="input-icon-right" />
      </div>
    </div>
  );
}
