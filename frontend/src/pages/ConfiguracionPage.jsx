import React, { useState } from 'react';
import '../styles/dashboard.css'; 
import '../styles/configuracion.css'; 

/* Componente para una opción de switch (activar/desactivar) */
function SettingSwitch({ label, description, initialState }) {
    const [isEnabled, setIsEnabled] = useState(initialState);

    return (
        <div className="setting-item">
            <div className="setting-info">
                <h4>{label}</h4>
                <p>{description}</p>
            </div>
            <label className="switch">
                <input 
                    type="checkbox" 
                    checked={isEnabled} 
                    onChange={() => setIsEnabled(!isEnabled)} 
                />
                <span className="slider round"></span>
            </label>
        </div>
    );
}

/* Componente principal de la página */
export default function ConfiguracionPage() {
    const [userName, setUserName] = useState('Alexander');
    const [userEmail, setUserEmail] = useState('alexander@academicweb.ai');

    return (
        <>
            <h2 className="page-title">Configuración de Cuenta y Asistencia</h2>
            <p className="page-text">Administra tu perfil, preferencias de notificación y ajustes de M.I.Y.A.B.I.</p>

            /* =========================================== */
            /* 1. Perfil y Cuenta */
            /* =========================================== */
            <div className="config-card page-card">
                <h3 className="config-section-title">👤 Perfil y Cuenta</h3>
                
                <div className="form-group">
                    <label>Nombre Completo:</label>
                    <input 
                        type="text" 
                        value={userName} 
                        onChange={(e) => setUserName(e.target.value)}
                        className="config-input"
                    />
                </div>
                
                <div className="form-group">
                    <label>Correo Electrónico:</label>
                    <input 
                        type="email" 
                        value={userEmail} 
                        readOnly 
                        className="config-input read-only"
                    />
                    <small>Este es tu correo principal, no editable.</small>
                </div>

                <div className="form-group">
                    <button className="btn-save-profile">Guardar Cambios del Perfil</button>
                    <button className="btn-change-password">Cambiar Contraseña</button>
                </div>
            </div>

            
            /* =========================================== */
            /* 2. Preferencias de Notificación */
            /* =========================================== */
            <div className="config-card page-card">
                <h3 className="config-section-title">🔔 Preferencias de Notificación</h3>
                
                <SettingSwitch 
                    label="Alertas de Exámenes"
                    description="Recibe recordatorios 24 horas antes de cada examen programado."
                    initialState={true}
                />
                
                <SettingSwitch 
                    label="Sugerencias de Estudio"
                    description="Notificaciones basadas en tu rendimiento que sugieren temas de repaso."
                    initialState={true}
                />
                
                <SettingSwitch 
                    label="Alertas por Atraso"
                    description="Recibe una alerta si M.I.Y.A.B.I. detecta riesgo de atraso en un curso."
                    initialState={false}
                />
            </div>

            /* =========================================== */
            /* 3. Configuración del Asesor IA (M.I.Y.A.B.I.) */
            /* =========================================== */
            <div className="config-card page-card">
                <h3 className="config-section-title">🧠 Asistencia IA (M.I.Y.A.B.I.)</h3>
                
                <SettingSwitch 
                    label="Modo de Interrupción Amigable"
                    description="Permite que M.I.Y.A.B.I. te envíe mensajes proactivos si detecta una tendencia negativa en tus notas."
                    initialState={true}
                />

                <div className="setting-item">
                    <div className="setting-info">
                        <h4>Estilo de Respuestas</h4>
                        <p>Elige el tono de las respuestas de M.I.Y.A.B.I.</p>
                    </div>
                    <select className="config-select">
                        <option>Formal y Académico (Predeterminado)</option>
                        <option>Casual y Motivacional</option>
                        <option>Conciso y Directo</option>
                    </select>
                </div>
            </div>
        </>
    );
}