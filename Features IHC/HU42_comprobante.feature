Feature: Comprobante de Cita por Email y Push
  Como usuario,
  Quiero recibir un correo electrónico y una notificación push con el comprobante de la cita
  Para tener un registro y recordatorio de mi cita.

  Scenario: Enviar correo electrónico con comprobante al confirmar cita
    Given el usuario confirma una cita exitosamente
    When el sistema procesa la reserva
    Then se envía automáticamente un correo electrónico a la cuenta registrada
    And el correo incluye un comprobante en PDF adjunto o los detalles de la cita en el cuerpo del mail

  Scenario: Enviar notificación push al confirmar cita
    Given el usuario tiene las notificaciones push activadas
    When la cita es confirmada
    Then el usuario recibe una notificación inmediata en su dispositivo
    And el mensaje indica "Cita confirmada para [fecha] a las [hora]"

  Scenario: Manejo cuando no hay aplicación de email configurada
    Given el usuario no tiene una aplicación de email configurada en su dispositivo
    When presiona "Abrir correo" desde la app
    Then el sistema sugiere copiar los detalles de la cita al portapapeles
