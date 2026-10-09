Feature: Búsqueda por categorías predefinidas

  Como usuario
  Quiero buscar servicios por categorías predefinidas (Consulta Médica, Análisis Clínicos, etc.)
  Para explorar opciones de manera organizada

  Scenario: Mostrar iconos y etiquetas de categorías en la pantalla de inicio
    Given que el usuario está en la pantalla de inicio
    When se muestran los iconos de categorías (por ejemplo: "Consulta", "Análisis", "Imágenes")
    Then cada icono debe tener una etiqueta clara y ser visualmente distintivo

  Scenario: Filtrar resultados por categoría seleccionada
    Given que el usuario presiona una categoría como "Análisis Clínicos"
    When la pantalla de resultados se cargue
    Then debe mostrar exclusivamente laboratorios y centros que ofrezcan ese tipo de servicio

  Scenario: Sugerir subcategorías cuando la categoría es amplia
    Given que el usuario selecciona una categoría muy amplia
    When se muestran los resultados
    Then la pantalla sugiere automáticamente subcategorías o filtros comunes (por ejemplo: "¿Buscabas? Hemograma, Glicemia, Perfil Lipídico")
