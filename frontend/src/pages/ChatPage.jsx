import React, { useState } from 'react';
import '../styles/dashboard.css'; 
import '../styles/asesor.css'; 

// Mensajes iniciales que aparecerán al limpiar el chat o al cargar la página
const INITIAL_MESSAGES = [
    { id: 1, text: "¡Hola, Alexander! Soy M.I.Y.A.B.I, tu Asesor IA. Estoy aquí para ayudarte con cualquier duda sobre tus cursos, notas o calendario.", isUser: false },
    { id: 2, text: "Recuerda que tienes un foco en Programación Orientada a Objetos. ¿Quieres que te muestre los recursos de 'Polimorfismo'?", isUser: false },
];

// -------------------------------------------
// *** NUEVO COMPONENTE: MODAL DE CONFIRMACIÓN ***
// -------------------------------------------
function ConfirmationModal({ isVisible, onClose, onConfirm }) {
    if (!isVisible) return null;

    return (
        // Fondo oscuro semitransparente que cubre toda la pantalla
        <div className="modal-overlay">
            <div className="modal-content">
                <h4 className="modal-title">Confirmar Limpieza de Chat</h4>
                <p className="modal-text">¿Estás seguro de que quieres limpiar toda la conversación? Esta acción no se puede deshacer y el historial se perderá.</p>
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
// -------------------------------------------


// Componente individual para un mensaje (sin cambios)
function ChatMessage({ message, isUser }) {
  const messageClass = isUser ? 'user-message' : 'ai-message';
  const avatarText = isUser ? 'AL' : 'AI';

  return (
    <div className={`chat-message-container ${messageClass}`}>
        {!isUser && <div className="avatar ai-avatar">{avatarText}</div>}
        <div className={`chat-bubble ${messageClass}`}>
            <p>{message}</p>
        </div>
        {isUser && <div className="avatar user-avatar">{avatarText}</div>}
    </div>
  );
}


// Componente principal de la página
export default function ChatPage() {
    const [messages, setMessages] = useState(INITIAL_MESSAGES);
    const [input, setInput] = useState('');
    // Estado para controlar si el modal está visible
    const [isModalVisible, setIsModalVisible] = useState(false); 


    const handleSend = () => {
        if (input.trim() === '') return;

        const newUserMessage = { id: Date.now(), text: input, isUser: true };
        setMessages([...messages, newUserMessage]);
        
        // Simular la respuesta de la IA
        setTimeout(() => {
            const aiResponseText = `Entendido, Alexander. Analizando tu solicitud sobre "${input}". Según tu rendimiento, te sugiero priorizar el repaso de funciones recursivas.`;
            const newAiMessage = { id: Date.now() + 1, text: aiResponseText, isUser: false };
            setMessages(currentMessages => [...currentMessages, newAiMessage]);
        }, 1000);

        setInput('');
    };
    
    // Función que pide confirmación abriendo el modal
    const handleClearChatRequest = () => {
        setIsModalVisible(true);
    };

    // Función que ejecuta la limpieza
    const handleConfirmClear = () => {
        setMessages(INITIAL_MESSAGES);
        setInput('');
        setIsModalVisible(false); // Cierra el modal
    };


    return (
        <div className="chat-page-container">
            <h2 className="page-title">Asesor IA M.I.Y.A.B.I</h2>
            <p className="page-text">Tu asistente personalizado. Pregunta sobre tus cursos, rendimiento o dudas académicas.</p>
            
            <div className="chat-box page-card">
                
                {/* Área de Historial de Mensajes */}
                <div className="chat-history">
                    {messages.map(msg => (
                        <ChatMessage key={msg.id} message={msg.text} isUser={msg.isUser} />
                    ))}
                    <div id="scroll-bottom-anchor"></div> 
                </div>

                {/* Área de Entrada de Texto y Botones */}
                <div className="chat-input-area">
                    <button className="btn-clear-chat" onClick={handleClearChatRequest}>
                        Limpiar Chat 🧹
                    </button>
                    <input 
                        type="text" 
                        className="chat-input"
                        placeholder="Escribe tu pregunta o solicitud..."
                        value={input}
                        onChange={(e) => setInput(e.target.value)}
                        onKeyPress={(e) => {
                            if (e.key === 'Enter') handleSend();
                        }}
                    />
                    <button className="btn-send" onClick={handleSend}>
                        Enviar 🚀
                    </button>
                </div>
            </div>

            {/* Renderizar el Modal de Confirmación */}
            <ConfirmationModal 
                isVisible={isModalVisible} 
                onClose={() => setIsModalVisible(false)} 
                onConfirm={handleConfirmClear} 
            />
        </div>
    );
}