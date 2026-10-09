Feature: Reseña de Texto Opcional
  Como usuario,
  quiero poder escribir una reseña de texto opcional detallando mi experiencia con el proveedor,
  para compartir comentarios adicionales sobre la calidad del servicio si así lo deseo.

  Scenario: Mostrar campo de texto opcional para reseña
    Given el usuario ha seleccionado una calificación con estrellas
    When se muestra el campo "Comparte tu experiencia (opcional)"
    Then debe visualizarse un área de texto multilínea donde pueda escribir libremente

  Scenario: Limitar la reseña a 500 caracteres
    Given el usuario está escribiendo una reseña en el campo de texto
    When la reseña excede los 500 caracteres
    Then debe aparecer un contador que indique "X/500"
    And no debe permitir escribir más allá de ese límite

  Scenario: Enviar calificación sin reseña
    Given el usuario no desea escribir un comentario
    When deja el campo de texto en blanco y envía la calificación
    Then el sistema debe aceptar el envío sin errores
    And debe guardar únicamente la puntuación con estrellas
