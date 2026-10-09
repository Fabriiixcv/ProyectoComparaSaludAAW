Feature: Calendario Interactivo de Disponibilidad
  Como usuario,
  Quiero ver un calendario interactivo con los horarios disponibles
  Para seleccionar fecha y hora para mi cita desde la página de detalle de un proveedor.

  Scenario: Mostrar calendario con días habilitados según disponibilidad
    Given el usuario presiona el botón "Agendar Cita" en la página de un proveedor
    When se abre la pantalla de agendamiento
    Then debe mostrarse un calendario mensual
    And los días con disponibilidad deben estar habilitados
    And los días sin disponibilidad deben estar deshabilitados

  Scenario: Mostrar horarios disponibles al seleccionar un día
    Given el usuario selecciona un día con disponibilidad en el calendario
    When hace clic sobre ese día
    Then debe mostrarse una lista de horarios disponibles para ese día
    And los horarios pueden ser ejemplos como 9:00 am, 9:30 am, 10:00 am

  Scenario: Habilitar botón "Continuar" al seleccionar un horario
    Given el usuario selecciona un horario disponible de la lista
    When lo presiona
    Then el botón "Continuar" debe habilitarse
    And el usuario puede avanzar al siguiente paso del agendamiento
