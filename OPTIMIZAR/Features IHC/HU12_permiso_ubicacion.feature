Feature: Recuperación de contraseña

  Como usuario
  Quiero poder recuperar mi contraseña a través de mi correo electrónico
  Para acceder nuevamente a mi cuenta si la olvido

  Scenario: Solicitar recuperación de contraseña
    Given que el usuario está en la pantalla de inicio de sesión
    When presiona el enlace "¿Olvidaste tu contraseña?"
    Then el sistema muestra un campo para ingresar su correo electrónico registrado

  Scenario: Envío del enlace de restablecimiento
    Given que el usuario ingresó un correo electrónico válido registrado en el sistema
    When confirma la solicitud de recuperación
    Then el sistema envía un enlace de restablecimiento de contraseña al correo indicado

  Scenario: Restablecer la contraseña desde el enlace
    Given que el usuario recibe el correo de recuperaci
