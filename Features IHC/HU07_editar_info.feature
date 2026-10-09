Feature: Edición de información personal

  Como usuario
  Quiero poder editar toda mi información personal (nombre, teléfono, foto de perfil)
  Para mantener mis datos actualizados en cualquier momento

  Scenario: Activar modo edición del perfil
    Given que el usuario está en la pantalla de su perfil
    When presiona el botón "Editar Perfil"
    Then los campos editables como "Nombre" y "Teléfono" deben mostrarse en modo edición (dentro de cuadros de texto)

  Scenario: Editar la foto de perfil
    Given que el usuario está editando su foto de perfil
    When presiona el ícono de la cámara
    Then se despliega un menú con las opciones "Tomar foto" o "Elegir de la galería"

  Scenario: Guardar los cambios del perfil
    Given que el usuario ha realizado cambios válidos en su información
    When presiona el botón "Guardar"
    Then el sistema actualiza los datos del perfil
    And muestra el mensaje de confirmación "Per
