Feature: Sistema de Utilidad de las Reseñas
  Como usuario,
  quiero poder marcar una reseña como "Útil" o "No útil",
  para que el sistema priorice las opiniones más relevantes según la valoración de otros pacientes.

  Scenario: Mostrar opciones para marcar una reseña como útil o no útil
    Given el usuario está leyendo una reseña de otro paciente
    When visualiza la opción "¿Te resultó útil esta reseña?"
    Then deben mostrarse dos botones: un pulgar hacia arriba ("Sí") y un pulgar hacia abajo ("No")

  Scenario: Marcar una reseña como útil
    Given el usuario encuentra una reseña muy detallada
    When presiona el botón de pulgar hacia arriba ("Sí")
    Then el contador de "Útil" de esa reseña debe incrementarse en uno
    And el botón debe cambiar de color para indicar que el voto fue registrado

  Scenario: Anular voto de utilidad en una reseña
    Given el usuario ya ha votado una reseña como "Útil"
    When presiona nuevamente el mismo botón de pulgar hacia arriba
    Then el sistema debe anular su voto
    And el contador de "Útil" debe decrementarse en uno
    And el botón debe regresar a su estado neutral
