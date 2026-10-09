Feature: Saltar el onboarding inicial

  Como usuario
  Quiero poder saltarme el onboarding inicial y configurar mi perfil más tarde
  Para empezar a usar la aplicación inmediatamente si tengo prisa

  Scenario: Omitir el onboarding desde la primera pantalla
    Given que el usuario está en la primera pantalla del tutorial
    When presiona el botón "Saltar" ubicado en la esquina superior derecha
    Then el sistema cierra el tutorial
    And redirige al usuario a la pantalla de registro o inicio de sesión

  Scenario: Cargar configuración por defecto tras omitir el onboarding
    Given que el usuario ha omitido el proceso de onboarding
    When inicia sesión por primera vez
    Then la aplicación carga valores por defecto como:
      | Configuración | Valor            |
      | Ubicación      | No definida      |
      | Plan de salud  | Particular       |
    And muestra un badge o indicador en el ícono de perfil invitando a completarlo más tarde

  Scenario: Completar el onboarding posteriormente
    Given que el usuario desea completar su perfil más adelante
    When accede a su perfil
    Then debe encontrar una sección llamada "Completa tu perfil"
    And un botón que permita reiniciar el flujo de configuración paso a paso
