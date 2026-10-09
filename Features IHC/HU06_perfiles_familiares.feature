Feature: Gestión de perfiles familiares

  Como usuario
  Quiero poder ingresar datos de perfiles familiares (nombre, parentesco, fecha de nacimiento)
  Para gestionar las citas de mi familia desde una misma cuenta

  Scenario: Mostrar formulario para agregar un familiar
    Given que el usuario está en la sección "Mi Familia" de su perfil
    When presiona el botón "Agregar Familiar"
    Then se muestra un formulario con los campos "Nombre", "Parentesco" y "Fecha de nacimiento"

  Scenario: Preselección automática de parentesco para menores de edad
    Given que el usuario está llenando el formulario de un familiar
    When ingresa una fecha de nacimiento que indica que el familiar es menor de 18 años
    Then el campo "Parentesco" se preselecciona automáticamente con la opción "Hijo/a"

  Scenario: Mostrar familiares en la agenda de citas
    Given que el usuario ha agregado al menos un familiar
    When accede al paso de selección de paciente al agendar una cita
    Then aparece la opción "Para un familiar"
    And se muestra una lista desplegable con los perfiles familiares guardados
