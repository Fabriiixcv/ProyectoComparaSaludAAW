Feature: Manejo de Búsquedas sin Resultados
  Como usuario,
  Quiero que la app me muestre un mensaje claro cuando no hay resultados para mi búsqueda
  Para no frustrarme y poder ajustar filtros o términos de búsqueda.

  Scenario: Mostrar mensaje e ilustración cuando no hay resultados
    Given una búsqueda no arroja ningún resultado
    When se carga la pantalla de resultados
    Then se muestra una ilustración amigable (ej: ícono de lupa con cara triste)
    And se muestra el mensaje "No hay resultados para tu búsqueda"

  Scenario: Sugerir limpiar filtros si los filtros son muy estrictos
    Given la búsqueda sin resultados se debió a filtros muy estrictos
    When se muestra el mensaje de no resultados
    Then debe incluir un botón "Limpiar filtros" para facilitar una nueva búsqueda

  Scenario: Sugerir términos más generales si el término es muy específico
    Given la búsqueda sin resultados fue por un término muy específico
    When se muestra el mensaje de no resultados
    Then debe sugerir términos de búsqueda más generales o populares
    And mostrar un ejemplo como "¿Quizás quisiste decir? dermatólogo"
