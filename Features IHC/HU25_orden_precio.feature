Feature: Ordenar por precio

  Como usuario
  Quiero ordenar los resultados por precio (menor a mayor y viceversa)
  Para comparar fácilmente los servicios según su costo

  Scenario: Mostrar opciones de ordenamiento por precio
    Given que el usuario está en la pantalla de resultados
    When presiona el selector "Ordenar por"
    Then debe visualizar las opciones:
      | Opción                 |
      | Precio: Menor a mayor  |
      | Precio: Mayor a menor  |

  Scenario: Ordenar resultados de menor a mayor precio
    Given que el usuario selecciona la opción "Precio: Menor a mayor"
    When la lista de resultados se actualiza
    Then el primer resultado debe corresponder al servicio con el precio más bajo de la búsqueda

  Scenario: Ordenar resultados de mayor a menor precio
    Given que el usuario selecciona la opción "Precio: Mayor a menor"
    When la lista de resultados se actualiza
    Then el primer resultado debe corresponder al servicio con el precio más alto de la búsqueda
