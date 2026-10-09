Feature: Página de detalle - información general

  Como usuario
  Al seleccionar un proveedor de la lista
  Quiero ver una página de detalle con toda su información general y especialidades
  Para conocer más sobre sus servicios antes de agendar una cita

  Scenario: Mostrar información principal del proveedor
    Given que el usuario selecciona un proveedor desde la lista de resultados
    When se abre la página de detalle
    Then la parte superior debe mostrar:
      | Elemento              |
      | Nombre del centro      |
      | Calificación promedio  |
      | Descripción general o "Acerca de" |

  Scenario: Mostrar sección de especialidades médicas
    Given que el proveedor ofrece múltiples especialidades
    When el usuario se desplaza por la página
    Then debe visualizar una sección claramente etiquetada que liste todas las especialidades médicas del proveedor

  Scenario: Expandir descripción larga del proveedor
    Given que la descripción general del proveedor es extensa
    When el usuario presiona el botón "Ver más"
    Then el texto se expande y muestra la descripción completa
