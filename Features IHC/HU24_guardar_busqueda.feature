Feature: Guardar búsquedas frecuentes

  Como usuario
  Quiero poder guardar búsquedas frecuentes con sus filtros
  Para repetirlas fácilmente con un solo clic sin tener que configurarlas de nuevo

  Scenario: Mostrar opción para guardar una búsqueda
    Given que el usuario ha realizado una búsqueda con filtros específicos (por ejemplo, "Dermatólogo" + "Precio < 100")
    When se encuentra en la pantalla de resultados
    Then debe visualizar un botón o ícono de "Guardar búsqueda"

  Scenario: Asignar nombre personalizado a la búsqueda guardada
    Given que el usuario presiona el botón "Guardar búsqueda"
    When el sistema solicita un nombre
    Then el usuario puede ingresar un nombre personalizado (por ejemplo, "Dermatólogo económico")
    And el sistema guarda la búsqueda con sus filtros asociados

  Scenario: Ejecutar una búsqueda guardada
    Given que el usuario accede a la sección "Búsquedas guardadas" en su perfil
    When selecciona una búsqueda previamente guardada
    Then la aplicación ejecuta automáticamente la búsqueda con los mismos filtros que fueron almacenados
