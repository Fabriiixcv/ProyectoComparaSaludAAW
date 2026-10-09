Feature: Centro de Configuración Unificado
  Como usuario,
  quiero un centro de configuración accesible desde mi perfil donde pueda modificar todas mis preferencias,
  para gestionar cómodamente todas las opciones de la app desde un solo lugar.

  Scenario: Acceder al centro de configuración desde el perfil
    Given el usuario está en su perfil
    When presiona el ícono de engranaje o "Configuración" en la esquina superior derecha
    Then debe navegar a una pantalla que agrupe todas las opciones de configuración en secciones claras (Notificaciones, Privacidad, Cuenta, etc.)

  Scenario: Guardado automático de cambios en configuración
    Given el usuario realiza un cambio en cualquier opción de configuración (por ejemplo, activar/desactivar un toggle)
    When salga de esa pantalla o se desplace a otra sección
    Then el cambio debe guardarse automáticamente sin necesidad de un botón de "Guardar" global

  Scenario: Persistencia de cambios después de cerrar la app
    Given el usuario cierra la app después de modificar la configuración
    When la vuelva a abrir
    Then los cambios realizados deben persistir y reflejarse en el comportamiento de la aplicación
