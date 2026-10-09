Feature: Configuración de plan de salud

  Como usuario
  Quiero poder configurar mi plan de salud (seguro médico, particular, etc.)
  Para filtrar proveedores que lo acepten

  Scenario: Mostrar lista de opciones de plan de salud
    Given que el usuario está en la sección de edición de su perfil
    When selecciona la opción "Plan de Salud"
    Then se despliega una lista de opciones como "Particular", "Seguro XYZ" y "Otro"

  Scenario: Asociar plan de salud al perfil del usuario
    Given que el usuario selecciona "Seguro XYZ" de la lista de planes de salud
    When guarda los cambios
    Then el perfil del usuario queda asociado al plan "Seguro XYZ"

  Scenario: Ingreso manual de plan de salud personalizado
    Given que el usuario selecciona "Otro" de la lista de planes de salud
    When guarda los cambios
    Then se muestra un campo de texto opcional
    And el usuario puede es
