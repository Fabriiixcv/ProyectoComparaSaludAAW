Feature: Tutorial interactivo inicial

  Como usuario nuevo
  Quiero un tutorial interactivo al abrir la app por primera vez
  Para entender rápidamente las funcionalidades principales

  Scenario: Mostrar el tutorial automáticamente al abrir la app
    Given que el usuario instala y abre la aplicación por primera vez
    When se muestra la pantalla de bienvenida
    Then se inicia automáticamente un carrusel con 3 o 4 pantallas que explican las funciones clave (buscar, comparar, agendar)

  Scenario: Navegar entre pantallas del tutorial
    Given que el tutorial está siendo mostrado
    When el usuario desliza el dedo horizontalmente
    Then la aplicación muestra la siguiente o la anterior pantalla explicativa del tutorial

  Scenario: Finalizar el tutorial y redirigir al inicio de sesión
    Given que el usuario está en la última pantalla del tutorial
    When presiona el botón "Comenzar"
    Then el tutorial se cierra
    And el sistema redirige al usuario a la pantalla de registro o inicio de sesión
