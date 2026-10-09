Feature: Registro rápido con red social

  Como usuario
  Quiero registrarme con un solo clic usando mi cuenta de Google o Facebook
  Para agilizar el proceso de onboarding

  Scenario: Registro con cuenta de Google exitoso
    Given que el usuario está en la pantalla de registro
    When presiona el botón "Registrarse con Google"
    Then se abre la ventana de autenticación oficial de Google
    And el usuario ingresa sus credenciales correctamente
    And la aplicación recibe los datos del perfil (nombre, email)
    Then el sistema crea automáticamente la cuenta
    And redirige al usuario a la pantalla principal de la aplicación

  Scenario: Registro con cuenta de Facebook exitoso
    Given que el usuario está en la pantalla de registro
    When presiona el botón "Registrarse con Facebook"
    Then se abre la ventana de autenticación oficial de Facebook
    And el usuario ingresa sus credenciales correctamente
    And la aplicación recibe los datos del perfil (nombre, email)
    Then el sistema crea automáticamente la cuenta
    And redirige al usuario a la pantalla principal de la aplicación

  Scenario: Cancelación del registro con red social
    Given que el usuario inició el proceso de registro con una red social
    When cierra la ventana emergente de autenticación sin completar el ingreso
    Then el sistema cancela el proceso de reg
