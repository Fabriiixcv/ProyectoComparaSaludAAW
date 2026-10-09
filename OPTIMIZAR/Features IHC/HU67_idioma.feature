Feature: Cambio de Idioma de la Interfaz
  Como usuario,
  quiero poder cambiar el idioma de la interfaz (español, inglés),
  para entender mejor la información presentada en la app.

  Scenario: Visualizar selector de idioma en Configuración
    Given el usuario está en "Configuración" > "General"
    When encuentra la opción "Idioma de la aplicación"
    Then debe mostrarse un selector que indique los idiomas disponibles (ej: "Español", "English")

  Scenario: Cambiar idioma de la app a inglés
    Given el usuario selecciona "English" en el selector de idioma
    When confirma el cambio
    Then toda la interfaz de la app (menús, botones, etiquetas) debe recargarse inmediatamente mostrando los textos en inglés

  Scenario: Mantener contenidos dinámicos en su idioma original
    Given el usuario cambia el idioma a inglés
    When la app se recarga
    Then los contenidos dinámicos como nombres de proveedores y reseñas deben mantenerse en su idioma original
