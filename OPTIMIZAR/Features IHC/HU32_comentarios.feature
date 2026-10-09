Feature: Página de detalle - evaluaciones y comentarios

  Como usuario
  Al seleccionar un proveedor
  Quiero ver evaluaciones y comentarios de otros pacientes
  Para conocer la reputación y experiencias previas antes de agendar una cita

  Scenario: Mostrar resumen de calificaciones y distribución de estrellas
    Given que el usuario se desplaza a la sección "Opiniones"
    When visualiza dicha sección
    Then debe mostrarse un resumen con la calificación promedio y la distribución de estrellas
    And se indican porcentajes como "50% de las reseñas son de 5 estrellas"

  Scenario: Ordenar reseñas por criterio
    Given que hay múltiples reseñas disponibles
    When el usuario accede al menú de ordenamiento
    Then debe poder ordenar las reseñas por "Más recientes" o "Más útiles"

  Scenario: Expandir reseñas largas
    Given que un usuario ha escrito una reseña muy extensa
    When la reseña se muestra truncada en la lista
    Then debe incluir un botón "Leer más"
    And al presionarlo, se expande
