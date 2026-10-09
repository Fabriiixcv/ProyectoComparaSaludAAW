Feature: Página de detalle - galería de fotos

  Como usuario
  Al seleccionar un proveedor
  Quiero ver una galería de fotos del establecimiento
  Para tener una idea visual del lugar antes de visitarlo o agendar una cita

  Scenario: Mostrar carrusel de imágenes del proveedor
    Given que el proveedor ha cargado fotos de sus instalaciones
    When el usuario abre la página de detalle del proveedor
    Then se muestra un carrusel horizontal de imágenes en la parte superior de la página

  Scenario: Visualizar imagen ampliada desde el carrusel
    Given que el usuario está viendo el carrusel de fotos
    When presiona una de las imágenes
    Then se abre una vista ampliada de la imagen seleccionada
    And el usuario puede deslizarse lateralmente para ver el resto de la galería

  Scenario: Mostrar imagen genérica cuando no hay fotos disponibles
    Given que el proveedor no ha cargado fotos en su perfil
    When se carga la página de detalle
    Then el espacio del carrusel muestra una imagen genérica por defecto, como un ícono de edificio o clínica
