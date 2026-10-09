const chatbotHTML = `
<div id="chatbot-container" class="fixed bottom-4 right-4 z-50 hidden flex-col w-80 sm:w-96 bg-white rounded-2xl shadow-2xl border border-gray-200 overflow-hidden transition-all transform origin-bottom-right duration-300">
    <!-- Header -->
    <div class="bg-gradient-to-r from-blue-600 to-emerald-500 p-4 flex justify-between items-center">
        <div class="flex items-center space-x-2">
            <div class="w-8 h-8 bg-white/20 rounded-full flex items-center justify-center">
                <i class="fas fa-robot text-white"></i>
            </div>
            <div>
                <h3 class="text-white font-bold text-sm">Asistente Virtual</h3>
                <p class="text-blue-100 text-xs">En línea</p>
            </div>
        </div>
        <button id="close-chat" class="text-white/80 hover:text-white transition-colors">
            <i class="fas fa-times"></i>
        </button>
    </div>

    <!-- Messages Area -->
    <div id="chat-messages" class="h-80 overflow-y-auto p-4 space-y-4 bg-gray-50">
        <!-- Welcome Message -->
        <div class="flex items-start space-x-2">
            <div class="w-8 h-8 bg-gradient-to-br from-blue-600 to-emerald-500 rounded-full flex items-center justify-center flex-shrink-0">
                <i class="fas fa-robot text-white text-xs"></i>
            </div>
            <div class="bg-white p-3 rounded-2xl rounded-tl-none shadow-sm border border-gray-100 max-w-[80%]">
                <p class="text-sm text-gray-700">¡Hola! 👋 Soy el asistente de ComparaSalud. ¿En qué puedo ayudarte hoy?</p>
            </div>
        </div>
    </div>

    <!-- Input Area -->
    <div class="p-4 bg-white border-t border-gray-100">
        <form id="chat-form" class="flex items-center space-x-2">
            <input 
                type="text" 
                id="chat-input" 
                placeholder="Escribe tu mensaje..." 
                class="flex-1 bg-gray-50 border border-gray-200 rounded-full px-4 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all"
                autocomplete="off"
            >
            <button 
                type="submit" 
                class="w-10 h-10 bg-gradient-to-r from-blue-600 to-emerald-500 rounded-full flex items-center justify-center text-white hover:shadow-lg hover:scale-105 transition-all disabled:opacity-50 disabled:cursor-not-allowed"
            >
                <i class="fas fa-paper-plane text-sm"></i>
            </button>
        </form>
    </div>
</div>

<!-- Floating Toggle Button -->
<button id="chatbot-toggle" class="fixed bottom-4 right-4 z-40 w-14 h-14 bg-gradient-to-r from-blue-600 to-emerald-500 rounded-full shadow-lg hover:shadow-xl hover:scale-110 transition-all duration-300 flex items-center justify-center group">
    <i class="fas fa-comment-medical text-white text-xl group-hover:rotate-12 transition-transform"></i>
    <span class="absolute -top-1 -right-1 w-4 h-4 bg-red-500 rounded-full border-2 border-white"></span>
</button>
`;

// Inject HTML
document.body.insertAdjacentHTML('beforeend', chatbotHTML);

// DOM Elements
const container = document.getElementById('chatbot-container');
const toggleBtn = document.getElementById('chatbot-toggle');
const closeBtn = document.getElementById('close-chat');
const chatForm = document.getElementById('chat-form');
const chatInput = document.getElementById('chat-input');
const messagesArea = document.getElementById('chat-messages');

// State
let isOpen = false;

// Toggle Chat
function toggleChat() {
    isOpen = !isOpen;
    if (isOpen) {
        container.classList.remove('hidden');
        toggleBtn.classList.add('hidden');
        setTimeout(() => {
            container.classList.remove('scale-95', 'opacity-0');
            container.classList.add('scale-100', 'opacity-100');
            chatInput.focus();
        }, 10);
    } else {
        container.classList.remove('scale-100', 'opacity-100');
        container.classList.add('scale-95', 'opacity-0');
        setTimeout(() => {
            container.classList.add('hidden');
            toggleBtn.classList.remove('hidden');
        }, 300);
    }
}

// Add Message to UI
function addMessage(text, isUser = false) {
    const div = document.createElement('div');
    div.className = `flex items-start space-x-2 ${isUser ? 'justify-end' : ''}`;
    
    const content = isUser ? `
        <div class="bg-gradient-to-r from-blue-600 to-blue-700 text-white p-3 rounded-2xl rounded-tr-none shadow-md max-w-[80%]">
            <p class="text-sm">${text}</p>
        </div>
    ` : `
        <div class="w-8 h-8 bg-gradient-to-br from-blue-600 to-emerald-500 rounded-full flex items-center justify-center flex-shrink-0">
            <i class="fas fa-robot text-white text-xs"></i>
        </div>
        <div class="bg-white p-3 rounded-2xl rounded-tl-none shadow-sm border border-gray-100 max-w-[80%]">
            <p class="text-sm text-gray-700">${text}</p>
        </div>
    `;

    div.innerHTML = content;
    messagesArea.appendChild(div);
    messagesArea.scrollTop = messagesArea.scrollHeight;
}

// Mock Response Logic
function getBotResponse(input) {
    const lowerInput = input.toLowerCase();
    
    if (lowerInput.includes('hola') || lowerInput.includes('buenos')) {
        return "¡Hola! ¿Cómo puedo ayudarte a encontrar tu médico ideal hoy?";
    } else if (lowerInput.includes('precio') || lowerInput.includes('costo')) {
        return "En ComparaSalud creemos en la transparencia. Puedes ver los precios detallados en el perfil de cada especialista.";
    } else if (lowerInput.includes('medicamento') || lowerInput.includes('catalogo')) {
        return "Cada proveedor publica sus medicamentos con nombre, descripción y precio en su catálogo.";
    } else if (lowerInput.includes('seguro') || lowerInput.includes('privacidad')) {
        return "Tu seguridad es nuestra prioridad. Todos tus datos están encriptados y cumplimos con los estándares HIPAA.";
    } else {
        return "Entiendo. Para consultas más específicas, te sugiero buscar directamente en nuestra lista de especialistas o contactar a soporte.";
    }
}

// Event Listeners
toggleBtn.addEventListener('click', toggleChat);
closeBtn.addEventListener('click', toggleChat);

chatForm.addEventListener('submit', (e) => {
    e.preventDefault();
    const text = chatInput.value.trim();
    if (!text) return;

    // User Message
    addMessage(text, true);
    chatInput.value = '';

    // Bot Typing Indicator (Optional enhancement)
    
    // Bot Response Delay
    setTimeout(() => {
        const response = getBotResponse(text);
        addMessage(response, false);
    }, 1000);
});
