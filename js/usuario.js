/* UsuarioService - HU04
 * PUT /api/usuario  { IdUsuario, Nombre, Apellidos, Correo }
 * Respaldo sin backend: tabla local "cs_users" y sesión "cs_session" (mismas claves que auth.js).
 */
(function (g) {
  const API_URL = "/api/usuario";
  const UK = "cs_users";
  const SK = "cs_session";
  const FLASH_KEY = "cs_flash_usuario";
  const PK = "cs_perfil_usuario"; // perfil editado por id (no depende de cómo auth.js guarde los usuarios)
  const NAME_RE = /^[A-Za-zÁÉÍÓÚÜÑáéíóúüñ][A-Za-zÁÉÍÓÚÜÑáéíóúüñ' .-]*$/;
  const EMAIL_RE = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

  function getSession() {
    try { return JSON.parse(sessionStorage.getItem(SK)); } catch (e) { return null; }
  }

  function getUsers() {
    // Se lee siempre la tabla guardada, para ver los cambios más recientes
    try { const u = JSON.parse(localStorage.getItem(UK)); if (Array.isArray(u) && u.length) return u; } catch (e) {}
    if (g.Auth && typeof g.Auth.getUsers === "function") return g.Auth.getUsers();
    return [];
  }

  function getPerfiles() {
    try { const p = JSON.parse(localStorage.getItem(PK)); if (p && typeof p === "object") return p; } catch (e) {}
    return {};
  }

  function nombreCompleto(u) {
    return (u.nombre + " " + (u.apellidos || "")).trim();
  }

  // Usuarios antiguos guardaban el nombre completo en "nombre": se separa solo para mostrarlo
  function separar(u) {
    if (u.apellidos !== undefined && u.apellidos !== null) return { Nombre: u.nombre, Apellidos: u.apellidos };
    const partes = (u.nombre || "").trim().split(/\s+/);
    return { Nombre: partes.shift() || "", Apellidos: partes.join(" ") };
  }

  function requireSession() {
    const s = getSession();
    if (!s) { location.href = "./1_2_auth.html"; return null; }
    return s;
  }

  function obtenerActual() {
    const s = getSession();
    if (!s) return null;
    const u = getUsers().find((x) => x.id === s.id);
    const p = u ? separar(u) : separar({ nombre: s.nombre });
    const base = { IdUsuario: s.id, Nombre: p.Nombre, Apellidos: p.Apellidos, Correo: u ? u.email : s.email, Rol: u ? u.rol : s.rol };
    const ed = getPerfiles()[s.id];
    if (ed) { base.Nombre = ed.Nombre; base.Apellidos = ed.Apellidos; base.Correo = ed.Correo; }
    return base;
  }

  function validar(d) {
    const e = {};
    const nom = (d.Nombre || "").trim();
    const ape = (d.Apellidos || "").trim();
    const cor = (d.Correo || "").trim();
    if (!nom) e.Nombre = "El nombre es obligatorio.";
    else if (nom.length < 2 || nom.length > 50) e.Nombre = "El nombre debe tener entre 2 y 50 caracteres.";
    else if (!NAME_RE.test(nom)) e.Nombre = "El nombre solo puede contener letras y espacios.";

    if (!ape) e.Apellidos = "Los apellidos son obligatorios.";
    else if (ape.length < 2 || ape.length > 80) e.Apellidos = "Los apellidos deben tener entre 2 y 80 caracteres.";
    else if (!NAME_RE.test(ape)) e.Apellidos = "Los apellidos solo pueden contener letras y espacios.";

    if (!cor) e.Correo = "El correo es obligatorio.";
    else if (cor.length > 100 || !EMAIL_RE.test(cor)) e.Correo = "Ingresa un correo electrónico válido.";
    return e;
  }

  function correoEnOtraCuenta(correo, idPropio) {
    const c = correo.trim().toLowerCase();
    if (getUsers().some((u) => u.id !== idPropio && (u.email || "").toLowerCase() === c)) return true;
    const per = getPerfiles();
    return Object.keys(per).some((id) => String(id) !== String(idPropio) && (per[id].Correo || "").toLowerCase() === c);
  }

  function guardarLocal(id, d) {
    const nuevo = { Nombre: d.Nombre.trim(), Apellidos: d.Apellidos.trim(), Correo: d.Correo.trim() };

    // 1) Tabla Usuario
    const users = getUsers();
    const u = users.find((x) => x.id === id);
    if (u) {
      u.nombre = nuevo.Nombre;
      u.apellidos = nuevo.Apellidos;
      u.email = nuevo.Correo;
      localStorage.setItem(UK, JSON.stringify(users));
    }

    // 2) Perfil editado (se conserva aunque otra parte reescriba la tabla de usuarios)
    const per = getPerfiles();
    per[id] = nuevo;
    localStorage.setItem(PK, JSON.stringify(per));

    // 3) Sesión actual
    const s = getSession();
    if (s && s.id === id) {
      s.email = nuevo.Correo;
      s.nombre = (nuevo.Nombre + " " + nuevo.Apellidos).trim();
      if (s.rol === "proveedor") s.nombreCentro = s.nombre;
      sessionStorage.setItem(SK, JSON.stringify(s));
    }
    return true;
  }

  async function actualizar(d) {
    const s = getSession();
    if (!s) return { ok: false, status: 401 };

    const errores = validar(d);
    if (Object.keys(errores).length) return { ok: false, errores };

    const dupMsg = "Este correo ya está registrado en otra cuenta.";
    const payload = { IdUsuario: s.id, Nombre: d.Nombre.trim(), Apellidos: d.Apellidos.trim(), Correo: d.Correo.trim() };

    // 1) Backend: PUT /api/usuario (el servidor valida que el Correo no esté duplicado)
    try {
      const res = await fetch(API_URL, {
        method: "PUT",
        headers: { "Content-Type": "application/json", Accept: "application/json" },
        body: JSON.stringify(payload),
      });
      if (res.ok) { try { guardarLocal(s.id, d); } catch (e) {} return { ok: true }; }
      if (res.status === 401) return { ok: false, status: 401 };
      if (res.status === 409) return { ok: false, errores: { Correo: dupMsg } };
      if (res.status === 400 || res.status === 422) {
        let j = {};
        try { j = await res.json(); } catch (e) {}
        return { ok: false, errores: j.errores, error: j.error || "Datos inválidos." };
      }
    } catch (e) {
      /* sin backend: se actualiza la tabla local */
    }

    // 2) Respaldo local: validar duplicado en otras cuentas y actualizar la tabla Usuario
    if (correoEnOtraCuenta(d.Correo, s.id)) return { ok: false, errores: { Correo: dupMsg } };
    try {
      if (!guardarLocal(s.id, d)) return { ok: false, error: "No se encontró tu cuenta." };
    } catch (e) {
      return { ok: false, error: "No se pudo guardar la información." };
    }
    return { ok: true };
  }

  const Flash = {
    set(m) { try { sessionStorage.setItem(FLASH_KEY, m); } catch (e) {} },
    take() { try { const m = sessionStorage.getItem(FLASH_KEY); sessionStorage.removeItem(FLASH_KEY); return m; } catch (e) { return null; } },
  };

  // Muestra el nombre real del usuario en el menú superior de las páginas del paciente
  function pintarCabecera() {
    const s = getSession();
    if (!s) return;
    const u = obtenerActual();
    const nombre = u ? (u.Nombre + " " + u.Apellidos).trim() : s.nombre;
    document.querySelectorAll('img[alt="Juan Sánchez"]').forEach((img) => {
      img.alt = nombre;
      const span = img.parentElement.querySelector("span");
      if (span) span.textContent = nombre;
    });
    // Avatar con inicial (páginas sin foto)
    document.querySelectorAll('a[href="6_user_profile.html"].health-gradient').forEach((a) => {
      a.textContent = nombre.charAt(0).toUpperCase();
      a.title = nombre;
    });
  }

  g.UsuarioService = { requireSession, obtenerActual, validar, actualizar, nombreCompleto, Flash, pintarCabecera };
})(window);
