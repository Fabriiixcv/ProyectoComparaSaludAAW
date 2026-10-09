Feature: Descarga de Copia de Datos Personales
  Como usuario,
  quiero poder descargar una copia de mis datos personales y mi historial de citas en la app,
  para tener un respaldo de mi información.

  Scenario: Solicitar descarga de datos
    Given el usuario está en "Configuración" > "Privacidad y Datos"
    When presiona la opción "Descargar mis datos"
    Then el sistema debe solicitar confirmación
    And luego comenzar a preparar un archivo (ej: en formato .ZIP o .JSON)

  Scenario: Notificación de archivo listo y entrega
    Given el archivo con los datos del usuario está listo
    When la preparación finaliza
    Then la app debe mostrar un enlace de descarga
    And/o enviar el archivo adjunto al correo electrónico registrado del usuario

  Scenario: Contenido del archivo descargado
    Given el usuario descarga el archivo
    When lo abre
    Then debe contener secciones legibles con su información de perfil
    And historial completo de citas y reseñas realizadas
