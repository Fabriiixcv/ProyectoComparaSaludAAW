Feature: Compartir Detalles de la Cita
  Como usuario,
  quiero poder compartir los detalles de una cita agendada por WhatsApp o mensaje de texto con un familiar,
  para informar fácilmente sobre mi cita sin tener que escribir los datos manualmente.

  Scenario: Desplegar menú de compartir desde los detalles de una cita
    Given el usuario visualiza los detalles de una cita agendada
    When presiona el icono de "Compartir"
    Then debe desplegarse el menú de compartir nativo del dispositivo

  Scenario: Compartir cita por WhatsApp
    Given el usuario selecciona "WhatsApp" desde el menú de compartir
    When se abre la aplicación de WhatsApp
    Then debe generarse un mensaje predefinido con el texto "Tengo cita en [Lugar] el [fecha] a las [hora]"

  Scenario: Proteger información del mensaje compartido
    Given el usuario está compartiendo los detalles de una cita
    When se genera el mensaje predefinido
    Then la información debe ser de solo lectura para evitar modificaciones accidentales
