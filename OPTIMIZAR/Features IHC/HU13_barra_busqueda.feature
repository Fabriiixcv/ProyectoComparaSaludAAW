Feature: Búsqueda por palabra clave

  Como usuario
  Quiero poder buscar proveedores o servicios escribiendo palabras clave
  Para encontrar rápidamente lo que necesito sin navegar por todas las categorías

  Scenario: Realizar búsqueda con palabra clave válida
    Given que el usuario está en la pantalla principal de búsqueda
    When ingresa una palabra clave en el campo de búsqueda (por ejemplo, "dentista" o "laboratorio")
    And presiona el botón de buscar o la tecla Enter
    Then el sistema muestra una lista de resultados relacionados con la palabra ingresada

  Scenario: No se encuentran resultados para la búsqueda
    Given que el usuario ingresa una palabra clave sin coincidencias
    When realiza la búsqueda
    Then el sistema muestra un mensaje "No se encontraron resultados para tu búsqueda"
    And sugiere revisar la ortografía o intentar con otro término

  Scenario: Mostrar resultados sugeridos mientras el usuario escribe
    Given que el usuario está escribiendo una palabra clave en el campo de búsqueda
    When ha ingresado al menos tres caracteres
    Then el sistema muestra sugerencias automáticas basadas en búsquedas recientes o populares
