Feature: Gestión Granular de Notificaciones Push
  Como usuario,
  quiero activar o desactivar los diferentes tipos de notificaciones push (recordatorios, ofertas, novedades) de manera individual,
  para recibir únicamente las notificaciones que me interesen.

  Scenario: Visualizar toggles independientes para notificaciones
    Given el usuario está en "Configuración" > "Notificaciones"
    When visualiza la lista de opciones
    Then debe haber toggles independientes para "Recordatorios de citas", "Ofertas y promociones" y "Novedades de la app"

  Scenario: Desactivar notificaciones de ofertas y promociones
    Given el usuario desactiva el toggle de "Ofertas y promociones"
    When un proveedor publique una nueva oferta
    Then el sistema NO debe enviarle una notificación push sobre ello

  Scenario: Advertencia al desactivar todas las notificaciones
    Given el usuario desactiva todos los toggles de notificaciones
    When intenta salir de la pantalla
    Then el sistema debe mostrar una confirmación: "Al desactivar todas las notificaciones, podrías perderte recordatorios importantes de tus citas. ¿Estás seguro?"
