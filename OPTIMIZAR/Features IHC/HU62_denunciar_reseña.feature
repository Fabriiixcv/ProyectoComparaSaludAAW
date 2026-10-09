Feature: Denuncia de Reseñas Inapropiadas
  Como usuario,
  quiero poder denunciar una reseña que considere falsa o inapropiada,
  para ayudar a moderar la comunidad y mantener la calidad de las opiniones.

  Scenario: Mostrar opción para denunciar reseña
    Given un usuario está leyendo una reseña que considera ofensiva o falsa
    When presiona el menú de opciones (tres puntos) en la reseña
    Then debe visualizar la opción "Denunciar reseña"

  Scenario: Seleccionar motivo de la denuncia
    Given el usuario selecciona "Denunciar reseña"
    When se abre la pantalla de denuncia
    Then debe mostrarse una lista de motivos predefinidos (por ejemplo: "Contenido ofensivo", "Información falsa", "Spam") para seleccionar

  Scenario: Confirmación de denuncia enviada
    Given el usuario envía una denuncia
    When el sistema la recibe
    Then debe mostrar un mensaje de confirmación "Gracias por tu reporte. Lo revisaremos pronto"
    And debe notificar al equipo de moderación de la pl
