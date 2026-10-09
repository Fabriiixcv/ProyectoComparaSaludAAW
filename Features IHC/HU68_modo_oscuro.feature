Feature: Activación del Modo Oscuro
  Como usuario,
  quiero una opción de "Modo Oscuro",
  para reducir la fatiga visual en entornos con poca luz.

  Scenario: Visualizar selector de modo en Configuración
    Given el usuario está en "Configuración" > "Apariencia"
    When encuentra el selector "Modo"
    Then debe mostrar las opciones "Claro", "Oscuro" y "Automático (según el sistema)"

  Scenario: Aplicar modo oscuro manualmente
    Given el usuario selecciona "Oscuro" en el selector de modo
    When la configuración se aplica
    Then el fondo de todas las pantallas de la app debe cambiar a un color oscuro
    And los textos deben cambiar a un color claro
    And los botones y elementos deben usar una paleta acorde al modo oscuro

  Scenario: Activar modo oscuro automático según sistema
    Given el usuario selecciona "Automático" en el selector de modo
    When el sistema operativo cambia al modo oscuro (por ejemplo, al anochecer)
    Then la app debe cambiar automáticamente al modo oscuro sin necesidad de reiniciarse
