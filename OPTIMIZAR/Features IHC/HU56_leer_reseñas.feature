Feature: Lectura de Reseñas de Otros Pacientes
  Como usuario,
  quiero leer las reseñas y calificaciones de otros pacientes antes de tomar una decisión,
  para conocer las experiencias previas y evaluar la calidad del proveedor.

  Scenario: Visualizar reseñas en la sección "Opiniones"
    Given el usuario está en la página de detalle de un proveedor
    When se desplaza a la sección "Opiniones"
    Then debe ver una lista de reseñas recientes o más útiles
    And cada reseña debe mostrar la puntuación, el texto y la fecha

  Scenario: Mostrar reseñas largas truncadas con opción de expansión
    Given existe una reseña con un texto muy largo
    When se muestra en la lista de reseñas
    Then debe truncarse después de 3 líneas de texto
    And debe aparecer un enlace "Leer más" para expandirla completamente

  Scenario: Cargar más reseñas al llegar al final de la lista
    Given un proveedor tiene más de 20 reseñas
    When el usuario llega al f
