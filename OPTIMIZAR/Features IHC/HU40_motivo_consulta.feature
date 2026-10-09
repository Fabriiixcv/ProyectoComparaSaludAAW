Feature: Confirmación Inmediata de la Cita
  Como usuario,
  Quiero recibir una confirmación inmediata en pantalla con un resumen de la cita
  Para asegurarme de que mi reserva fue exitosa y disponer de los detalles importantes.

  Scenario: Mostrar pantalla de confirmación al completar el agendamiento
    Given el usuario completa el proceso de agendamiento y presiona "Confirmar Cita"
    When la reserva es exitosa
    Then se muestra una pantalla de confirmación con un tick verde
    And se muestra un resumen detallado de la cita

  Scenario: Incluir información completa del resumen de la cita
    Given la cita ha sido confirmada
    When el usuario ve el resumen
    Then el resumen debe incluir claramente: Nombre del centro, dirección, fecha, hora y nombre del paciente

  Scenario: Incluir botones de acción en la confirmación
    Given la cita ha sido confirmada
    When se muestra la pantalla de confirmación
    Then debe incluir un botón "Agregar a mi calendario"
    And un botón "Volver al inicio"
