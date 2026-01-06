import React, { useState, useEffect, useRef } from "react";
import "../styles/dashboard.css";
import "../styles/asesor.css";

// --- COMPONENTE: MODAL DE CONFIRMACIÓN ---
function ConfirmationModal({ isVisible, onClose, onConfirm }) {
  if (!isVisible) return null;
  return (
    <div className="modal-overlay">
      <div className="modal-content">
        <h4 className="modal-title">Confirmar Limpieza de Chat</h4>
        <p className="modal-text">
          ¿Estás seguro de que quieres limpiar toda la conversación? Esta acción
          no se puede deshacer.
        </p>
        <div className="modal-actions">
          <button className="btn-modal-cancel" onClick={onClose}>
            Cancelar
          </button>
          <button className="btn-modal-confirm" onClick={onConfirm}>
            Aceptar y Limpiar
          </button>
        </div>
      </div>
    </div>
  );
}

// --- COMPONENTE: MENSAJE INDIVIDUAL ---
function ChatMessage({ message, isUser, userName }) {
  const messageClass = isUser ? "user-message" : "ai-message";
  // Si es usuario, usa las iniciales del nombre real o "AL" por defecto
  const avatarText = isUser
    ? userName
      ? userName.substring(0, 2).toUpperCase()
      : "AL"
    : "AI";

  return (
    <div className={`chat-message-container ${messageClass}`}>
      {!isUser && <div className="avatar ai-avatar">AI</div>}
      <div className={`chat-bubble ${messageClass}`}>
        <p>{message}</p>
      </div>
      {isUser && <div className="avatar user-avatar">{avatarText}</div>}
    </div>
  );
}

// --- COMPONENTE PRINCIPAL ---
export default function ChatPage() {
  // Recuperar datos del usuario desde localStorage para la bienvenida
  const userData = JSON.parse(localStorage.getItem("user") || "{}");
  const nombreUsuario = userData.nombre_completo?.split(" ")[0] || "Alexander";

  const INITIAL_MESSAGES = [
    {
      id: 1,
      text: `¡Hola, ${nombreUsuario}! Soy M.I.Y.A.B.I, tu Asesor IA. Estoy aquí para ayudarte con cualquier duda sobre tus cursos, notas o calendario.`,
      isUser: false,
    },
  ];

  const [messages, setMessages] = useState(INITIAL_MESSAGES);
  const [input, setInput] = useState("");
  const [isModalVisible, setIsModalVisible] = useState(false);
  const [isLoading, setIsLoading] = useState(false);
  const chatEndRef = useRef(null);

  // Auto-scroll al final del chat
  useEffect(() => {
    chatEndRef.current?.scrollIntoView({ behavior: "smooth" });
  }, [messages, isLoading]);

  const handleSend = async () => {
    if (input.trim() === "" || isLoading) return;

    const userText = input;
    const token = localStorage.getItem("token");

    // 1. Agregar mensaje del usuario a la interfaz
    const newUserMessage = { id: Date.now(), text: userText, isUser: true };
    setMessages((prev) => [...prev, newUserMessage]);
    setInput("");
    setIsLoading(true);

    try {
      // 2. Llamada al Backend incluyendo el Token de Alexander
      const response = await fetch("http://127.0.0.1:8000/ai/chat", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`, // <--- IMPORTANTE: Identifica quién eres
        },
        body: JSON.stringify({
          message: userText,
          // Se puede omitir user_id si tu backend ya saca el ID del token
          user_id: userData.id_estudiante,
        }),
      });

      if (!response.ok) throw new Error("Error en la respuesta del servidor");

      const data = await response.json();

      // 3. Agregar respuesta de la IA
      const newAiMessage = {
        id: Date.now() + 1,
        text: data.response,
        isUser: false,
      };
      setMessages((prev) => [...prev, newAiMessage]);
    } catch (error) {
      console.error("Error en el chat:", error);
      setMessages((prev) => [
        ...prev,
        {
          id: Date.now() + 1,
          text: "Lo siento, tuve un problema al procesar tu consulta. Revisa tu conexión.",
          isUser: false,
        },
      ]);
    } finally {
      setIsLoading(false);
    }
  };

  const handleConfirmClear = () => {
    setMessages(INITIAL_MESSAGES);
    setIsModalVisible(false);
  };

  return (
    <div className="chat-page-container">
      <h2 className="page-title">Asesor IA M.I.Y.A.B.I</h2>
      <p className="page-text">Tu asistente académico personalizado.</p>

      <div className="chat-box page-card">
        <div className="chat-history">
          {messages.map((msg) => (
            <ChatMessage
              key={msg.id}
              message={msg.text}
              isUser={msg.isUser}
              userName={nombreUsuario}
            />
          ))}
          {isLoading && (
            <div className="chat-message-container ai-message">
              <div className="avatar ai-avatar">AI</div>
              <div className="chat-bubble ai-message">
                <p className="loading-dots">
                  Escribiendo<span>.</span>
                  <span>.</span>
                  <span>.</span>
                </p>
              </div>
            </div>
          )}
          <div ref={chatEndRef} />
        </div>

        <div className="chat-input-area">
          <button
            className="btn-clear-chat"
            onClick={() => setIsModalVisible(true)}
            title="Limpiar conversación"
          >
            🧹
          </button>
          <input
            type="text"
            className="chat-input"
            placeholder="Ej: ¿Qué temas debo estudiar para Álgebra?"
            value={input}
            onChange={(e) => setInput(e.target.value)}
            onKeyPress={(e) => e.key === "Enter" && handleSend()}
          />
          <button
            className="btn-send"
            onClick={handleSend}
            disabled={isLoading || !input.trim()}
          >
            {isLoading ? "..." : "Enviar 🚀"}
          </button>
        </div>
      </div>

      <ConfirmationModal
        isVisible={isModalVisible}
        onClose={() => setIsModalVisible(false)}
        onConfirm={handleConfirmClear}
      />
    </div>
  );
}
