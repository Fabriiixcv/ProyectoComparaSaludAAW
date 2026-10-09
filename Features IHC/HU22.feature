Feature: Filtro por disponibilidad de citas

  Como usuario
  Quiero aplicar filtros a los resultados de búsqueda por disponibilidad de citas
  Para visualizar solo los proveedores que tengan horarios disponibles en el rango de tiempo que necesito

  Scenario: Mostrar opciones de disponibilidad
    Given que el usuario accede al panel de filtros
    When se muestra la opción "Disponibilidad"
    Then el sistema debe permitir seleccionar entre las opciones:
      | Opción            |
      | Hoy               |
      | Esta semana       |
      | Próximos 15 días  |

  Scenario: Aplicar filtro de disponibilidad para hoy
    Given que el usuario selecciona la opción "Hoy"
    When aplica los filtros
    Then los resultados deben mostrar únicamente los proveedores que tengan al menos un horario disponible para el día actual

  Scenario: Excluir proveedores sin horarios disponibles
    Given que un proveedor no tiene horarios cargados en el sistema
    When el usuario aplica el filtro por disponibilidad
    Then dicho proveedor no debe aparecer en los resultados
