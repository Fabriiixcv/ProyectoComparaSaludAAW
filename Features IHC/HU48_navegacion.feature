Feature: Navegación Integrada al Establecimiento
  Como usuario,
  Quiero acceder a un botón de "Navegación" desde los detalles de la cita
  Para abrir Google Maps o Apple Maps y guiarme hasta el lugar fácilmente.

  Scenario: Mostrar icono de navegación junto a la dirección
    Given el usuario visualiza los detalles de una cita próxima
    When ve la dirección del establecimiento
    Then debe haber un icono de "navegación" (una flecha) junto a la dirección

  Scenario: Abrir app de mapas según sistema operativo
    Given el usuario presiona el icono de navegación
    When el sistema detecta el SO del dispositivo
    Then se abre la app de mapas por defecto
    And la ruta se traza desde la ubicación actual hasta el establecimiento
    # Google Maps en Android, Apple Maps en iOS

  Scenario: Abrir versión web de mapas si no hay app instalada
    Given el usuario no tiene una app de mapas instalada
    When presiona el icono de navegación
    Then se abre la versión web de Google Maps en el navegador
