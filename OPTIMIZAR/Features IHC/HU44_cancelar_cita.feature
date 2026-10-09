Feature: Cancelación de Cita con Anticipación
  Como usuario,
  Quiero poder cancelar una cita programada desde la app con al menos 24 horas de anticipación
  Para gestionar mis citas de manera flexible y segura.

  Scenario: Solicitar confirmación al cancelar una cita próxima
    Given el usuario selecciona una cita próxima en la lista "Mis Citas"
    When presiona el botón "Cancelar Cita"
    Then el sistema debe mostrar un mensaje modal "¿Estás seguro de cancelar esta cita?"

  Scenario: Manejar cancelaciones de menos de 24 horas
    Given el usuario intenta cancelar una cita que es en menos de 24 horas
    When presiona el botón de cancelar
    Then el sistema muestra el mensaje "Para cancelar, por favor contacta directamente al establecimiento por teléfono"
    And la opción de cancelación online está deshabilitada

  Scenario: Cancelar cita con más de 24 horas de anticipación
    Given el usuario confirma la cancelación de una cita con más de 24 horas de anticipación
    When la cancelación es exitosa
    Then la cita se mueve a la pestaña "Canceladas"
    And el usuario recibe una notificación push de confirmación de cancelación
