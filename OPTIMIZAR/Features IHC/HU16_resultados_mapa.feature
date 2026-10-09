Feature: Vista de mapa interactivo

  Como usuario
  Quiero visualizar los resultados de búsqueda en un mapa interactivo
  Para ubicar fácilmente a los proveedores cercanos a mi ubicación

  Scenario: Mostrar resultados de búsqueda en el mapa
    Given que el usuario ha realizado una búsqueda
    When selecciona la vista de mapa
    Then el sistema muestra un mapa interactivo con marcadores en la ubicación de cada proveedor encontrado

  Scenario: Mostrar detalles al seleccionar un marcador
    Given que el mapa muestra varios proveedores
    When el usuario presiona un marcador específico
    Then se muestra una tarjeta emergente con información resumida del proveedor, incluyendo:
      | Dato                 |
      | Nombre               |
      | Especialidad         |
      | Calificación promedio |

  Scenario: Centrar el mapa en la ubicación actual del usuario
    Given que el usuario ha concedido permiso de ubicación
    When abre la vista de mapa
    Then el mapa se centra automáticamente en su ubicación actual
