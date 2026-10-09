Feature: Sello de Verificación de Reseñas Auténticas
  Como usuario,
  quiero que el sistema muestre un "sello de verificación" en las reseñas de pacientes que confirmaron haber asistido a la cita a través de la app,
  para confiar más en la autenticidad de las opiniones.

  Scenario: Mostrar sello de "Cita verificada" en reseñas auténticas
    Given un usuario agendó y asistió a una cita a través de ComparaSalud
    When escribe una reseña y se publica
    Then debe mostrarse un sello o badge junto a su nombre que diga "Cita verificada" o un icono de check

  Scenario: No mostrar sello en reseñas de citas no agendadas por la app
    Given un usuario escribe una reseña sobre un proveedor sin haber agendado la cita mediante la app
    When la reseña se publica
    Then NO debe mostrarse el sello de "Cita verificada"

  Scenario: Mostrar tooltip explicativo al pasar el cursor sobre el sello
    Given un usuario ve una reseña con el sello de "Cita verificada"
    When pasa el dedo o cursor sobre el sello
    Then debe mostrarse un tooltip que indique "Este paciente agendó y asistió a una cita a través de ComparaSalud"
