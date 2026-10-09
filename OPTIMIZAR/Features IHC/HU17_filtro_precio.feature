Feature: Filtro por rango de precios

  Como usuario
  Quiero aplicar filtros a los resultados de búsqueda por rango de precios
  Para ver solo los servicios que se ajusten a mi presupuesto

  Scenario: Mostrar opción de filtro por precio
    Given que el usuario presiona el botón "Filtrar"
    When se despliega el panel de filtros
    Then debe existir una opción "Precio" con dos campos de entrada: "Mínimo" y "Máximo"

  Scenario: Aplicar filtro con rango de precios válido
    Given que el usuario establece un rango de precio entre S/ 30 y S/ 80
    When aplica los filtros
    Then la lista de resultados se actualiza mostrando solo los servicios cuyo precio esté dentro de ese rango

  Scenario: Mostrar error si el rango de precios es inválido
    Given que el usuario ingresa un valor máximo menor al mínimo
    When intenta aplicar el filtro
    Then el sistema muestra un mensaje de error "El precio máximo no puede ser menor al mínimo"
    And no aplica el filtro de precios
