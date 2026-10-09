Feature: Eliminación Permanente de la Cuenta
  Como usuario,
  quiero una opción clara y sencilla para eliminar permanentemente mi cuenta y todos mis datos asociados,
  para garantizar mi privacidad y poder dar de baja mi información de la app.

  Scenario: Acceder a la opción de eliminación de cuenta
    Given el usuario está en "Configuración" > "Privacidad y Datos"
    When presiona la opción "Eliminar mi cuenta"
    Then el sistema debe mostrar una advertencia clara indicando que la acción es permanente
    And que se borrarán todos los datos asociados

  Scenario: Confirmar eliminación de la cuenta
    Given el usuario ha visto la advertencia de eliminación
    When confirma que desea eliminar su cuenta
    Then el sistema debe procesar la eliminación permanente
    And debe mostrar un mensaje de confirmación indicando que la cuenta y los datos han sido eliminados

  Scenario: Cancelar la eliminación de la cuenta
    Given el usuario accede a la opción "Eliminar mi cuenta"
    When decide cancelar la acción
    Then la cuenta y todos los datos permanecen intactos

  Scenario: Reautenticación antes de eliminar (opcional pero recomendado)
    Given el usuario confirma la eliminación de la cuenta
    When el sistema solicita reautenticación (por ejemplo, contraseña o verificación por correo)
    Then la cuenta solo se elimina si la autenticación es correcta
