Feature: Comparación Side-by-Side de Proveedores
  Como usuario,
  Quiero seleccionar hasta 3 proveedores de la lista de resultados
  Para compararlos en una tabla side-by-side con columnas de precio, rating, distancia y servicios clave.

  Scenario: Activar modo comparación al seleccionar proveedores
    Given el usuario está en la lista de resultados de proveedores
    When mantiene presionado un ítem o selecciona la casilla de verificación de un proveedor
    Then se activa el "modo comparación"
    And el usuario puede seleccionar hasta 3 proveedores

  Scenario: Comparar dos proveedores seleccionados
    Given el usuario ha seleccionado 2 proveedores en modo comparación
    When presiona el botón "Comparar"
    Then se abre una nueva pantalla
    And se muestra una tabla side-by-side con ambos proveedores
    And se comparan los atributos clave: precio, rating, distancia y servicios

  Scenario: Intentar seleccionar un cuarto proveedor
    Given el usuario ya ha seleccionado 3 proveedores en modo comparación
    When intenta seleccionar un cuarto proveedor
    Then el sistema muestra el mensaje "Solo puedes comparar hasta 3 proveedores a la vez"
