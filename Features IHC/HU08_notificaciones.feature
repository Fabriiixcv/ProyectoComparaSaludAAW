Feature: Configuración de preferencias de notificación

  Como usuario
  Quiero establecer notificaciones preferidas (email, push) sobre recordatorios de citas y ofertas
  Para controlar la frecuencia y tipo de mensajes que recibo

  Scenario: Visualizar opciones de notificación
    Given que el usuario accede a "Configuración" > "Notificaciones"
    When se carga la pantalla de notificaciones
    Then debe visualizar interruptores (toggles) para:
      | Opción                |
      | Recordatorios de citas |
      | Ofertas especiales     |
      | Novedades de la app    |

  Scenario: Desactivar notificación de ofertas
    Given que el usuario desactiva el toggle de "Ofertas especiales"
    When se genera una nueva oferta en el sistema
    Then el usuario no debe recibir una notificación push sobre esa oferta

  Scenario: Guardado automático de preferencias
    Given que el usuario modifica alguna preferencia de notificación
    When sale de la pantalla de configuración
    Then los cambios deben guardarse automáticamente sin necesidad de presionar un botón de "Guardar"
