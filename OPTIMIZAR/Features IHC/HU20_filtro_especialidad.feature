Feature: Filtro por especialidad médica

  Como usuario
  Quiero aplicar filtros a los resultados de búsqueda por especialidad médica
  Para encontrar proveedores o clínicas que atiendan la especialidad que necesito

  Scenario: Mostrar lista de especialidades disponibles
    Given que el usuario busca "Consulta médica" de manera general
    When accede al panel de filtros
    Then la opción "Especialidad" muestra una lista desplegable con especialidades disponibles como:
      | Especialidad  |
      | Dermatología  |
      | Pediatría     |
      | Cardiología   |
      | Ginecología   |

  Scenario: Aplicar filtro por especialidad
    Given que el usuario selecciona "Pediatría" en el filtro de especialidad
    When aplica los filtros
    Then los resultados muestran únicamente clínicas o médicos que ofrezcan consultas pediátricas

  Scenario: Ocultar filtro cuando no aplica
    Given que el usuario busca en la categoría "Análisis Clínicos"
    When accede al panel de filtros
    Then el filtro de "Especialidad" debe estar oculto o deshabilitado
    And no debe permitir selección alguna
