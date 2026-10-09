Feature: Visualización de Perfil del Reseñador
  Como usuario,
  quiero poder ver el perfil de quien dejó una reseña (solo nombre y foto),
  para evaluar la credibilidad de las opiniones sin comprometer la privacidad del reseñador.

  Scenario: Mostrar nombre y foto del reseñador en la cabecera de la reseña
    Given el usuario está leyendo una reseña en la lista de opiniones
    When visualiza la cabecera de la reseña
    Then debe mostrarse el nombre de pila del reseñador (por ejemplo, "Ana C.")
    And debe mostrarse su foto de perfil junto al nombre

  Scenario: Mostrar avatar genérico cuando no hay foto de perfil
    Given el reseñador no ha configurado una foto de perfil
    When se muestra su opinión en la lista de reseñas
    Then debe visualizarse un avatar o ícono genérico por defecto (por ejemplo, una silueta de persona)

  Scenario: Proteger la privacidad del reseñador al intentar acceder a su perfil
    Given el usuario hace clic en el nombre o avatar del reseñador
    When intenta acceder a su perfil completo
    Then el sistema debe mostrar un mensaje que indique "La privacidad de los usuarios es importante. Solo puedes ver la información pú
