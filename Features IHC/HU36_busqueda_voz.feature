Feature: Búsqueda por Voz
  Como usuario,
  Quiero una función de "Búsqueda por voz"
  Para decir el servicio que necesito y facilitar la búsqueda si tengo limitaciones para escribir.

  Scenario: Activar la búsqueda por voz
    Given el usuario está en la barra de búsqueda
    When presiona el icono de micrófono
    Then la app solicita permiso para acceder al micrófono
    And comienza a escuchar al usuario

  Scenario: Transcribir y ejecutar búsqueda automáticamente
    Given el usuario concede el permiso para el micrófono
    When dice "pediatra en Miraflores"
    Then el sistema transcribe el audio en la barra de búsqueda
    And ejecuta la búsqueda automáticamente

  Scenario: Permitir corrección manual si la transcripción es incorrecta
    Given el sistema no entendió correctamente lo que el usuario dijo
    When se muestran resultados incorrectos
    Then el usuario puede editar manualmente el texto en la barra de búsqueda
