Feature: Página de detalle - horarios y disponibilidad

  Como usuario
  Al seleccionar un proveedor
  Quiero ver una página de detalle con los horarios de atención y disponibilidad de citas en los próximos días
  Para poder planificar mi cita de manera conveniente

  Scenario: Mostrar horarios de atención general
    Given que el usuario está en la página de detalle del proveedor
    When consulta la sección "Horarios"
    Then el sistema muestra los días de la semana y los rangos horarios de atención del establecimiento

  Scenario: Mostrar calendario de disponibilidad de citas
    Given que el usuario desea ver la disponibilidad específica de citas
    When presiona el botón "Ver disponibilidad"
    Then se muestra un calendario visual con los días de la próxima semana que tienen horarios libres resaltados

  Scenario: Mostrar días no laborables como cerrados
    Given que es domingo y el centro no atiende ese día
    When el usuario consulta los horarios del proveedor
    Then el do
