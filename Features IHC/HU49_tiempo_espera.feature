Feature: Visualización de Tiempo de Espera Estimado
  Como usuario,
  Quiero ver el "tiempo estimado de espera" actualizado del proveedor en el día de la cita
  Para planificar mejor mi llegada al establecimiento.

  Scenario: Mostrar tiempo de espera estimado en tiempo real
    Given es el día de la cita
    When el usuario abre los detalles de la cita en la app
    Then debe ver una sección que diga "Tiempo de espera estimado: X minutos"
    And el valor se basa en datos en tiempo real del flujo del establecimiento

  Scenario: Manejo cuando no hay datos de tiempo de espera
    Given el establecimiento no proporciona datos de tiempo de espera en tiempo real
    When el usuario consulta la información
    Then se muestra el mensaje "Tiempo de espera no disponible"

  Scenario: Indicar demora significativa
    Given el tiempo de espera estimado supera los 30 minutos
    When el usuario lo visualiza
    Then el valor se muestra en color naranja o rojo para indicar demora significativa
