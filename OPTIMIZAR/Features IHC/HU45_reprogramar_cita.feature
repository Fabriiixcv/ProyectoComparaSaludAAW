Feature: Reprogramación de Cita
  Como usuario,
  Quiero poder reprogramar una cita (cambiar fecha/hora) de manera fácil
  Para ajustar mi agenda según disponibilidad del proveedor.

  Scenario: Abrir calendario interactivo al reprogramar
    Given el usuario selecciona una cita próxima
    When presiona el botón "Reprogramar"
    Then el sistema abre el calendario interactivo de disponibilidad
    And muestra las nuevas fechas y horarios libres del proveedor

  Scenario: Confirmar nueva fecha y hora
    Given el usuario selecciona un nuevo horario para su cita
    When confirma la reprogramación
    Then el sistema invalida el horario anterior
    And crea una nueva cita con los datos actualizados

  Scenario: Enviar confirmación de reprogramación
    Given el usuario reprograma una cita exitosamente
    When el proceso termina
    Then el usuario recibe un nuevo correo electrónico de confirmación
    And el correo incluye los detalles de la nueva fecha y hora
