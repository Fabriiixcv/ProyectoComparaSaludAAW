/* CentroMedicoService - HU11
 * GET /api/centro-medico?id={IdCentroMedico}
 * Si el backend no responde (entorno estático), usa la tabla local "cs_tabla_centro_medico",
 * igual que MedicamentoService con "cs_tabla_medicamento".
 */
(function (g) {
  const API_URL = "/api/centro-medico";
  const TABLE_KEY = "cs_tabla_centro_medico";

  const SEED = [
    { IdCentroMedico: 1, Nombre: "Clínica Médica Central", Direccion: "Av. Principal 123, Lima", Telefono: "(01) 234-5678", Latitud: -12.1211, Longitud: -77.0297 },
    { IdCentroMedico: 2, Nombre: "Laboratorio Médico Central", Direccion: "Av. Arequipa 1450, Lima", Telefono: "(01) 500-1200", Latitud: -12.0890, Longitud: -77.0365 },
    { IdCentroMedico: 3, Nombre: "Centro Cardiológico", Direccion: "Av. Javier Prado Este 2100, San Borja", Telefono: "987 654 321", Latitud: -12.0905, Longitud: -77.0035 },
  ];

  function tablaLocal() {
    let t = [];
    try { const x = JSON.parse(localStorage.getItem(TABLE_KEY)); if (Array.isArray(x)) t = x; } catch (e) {}
    SEED.forEach((c) => { if (!t.some((r) => String(r.IdCentroMedico) === String(c.IdCentroMedico))) t.push(c); });
    try { localStorage.setItem(TABLE_KEY, JSON.stringify(t)); } catch (e) {}
    return t;
  }

  function normalizar(c) {
    if (!c) return null;
    const lat = Number(c.Latitud ?? c.latitud);
    const lng = Number(c.Longitud ?? c.longitud);
    if (!isFinite(lat) || !isFinite(lng) || lat < -90 || lat > 90 || lng < -180 || lng > 180) return null;
    return {
      IdCentroMedico: c.IdCentroMedico ?? c.id,
      Nombre: c.Nombre ?? c.nombre ?? "Centro médico",
      Direccion: c.Direccion ?? c.direccion ?? "",
      Telefono: c.Telefono ?? c.telefono ?? "",
      Latitud: lat,
      Longitud: lng,
    };
  }

  async function obtenerPorId(id) {
    let registro = null;

    // 1) Backend: GET /api/centro-medico?id=ID
    try {
      const res = await fetch(`${API_URL}?id=${encodeURIComponent(id)}`, {
        method: "GET",
        headers: { Accept: "application/json" },
      });
      if (res.ok) {
        const json = await res.json();
        registro = Array.isArray(json) ? json.find((c) => String(c.IdCentroMedico ?? c.id) === String(id)) || json[0] : json;
      }
    } catch (e) {
      /* sin backend: se usa la tabla local */
    }

    // 2) Respaldo local
    if (!registro) {
      registro = tablaLocal().find((c) => String(c.IdCentroMedico) === String(id));
    }

    if (!registro) return { ok: false, error: "No se encontró el centro médico." };
    const data = normalizar(registro);
    if (!data) return { ok: false, error: "El centro médico no tiene una ubicación válida registrada." };
    return { ok: true, data };
  }

  // ---------- HU15: editar dirección y teléfono ----------
  function validar(d) {
    const e = {};
    const dir = (d.Direccion || "").trim();
    if (!dir) e.Direccion = "La dirección es obligatoria.";
    else if (dir.length < 5) e.Direccion = "La dirección debe tener al menos 5 caracteres.";
    else if (dir.length > 200) e.Direccion = "La dirección no puede superar los 200 caracteres.";

    const tel = (d.Telefono || "").trim();
    if (!tel) e.Telefono = "El teléfono es obligatorio.";
    else if (!/^[\d\s()+\-]+$/.test(tel)) e.Telefono = "El teléfono solo puede contener números, espacios, guiones y paréntesis.";
    else {
      let n = tel.replace(/\D/g, "");
      if (tel.startsWith("+51")) n = n.slice(2);
      const celular = /^9\d{8}$/.test(n);
      const fijo = /^0?\d{1,2}\d{6,7}$/.test(n) && n.length >= 7 && n.length <= 10;
      if (!celular && !fijo) e.Telefono = "Formato inválido. Ej: 987 654 321 o (01) 234-5678.";
    }
    return e;
  }

  async function obtenerPerfil(id, nombreSesion) {
    const loc = tablaLocal().find((c) => String(c.IdCentroMedico) === String(id));
    return {
      ok: true,
      data: {
        IdCentroMedico: id,
        Nombre: nombreSesion || (loc && loc.Nombre) || "Mi establecimiento",
        Direccion: (loc && loc.Direccion) || "",
        Telefono: (loc && loc.Telefono) || "",
      },
    };
  }

  async function actualizar(id, d, nombreSesion) {
    const errores = validar(d);
    if (Object.keys(errores).length) return { ok: false, errores };
    const payload = { IdCentroMedico: id, Direccion: d.Direccion.trim(), Telefono: d.Telefono.trim() };

    // 1) Backend: PUT /api/centro-medico
    try {
      const res = await fetch(API_URL, {
        method: "PUT",
        headers: { "Content-Type": "application/json", Accept: "application/json" },
        body: JSON.stringify(payload),
      });
      if (res.ok) return { ok: true };
      if (res.status === 401) return { ok: false, status: 401 };
      if (res.status === 400 || res.status === 422) {
        let j = {};
        try { j = await res.json(); } catch (e) {}
        return { ok: false, errores: j.errores, error: j.error || "Datos inválidos." };
      }
    } catch (e) {
      /* sin backend: se actualiza la tabla local */
    }

    // 2) Respaldo local: actualiza (o crea) el registro en CentroMedico
    const tabla = tablaLocal();
    let reg = tabla.find((c) => String(c.IdCentroMedico) === String(id));
    if (!reg) {
      reg = { IdCentroMedico: id, Nombre: nombreSesion || "Mi establecimiento" };
      tabla.push(reg);
    }
    reg.Direccion = payload.Direccion;
    reg.Telefono = payload.Telefono;
    try { localStorage.setItem(TABLE_KEY, JSON.stringify(tabla)); }
    catch (e) { return { ok: false, error: "No se pudo guardar la información." }; }
    return { ok: true };
  }

  const FLASH_KEY = "cs_flash_centro";
  const Flash = {
    set(m) { try { sessionStorage.setItem(FLASH_KEY, m); } catch (e) {} },
    take() { try { const m = sessionStorage.getItem(FLASH_KEY); sessionStorage.removeItem(FLASH_KEY); return m; } catch (e) { return null; } },
  };

  g.CentroMedicoService = { obtenerPorId, obtenerPerfil, validar, actualizar, Flash };
})(window);
