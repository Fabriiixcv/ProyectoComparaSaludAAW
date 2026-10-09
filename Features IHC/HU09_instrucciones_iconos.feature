Feature: Onboarding con instrucciones claras e íconos

  Como usuario con conocimientos tecnológicos limitados
  Quiero que las pantallas de onboarding tengan instrucciones claras e íconos intuitivos
  Para poder seguir el flujo sin confundirme

  Scenario: Mostrar íconos y etiquetas claras en los campos del onboarding
    Given que el usuario está en cualquier paso del onboarding
    When visualiza la pantalla
    Then cada campo de entrada (por ejemplo, "Ubicación") debe mostrar un ícono representativo (por ejemplo, un pin de mapa)
    And una etiqueta de texto clara que describa su propósito

  Scenario: Mostrar ayuda contextual por inactividad
    Given que el usuario se detiene en un campo por más de 10 segundos sin interactuar
    When el sistema detecta la inactividad
    Then se muestra un tooltip o mensaje breve con un ejemplo de lo que debe ingresar (por ejemplo, "Ej: Lima, Perú")

  Scenario: Mostrar barra de progreso en el flujo de onboarding
    Given que el usuario completa correctamente un paso
    When avanza al siguiente
    Then la barra de progreso superior se actualiza visualmente indicando el avance restante
