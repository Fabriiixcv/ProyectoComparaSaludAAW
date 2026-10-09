function setupVoiceSearch(inputSelector, buttonClassOverride = '') {
    const searchInput = document.querySelector(inputSelector);
    if (!searchInput) return;

    const searchContainer = searchInput.parentElement;

    // Create Microphone Button
    const micButton = document.createElement('button');
    micButton.innerHTML = '<i class="fas fa-microphone"></i>';
    
    // Default classes
    let buttonClasses = 'absolute top-1/2 transform -translate-y-1/2 text-gray-400 hover:text-blue-600 transition-colors p-2 rounded-full hover:bg-gray-100';
    
    // Apply override or default positioning
    if (buttonClassOverride) {
        buttonClasses += ' ' + buttonClassOverride;
    } else {
        buttonClasses += ' right-4';
    }
    
    micButton.className = buttonClasses;
    micButton.title = "Buscar por voz";
    searchContainer.appendChild(micButton);

    // Check Browser Support
    if ('webkitSpeechRecognition' in window) {
        const recognition = new webkitSpeechRecognition();
        recognition.continuous = false;
        recognition.interimResults = false;
        recognition.lang = 'es-ES';

        let isListening = false;

        micButton.addEventListener('click', (e) => {
            e.preventDefault(); // Prevent form submission if inside a form
            if (isListening) {
                recognition.stop();
            } else {
                recognition.start();
            }
        });

        recognition.onstart = () => {
            isListening = true;
            micButton.classList.remove('text-gray-400');
            micButton.classList.add('text-red-500', 'animate-pulse');
            const originalPlaceholder = searchInput.placeholder;
            searchInput.setAttribute('data-original-placeholder', originalPlaceholder);
            searchInput.placeholder = "Escuchando...";
        };

        recognition.onend = () => {
            isListening = false;
            micButton.classList.remove('text-red-500', 'animate-pulse');
            micButton.classList.add('text-gray-400');
            const originalPlaceholder = searchInput.getAttribute('data-original-placeholder');
            if (originalPlaceholder) searchInput.placeholder = originalPlaceholder;
        };

        recognition.onresult = (event) => {
            const transcript = event.results[0][0].transcript;
            searchInput.value = transcript;
        };

        recognition.onerror = (event) => {
            console.error('Voice search error:', event.error);
            isListening = false;
            micButton.classList.remove('text-red-500', 'animate-pulse');
            micButton.classList.add('text-gray-400');
            searchInput.placeholder = "Error. Intenta de nuevo.";
            setTimeout(() => {
                const originalPlaceholder = searchInput.getAttribute('data-original-placeholder');
                if (originalPlaceholder) searchInput.placeholder = originalPlaceholder;
            }, 2000);
        };

    } else {
        micButton.style.display = 'none';
        console.warn('Web Speech API not supported in this browser.');
    }
}

// Initialize for Index Page
setupVoiceSearch('input[placeholder="Buscar médico, especialidad..."]');

// Initialize for Search Results Page (Desktop)
// Positioning it to the left of the "Buscar" button (which is right-2 and approx 80px wide)
setupVoiceSearch('#desktop-search-input', 'right-24');
