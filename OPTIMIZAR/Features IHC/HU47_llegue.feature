Feature: Botón "Llegué" para Notificar al Proveedor
  Como usuario,
  Quiero tener un botón "Llegué" para notificar al proveedor cuando esté en el establecimiento
  Para optimizar los tiempos de espera y agilizar la atención.

  Scenario: Mostrar botón "Llegué" el día de la cita
    Given es el día de la cita
    And el usuario está físicamente en la ubicación del proveedor
    When abre los detalles de la cita en la app
    Then debe ver un botón prominente de "Llegué" o "Check-in"

  Scenario: Notificar al proveedor y cambiar estado del botón
    Given el usuario presiona el botón "Llegué"
    When la notificación se envía al establecimiento
    Then el botón cambia su texto a "Notificado"
    And el botón se deshabilita

  Scenario: Detectar discrepancia de ubicación
    Given el usuario presiona "Llegué" pero no está cerca del establecimiento
    When el sistema detecta la discrepancia mediante GPS
    Then se muestra el mensaje "Para usar esta función, debes estar en la ubicación del establecimiento"
