Feature: Respuesta Pública del Proveedor a Reseñas
  Como usuario,
  quiero poder responder públicamente a los comentarios que el proveedor deje en mi reseña,
  para aclarar situaciones y mantener un diálogo visible dentro de la app.

  Scenario: Mostrar respuesta del proveedor en la reseña
    Given un proveedor ha respondido públicamente a la reseña de un usuario
    When el usuario visualiza su reseña en la app
    Then debe mostrarse la respuesta del establecimiento indentada debajo
    And con un fondo o estilo visual distinto para diferenciarla

  Scenario: Habilitar campo de texto para responder al proveedor
    Given el usuario quiere responder al comentario del proveedor
    When presiona el botón "Responder" debajo de la respuesta del establecimiento
    Then debe habilitarse un campo de texto para escribir su réplica

  Scenario: Publicar respuesta del usuario a la réplica del proveedor
    Given el usuario ha escrito una respuesta a la réplica del proveedor
    When envía la respuesta
    Then debe mostrarse indentada y anidada debajo del comentario original del proveedor
    And debe formarse un hilo
