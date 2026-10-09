Feature: Agendar para Perfiles Familiares
  Como usuario,
  Quiero poder agendar una cita para mí o para cualquier miembro de mi perfil familiar previamente configurado
  Para gestionar citas de manera sencilla para toda mi familia.

  Scenario: Seleccionar paciente de perfiles familiares
    Given el usuario tiene perfiles familiares configurados
    And está en el paso de "Seleccionar paciente"
    When se le presentan las opciones
    Then debe poder elegir entre "Para mí" o seleccionar el nombre de un familiar de la lista

  Scenario: Mostrar correctamente el paciente seleccionado en la confirmación
    Given el usuario selecciona agendar para su hijo "Juan Pérez"
    When procede a la confirmación de la cita
    Then el resumen debe mostrar claramente "Paciente: Juan Pérez"

  Scenario: Manejo cuando no hay perfiles familiares configurados
    Given el usuario no ha configurado perfiles familiares
    When llega al paso de "Seleccionar paciente"
    Then la única opción disponible debe ser "Para mí"
