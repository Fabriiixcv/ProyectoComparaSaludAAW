/**
 * Servicio de autenticación y roles (Paciente, Proveedor, Administrador).
 * Simula usuarios y sesión en el navegador (localStorage / sessionStorage).
 * Para producción debe reemplazarse por llamadas al backend.
 */
(function (global) {
  const USERS_KEY = "cs_users";
  const SESSION_KEY = "cs_session";

  const ROLES = {
    paciente: { label: "Paciente", home: "./2_tutorial.html" }, // el tutorial lleva a 3_user_dashboard.html
    proveedor: { label: "Proveedor", home: "./3_provider_home.html" },
    administrador: { label: "Administrador", home: "./3_admin_home.html" },
  };

  const DEMO_USERS = [
    { id: 1, nombre: "Paciente Demo", email: "paciente@comparasalud.com", password: "Demo1234", rol: "paciente" },
    { id: 2, nombre: "Clínica Demo", email: "proveedor@comparasalud.com", password: "Demo1234", rol: "proveedor" },
    { id: 3, nombre: "Admin Demo", email: "admin@comparasalud.com", password: "Demo1234", rol: "administrador" },
  ];

  function getUsers() {
    try {
      const stored = JSON.parse(localStorage.getItem(USERS_KEY));
      if (Array.isArray(stored)) return stored;
    } catch (e) {}
    localStorage.setItem(USERS_KEY, JSON.stringify(DEMO_USERS));
    return DEMO_USERS.slice();
  }

  function saveUsers(users) {
    localStorage.setItem(USERS_KEY, JSON.stringify(users));
  }

  function findByEmail(email) {
    const e = (email || "").trim().toLowerCase();
    return getUsers().find((u) => u.email.toLowerCase() === e) || null;
  }

  // Devuelve { ok, user } o { ok:false, error }
  function register({ nombre, email, password, rol }) {
    if (!ROLES[rol]) return { ok: false, error: "rol" };
    if (findByEmail(email)) return { ok: false, error: "email-existente" };
    const users = getUsers();
    const nextId = users.reduce((m, u) => Math.max(m, u.id), 0) + 1;
    const user = { id: nextId, nombre: nombre.trim(), email: email.trim(), password, rol };
    users.push(user);
    saveUsers(users);
    return { ok: true, user };
  }

  function startSession(user) {
    const session = {
      id: user.id,
      email: user.email,
      nombre: user.nombre,
      rol: user.rol,
    };
    // Para proveedores, el id del usuario es el id del centro médico (HU20)
    if (user.rol === "proveedor") {
      session.idCentroMedico = user.id;
      session.nombreCentro = user.nombre;
    }
    sessionStorage.setItem(SESSION_KEY, JSON.stringify(session));
    return session;
  }

  function login(email, password) {
    const user = findByEmail(email);
    if (!user || user.password !== password) return { ok: false };
    return { ok: true, user, session: startSession(user), home: ROLES[user.rol].home };
  }

  function getSession() {
    try {
      return JSON.parse(sessionStorage.getItem(SESSION_KEY));
    } catch (e) {
      return null;
    }
  }

  // Protege una página: exige sesión y rol. Si no cumple, redirige.
  function requireRole(rol) {
    const s = getSession();
    if (!s) {
      window.location.href = "./1_2_auth.html";
      return null;
    }
    if (s.rol !== rol) {
      window.location.href = ROLES[s.rol] ? ROLES[s.rol].home : "./1_2_auth.html";
      return null;
    }
    return s;
  }

  function logout() {
    sessionStorage.removeItem(SESSION_KEY);
    window.location.href = "./1_2_auth.html";
  }

  global.Auth = { ROLES, getUsers, register, login, getSession, requireRole, logout };
})(window);
