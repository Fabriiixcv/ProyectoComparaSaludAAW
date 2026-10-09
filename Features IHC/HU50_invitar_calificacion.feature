Feature: Invitación Automática a Calificar
  Como usuario,
  Quiero que el sistema me invite automáticamente a calificar y reseñar al proveedor después de una cita pasada
  Para compartir mi experiencia y ayudar a otros usuarios.

  Scenario: Enviar notificación push tras la cita
    Given la fecha y hora de una cita han pasado
    When el usuario abre la app dentro de las siguientes 24 horas
    Then debe recibir una notificación push
    And el mensaje dice "¿Cómo fue tu experiencia en [Establecimiento]? Califícalo"

  Scenario: Dirigir al usuario al formulario de calificación
    Given el usuario presiona la notificación para calificar
    When se abre la app
    Then el usuario se dirige directamente a un formulario de calificación
    And el formulario está pre-poblado con el nombre del establecimiento

  Scenario: Mostrar recordatorio en citas pasadas
    Given el usuario no ha calificado la cita después de 3 días
    When entra a la sección "Mis Citas > Pasadas"
    Then debe ver un badge o recordatorio visual en la cita correspondiente
    And el recordatorio invita al usuario a dejar su reseña
