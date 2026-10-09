Feature: Vista de lista de resultados

  Como usuario
  Quiero visualizar los resultados de búsqueda en formato de lista
  Para comparar fácilmente los proveedores según sus datos principales

  Scenario: Mostrar resultados de búsqueda en formato lista
    Given que el usuario ha realizado una búsqueda válida
    When el sistema muestra los resultados
    Then cada resultado debe visualizarse como una tarjeta o fila que incluya:
      | Dato                  |
      | Nombre del proveedor  |
      | Especialidad          |
      | Distancia aproximada  |
      | Calificación promedio |

  Scenario: Acceder al perfil del proveedor desde la lista
    Given que el usuario visualiza la lista de resultados
    When selecciona un proveedor
    Then el sistema debe abrir la pantalla de perfil de ese proveedor con su información completa

  Scenario: Indicar cuando no hay resultados en la lista
    Given que el usuario realiza una búsqueda sin coincidencias
    When el sistema intenta most
