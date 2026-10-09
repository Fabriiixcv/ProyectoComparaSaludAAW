Feature: Calificación General con Estrellas
  Como usuario,
  quiero poder calificar a un proveedor con una puntuación de 1 a 5 estrellas después de una cita,
  para expresar mi nivel de satisfacción con el servicio recibido.

  Scenario: Mostrar selector de estrellas en el formulario de calificación
    Given el usuario accede al formulario de calificación desde la notificación o desde su lista de citas pasadas
    When se muestra la pantalla de calificación
    Then el usuario debe ver un selector de 5 estrellas vacías para elegir su puntuación

  Scenario: Iluminación interactiva de las estrellas al deslizar
    Given el usuario está visualizando el selector de estrellas
    When pasa el dedo de izquierda a derecha sobre las estrellas
    Then las estrellas deben iluminarse de forma interactiva indicando la puntuación seleccionada

  Scenario: Confirmación visual de la calificación seleccionada
    Given el usuario selecciona una puntuación de 4 estrellas
    When retira el dedo de la pantalla
    Then las primeras 4 estrellas deben quedar sólidas y la quinta vacía
    And se debe confirmar visualmente su elección
