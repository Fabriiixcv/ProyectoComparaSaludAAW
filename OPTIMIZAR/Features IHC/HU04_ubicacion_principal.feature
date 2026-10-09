Feature: Guardado de ubicación principal

  Como usuario
  Quiero que la aplicación solicite y guarde mi ubicación principal
  Para que las búsquedas me muestren opciones cercanas por defecto

  Scenario: Solicitud de permiso para acceder a la ubicación
    Given que el usuario está completando su perfil por primera vez
    When llega al paso "Ubicación"
    Then la aplicación solicita permiso para acceder a su ubicación GPS

  Scenario: Autocompletar dirección con el GPS habilitado
    Given que el usuario ha concedido el permiso de ubicación
    When el GPS obtiene las coordenadas actuales
    Then el campo "Dirección principal" se autocompleta con la dirección aproximada

  Scenario: Ingreso manual de la ubicación sin permiso de GPS
    Given que el usuario no concede el permiso de ubicación
    When se muestra el campo de dirección
    Then el usuario puede ingresar manualmente su ciudad o código postal
