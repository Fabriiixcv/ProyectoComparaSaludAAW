Feature: Canal de Soporte Integrado
  Como usuario,
  quiero un canal de soporte integrado en la app (chat o formulario) 
  para contactar al equipo de ComparaSalud en caso de problemas.

  Scenario: Acceder al formulario de soporte desde el Centro de Ayuda
    Given el usuario accede al "Centro de Ayuda"
    When presiona el botón "Contactar con Soporte"
    Then debe abrirse un formulario con campos para "Asunto", "Descripción del problema" 
    And la opción de adjuntar capturas de pantalla

  Scenario: Confirmación de envío del ticket de soporte
    Given el usuario envía un ticket de soporte
    When el formulario se envía correctamente
    Then debe recibir una notificación en pantalla que diga "Tu mensaje fue enviado. Te contactaremos al correo: [usuario@email.com] en un plazo de 24 horas"

  Scenario: Pre-poblado del campo Asunto para problemas con citas específicas
    Given el usuario tiene problemas con una cita específica
    When abre el formulario de soporte desde los detalles de dicha cita
    Then el campo "Asunto" debe venir pre-poblado con el ID de la cita para agilizar el proceso
