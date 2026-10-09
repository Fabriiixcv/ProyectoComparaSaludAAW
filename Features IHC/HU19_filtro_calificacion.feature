Feature: Filtro por calificación mínima

  Como usuario
  Quiero aplicar filtros a los resultados de búsqueda por calificación mínima de otros pacientes
  Para visualizar solo los proveedores mejor valorados

  Scenario: Mostrar selector de calificación mínima
    Given que el usuario accede al panel de filtros
    When se muestra la opción "Calificación mínima"
    Then debe visualizar un selector de estrellas que permita elegir un valor desde 1 hasta 5 estrellas

  Scenario: Aplicar filtro de calificación mínima
    Given que el usuario selecciona "4 estrellas" como calificación mínima
    When aplica los filtros
    Then la lista de resultados muestra únicamente los proveedores con una calificación promedio igual o superior a 4 estrellas

  Scenario: Excluir proveedores con calificación inferior al filtro
    Given que un proveedor tiene una calificación de 3.8 estrellas
    When el filtro está establecido en 4 estrellas
    Then dicho proveedor no debe aparecer en los resultados filtrados
