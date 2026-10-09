Feature: Agregar Citas Externas al Calendario

  Scenario: Abrir formulario para agregar cita manual
    Given el usuario está en la sección "Mis Citas"
    When presiona el botón "+" o "Agregar cita manual"
    Then se debe abrir un formulario para ingresar los datos: proveedor, fecha, hora y motivo

  Scenario: Guardar cita externa en el calendario
    Given el usuario ingresó los datos de una cita externa en el formulario
    When presiona "Guardar"
    Then la cita debe agregarse a la lista
    And debe mostrarse con una etiqueta o icono que indique "Agregada manualmente"

  Scenario: Agregar cita manual con fecha pasada
    Given el usuario ingresa los datos de una cita con fecha ya pasada
    When presiona "Guardar"
    Then el sistema debe ubicar automáticamente la cita en la pestaña de "Citas Pasadas"
