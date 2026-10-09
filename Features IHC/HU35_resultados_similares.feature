Feature: Recomendación de Resultados Similares
  Como usuario,
  Quiero que la app me muestre "Resultados similares" o "Otros usuarios también vieron"
  Para explorar más opciones desde la página de detalle de un proveedor.

  Scenario: Mostrar sección de proveedores similares al final de la página
    Given el usuario está al final de la página de detalle de un proveedor
    When se desplaza hacia abajo
    Then debe ver una sección titulada "Proveedores similares"
    And se muestra una lista horizontal de otras opciones

  Scenario: Filtrar proveedores similares por tipo y zona
    Given el proveedor actual es un laboratorio clínico
    When se muestran "proveedores similares"
    Then estos deben ser otros laboratorios clínicos de la misma zona

  Scenario: Navegar a detalle de un proveedor similar
    Given el usuario ve un proveedor en la sección "Proveedores similares"
    When selecciona ese proveedor
    Then debe navegar a la página de detalle de ese nuevo proveedor
