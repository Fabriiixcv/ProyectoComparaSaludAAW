Feature: Combinación de múltiples filtros

  Como usuario
  Quiero poder combinar múltiples filtros a la vez
  Para refinar al máximo mis resultados de búsqueda y encontrar el proveedor ideal

  Scenario: Aplicar múltiples filtros simultáneamente
    Given que el usuario selecciona los filtros "Pediatría", "Distancia < 5 km" y "Precio < S/ 80"
    When presiona el botón "Aplicar"
    Then el sistema aplica todos los filtros de manera conjunta
    And muestra únicamente los resultados que cumplan con las tres condiciones simultáneamente

  Scenario: Mostrar cantidad de filtros activos
    Given que el usuario ha aplicado varios filtros
    When regresa a la pantalla de resultados
    Then se muestra un badge o etiqueta con el texto "X filtros activos" indicando cuántos filtros están en uso

  Scenario: Limpiar todos los filtros aplicados
    Given que el usuario tiene filtros activos
    When presiona el botón "Limpiar filtros" y confirma la acción
    Then todos los filtros se restablecen
    And la lista de resultados muestra nuevamente la búsqueda original sin filtros
