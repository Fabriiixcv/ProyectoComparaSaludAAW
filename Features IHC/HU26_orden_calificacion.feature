Feature: Ordenar por calificación

  Como usuario
  Quiero ordenar los resultados por calificación (mejor a peor)
  Para visualizar primero a los proveedores con mejor reputación

  Scenario: Mostrar opción de ordenamiento por calificación
    Given que el usuario está en la pantalla de resultados
    When presiona el selector "Ordenar por"
    Then debe visualizar la opción "Mejor calificados"

  Scenario: Ordenar resultados por calificación descendente
    Given que el usuario selecciona "Mejor calificados"
    When la lista de resultados se actualiza
    Then los proveedores deben listarse en orden descendente según su calificación promedio

  Scenario: Desempatar por número de reseñas
    Given que dos proveedores tienen la misma calificación promedio (por ejemplo, 4.5 estrellas)
    When se aplica el orden "Mejor calificados"
    Then el sistema debe ordenar primero al proveedor con mayor cantidad de reseñas
