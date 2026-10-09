Feature: Acceso a Preguntas Frecuentes (FAQ)
  Como usuario,
  quiero acceder a una sección de "Preguntas Frecuentes (FAQ)" que resuelva las dudas comunes sobre el uso de la app,
  para poder resolver mis inquietudes sin necesidad de contactar directamente al soporte.

  Scenario: Acceder a la sección de FAQ desde Configuración o Perfil
    Given el usuario está en la pantalla de Configuración o en su perfil
    When busca y presiona la opción "Centro de Ayuda" o "Preguntas Frecuentes"
    Then debe abrirse una pantalla con una lista de categorías de preguntas (ej: "Sobre Citas", "Sobre Pagos", "Mi Cuenta")

  Scenario: Expandir categoría y ver preguntas comunes
    Given el usuario presiona una categoría como "Sobre Citas"
    When se expande la categoría
    Then debe mostrar una lista de preguntas comunes (ej: "¿Cómo reprogramo una cita?", "¿Puedo cancelar?")
    And al tocar cada pregunta, debe mostrarse su respuesta

  Scenario: Botón para contactar soporte si no encuentra la respuesta
    Given el usuario no encuentra su respuesta en las FAQ
    When llega a la parte inferior de la pantalla
    Then debe ver un botón que diga "¿No encontraste lo que buscabas? Contactar con soporte"
