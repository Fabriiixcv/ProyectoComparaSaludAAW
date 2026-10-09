Feature: Filtro por distancia máxima

  Como usuario
  Quiero aplicar filtros a los resultados de búsqueda por distancia máxima desde mi ubicación
  Para visualizar solo los proveedores cercanos a mí

  Scenario: Mostrar opciones de filtro por distancia
    Given que el usuario tiene la ubicación activada
    When accede al panel de filtros
    Then debe ver un selector de "Distancia máxima" con opciones predefinidas como:
      | Opción |
      | 1 km   |
      | 5 km   |
      | 10 km  |

  Scenario: Aplicar filtro de distancia con valor válido
    Given que el usuario selecciona "5 km" como distancia máxima
    When aplica el filtro
    Then los resultados se recalculan mostrando solo los proveedores dentro de un radio de 5 kilómetros desde su ubicación actual

  Scenario: Intentar usar filtro sin activar la ubicación
    Given que el usuario no tiene la ubicación activada
    When intenta usar el filtro de distancia
    Then el sistema muestra un mensaje "Activa la ubicación para usar este filtro"
    And no aplica ningún cambio en los resultados
