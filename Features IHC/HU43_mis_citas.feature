Feature: Sección "Mis Citas" con Filtros
  Como usuario,
  Quiero ver una sección en mi perfil llamada "Mis Citas"
  Para gestionar y revisar todas mis citas, separadas por "Próximas", "Pasadas" y "Canceladas".

  Scenario: Visualizar citas próximas por defecto
    Given el usuario navega a la sección "Mis Citas"
    When la pantalla se carga
    Then debe ver una pestaña o filtro activo por defecto llamado "Próximas"
    And la lista muestra las citas futuras ordenadas por fecha más cercana

  Scenario: Visualizar historial de citas pasadas
    Given el usuario presiona la pestaña "Pasadas"
    When se muestra la lista
    Then debe ver un historial de todas las citas ya atendidas
    And cada cita incluye la fecha y el nombre del proveedor

  Scenario: Visualizar citas canceladas
    Given el usuario tiene una cita cancelada
    When selecciona la pestaña "Canceladas"
    Then debe poder ver el detalle de la cita cancelada
    And se muestra la fecha en que fue cancelada
