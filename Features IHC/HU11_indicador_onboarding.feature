Feature: Verificación de correo electrónico

  Como usuario
  Quiero recibir un enlace de verificación al registrarme con mi correo
  Para confirmar que mi dirección de correo electrónico es válida y pertenece a mí

  Scenario: Envío del enlace de verificación
    Given que el usuario ha completado su registro con un correo válido
    When finaliza el proceso de registro
    Then el sistema envía un correo electrónico con un enlace de verificación a la dirección registrada

  Scenario: Confirmación del correo mediante enlace
    Given que el usuario recibe el correo de verificación
    When hace clic en el enlace de verificación
    Then el sistema marca la cuenta como verificada
    And muestra un mensaje de confirmación "Correo verificado correctamente"

  Scenario: Intento de ingreso sin verificar el correo
    Given que el usuario intenta iniciar sesión sin haber verificado su correo
    When ingresa sus credenciales
    Then el sistema muestra un mensaje de alerta indicando "Debes verificar tu correo antes de continuar"
