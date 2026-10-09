Feature: Edición o Eliminación de Reseñas Propias
  Como usuario,
  quiero poder editar o eliminar mi propia reseña dentro de un período de tiempo determinado después de publicarla,
  para corregir errores o actualizar mi opinión según lo necesite.

  Scenario: Mostrar opciones de editar o eliminar reseña dentro de 7 días
    Given un usuario ve una reseña que escribió hace menos de 7 días
    When presiona el menú de opciones (tres puntos) en su reseña
    Then debe visualizar las opciones "Editar reseña" y "Eliminar reseña"

  Scenario: Editar reseña propia
    Given el usuario selecciona "Editar reseña"
    When se abre el formulario de edición
    Then deben cargarse la calificación y el texto original
    And el usuario debe poder modificar ambos campos

  Scenario: Restricción de edición después de 30 días
    Given el usuario intenta editar una reseña que publicó hace más de 30 días
    When accede al menú de opciones de la reseña
    Then la opción "Ed
