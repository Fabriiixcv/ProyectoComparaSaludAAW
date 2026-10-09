Feature: Especificar Motivo de la Consulta
  Como usuario,
  Quiero poder especificar el motivo de la consulta de manera opcional
  Para que el proveedor pueda prepararse para mi cita.

  Scenario: Mostrar campo de texto libre para el motivo de la consulta
    Given el usuario está en el paso de "Detalles de la cita"
    When encuentra el campo "Motivo de la consulta (opcional)"
    Then debe ser un campo de texto libre
    And el usuario puede escribir síntomas o razones de la visita

  Scenario: Mostrar contador de caracteres al exceder límite
    Given el usuario escribe un motivo muy extenso
    When el texto excede los 200 caracteres
    Then debe mostrarse un contador indicando "X/200 caracteres"

  Scenario: Permitir avanzar si el campo se deja en blanco
    Given el usuario deja el campo de motivo en blanco
    When procede al siguiente paso
    Then el sistema permite avanzar sin mostrar errores
