Feature: Calificación por Aspectos Específicos
  Como usuario,
  quiero poder calificar aspectos específicos como "Limpieza del lugar", "Tiempo de espera", "Claridad en costos" y "Trato del personal",
  para ofrecer una evaluación más detallada sobre distintos elementos de mi experiencia.

  Scenario: Mostrar aspectos específicos con sus selectores de estrellas
    Given el usuario está en el formulario de calificación
    When se desplaza hacia abajo después de la calificación general
    Then debe visualizar varios aspectos específicos
    And cada uno debe tener su propio selector de 1 a 5 estrellas

  Scenario: Guardar calificaciones individuales por aspecto
    Given el usuario califica el "Tiempo de espera" con 2 estrellas y la "Limpieza del lugar" con 5 estrellas
    When envía la reseña
    Then el sistema debe almacenar las calificaciones de manera individual para cada aspecto

  Scenario: Enviar reseña sin calificar aspectos específicos
    Given el usuario solo califica la puntuación general
    When envía la reseña sin calificar los aspectos específicos
    Then los aspectos específicos deben guardarse con un valor "No calificado"
    And no deben afectar los promedios
