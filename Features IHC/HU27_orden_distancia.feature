Feature: Ordenar por distancia

  Como usuario
  Quiero ordenar los resultados por distancia (más cercano a más lejano)
  Para encontrar fácilmente los proveedores ubicados cerca de mí

  Scenario: Mostrar opción de ordenamiento por distancia
    Given que el usuario tiene la ubicación activada
    When presiona el selector "Ordenar por"
    Then debe visualizar la opción "Más cercanos"

  Scenario: Ordenar resultados desde el más cercano al más lejano
    Given que el usuario selecciona la opción "Más cercanos"
    When la lista de resultados se actualiza
    Then el primer resultado debe ser el proveedor geográficamente más próximo a su ubicación actual

  Scenario: Deshabilitar opción si no hay ubicación activa
    Given que el usuario no tiene la ubicación activada
    When abre el selector "Ordenar por"
    Then la opción "Más cercanos" debe aparecer deshabilitada
    And el sistema puede mostrar un mensaje "Activa tu ubicación para usar esta opción"
