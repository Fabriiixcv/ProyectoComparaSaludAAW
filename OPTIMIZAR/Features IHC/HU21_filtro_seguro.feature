Feature: Filtro por aceptación de seguro médico

  Como usuario
  Quiero aplicar filtros a los resultados de búsqueda por aceptación de mi seguro médico
  Para ver solo los proveedores o centros de salud que trabajen con mi plan de salud

  Scenario: Mostrar opción de filtro de seguro médico configurado
    Given que el usuario ha configurado su plan de salud en su perfil (por ejemplo, "Seguro XYZ")
    When accede al panel de filtros
    Then debe visualizar un interruptor con la leyenda "Solo proveedores que acepten Seguro XYZ"

  Scenario: Aplicar filtro de seguro médico activo
    Given que el usuario ha activado el filtro "Solo proveedores que acepten Seguro XYZ"
    When aplica los filtros
    Then la lista de resultados muestra exclusivamente los centros de salud que tienen convenio con "Seguro XYZ"

  Scenario: Deshabilitar filtro si no hay plan configurado
    Given que el usuario no ha configurado un plan de salud en su perfil
    When accede al panel de filtros
    Then el interruptor de "Acepta mi seguro" debe estar deshabilitado
    And mostrar un mensaje "Configura tu plan en tu perfil" debajo de la opción
