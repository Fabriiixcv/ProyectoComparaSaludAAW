Feature: Página de detalle - lista de precios

  Como usuario
  Al seleccionar un proveedor
  Quiero ver una página de detalle con una lista completa de servicios con precios exactos y transparentes
  Para conocer los costos antes de agendar una cita

  Scenario: Mostrar lista de servicios y precios
    Given que el usuario está en la página de detalle de un proveedor
    When se desplaza a la sección "Servicios y Precios"
    Then el sistema muestra una lista con los servicios disponibles, por ejemplo:
      | Servicio                 | Precio      |
      | Consulta dermatológica   | S/ 80.00    |
      | Hemograma completo       | S/ 45.00    |

  Scenario: Mostrar precios promocionales resaltados
    Given que un servicio tiene un precio promocional
    When se muestra en la lista
    Then debe visualizarse el precio original tachado
    And el nuevo precio promocional resaltado en un color distintivo

  Scenario: Mostrar descripción del servicio seleccionado
    Given que el usuario presiona un servicio en la lista
    When lo selecciona
    Then el sistema expande ese servicio
    And muestra una breve descripción del contenido o beneficios del mismo
