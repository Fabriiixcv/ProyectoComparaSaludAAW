Feature: Marcar proveedores como favoritos

  Como usuario
  Quiero poder marcar proveedores como "Favoritos"
  Para acceder rápidamente a ellos desde mi perfil cuando los necesite

  Scenario: Marcar proveedor como favorito
    Given que el usuario está en la página de detalle de un proveedor
    When presiona el ícono de "corazón" en la esquina superior derecha
    Then el ícono cambia de vacío a sólido
    And el sistema guarda el proveedor en la lista de favoritos del usuario

  Scenario: Visualizar proveedores favoritos en el perfil
    Given que el usuario ha marcado uno o más proveedores como favoritos
    When accede a la sección "Mis Favoritos" en su perfil
    Then los proveedores guardados deben aparecer en la lista con su nombre, especialidad y calificación

  Scenario: Quitar proveedor de la lista de favoritos
    Given que el usuario ve un proveedor con el ícono de "corazón" sólido
    When presiona nuevamente el ícono
    Then el sistema elimina al proveedor de la lista "Mis Favoritos"
    And este desaparece inmediatamente de dicha lista
