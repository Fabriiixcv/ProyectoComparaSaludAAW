Feature: Registro con correo y contraseña

  Como usuario
  Quiero registrarme usando mi correo electrónico y una contraseña
  Para crear mi cuenta de forma segura

  Scenario: Validar formato correcto del correo electrónico
    Given que el usuario elige la opción "Registrarse con correo"
    When ingresa su email
    Then el sistema valida que el formato sea correcto (por ejemplo: usuario@dominio.com)
    And si el formato es incorrecto, muestra un mensaje de error indicando "Correo no válido"

  Scenario: Validar longitud mínima de la contraseña
    Given que el usuario elige la opción "Registrarse con correo"
    And está ingresando su contraseña
    When la longitud es menor a 6 caracteres
    Then el campo muestra un mensaje de error en tiempo real indicando "La contraseña debe tener al menos 6 caracteres"

  Scenario: Crear cuenta con datos válidos
    Given que el usuario elige la opción "Registrarse con correo"
    And ha ingresado un correo y contraseña válidos
    When presiona el botón "Crear cuenta"
    Then el sistema crea la cuenta del usuario
    And redirige al flujo de onboarding de perfil
