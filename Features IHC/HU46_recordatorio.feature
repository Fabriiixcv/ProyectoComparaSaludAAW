Feature: Recordatorios Automáticos de Cita
  Como usuario,
  Quiero recibir un recordatorio automático de mi cita por push/email 24 horas y 1 hora antes
  Para no olvidar mis citas y llegar a tiempo.

  Scenario: Enviar notificación 24 horas antes de la cita
    Given una cita está programada
    When faltan 24 horas para la cita
    Then el sistema envía automáticamente una notificación push
    And el mensaje indica "Recuerda tu cita mañana a las [hora] en [establecimiento]"

  Scenario: Enviar notificación 1 hora antes de la cita
    Given una cita está programada
    When falta 1 hora para la cita
    Then el sistema envía una notificación push recordatoria
    And incluye un botón de acción "Ver detalles" o "Llegué"

  Scenario: No enviar recordatorios si el usuario los desactiva
    Given el usuario ha desactivado los recordatorios en su configuración
    When se acerque la hora de la cita
    Then el sistema NO envía ninguna notificación push
