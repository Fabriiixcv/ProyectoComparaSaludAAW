/* HU13 - Buscar centros médicos por distrito o nombre
 * GET /api/centro-medico?q={texto}
 * Cargar DESPUÉS de centro_medico.js. Añade CentroMedicoService.buscar(q) y .distritos().
 * Sin backend: consulta parcial (sin tildes ni mayúsculas) sobre NombreComercial y Distrito
 * en la tabla local "cs_tabla_centro_medico".
 */
(function (g) {
  const S = g.CentroMedicoService || (g.CentroMedicoService = {});
  const API_URL = "/api/centro-medico";
  const TABLE_KEY = "cs_tabla_centro_medico";

  // Distrito de las sedes base (ids 1-3) y sedes adicionales de demostración
  const DISTRITO_BASE = { 1: "Cercado de Lima", 2: "Lince", 3: "San Borja" };
  const EXTRA = [
    { IdCentroMedico: 4, Nombre: "Clínica Miraflores Salud", Direccion: "Av. Larco 812, Miraflores", Telefono: "(01) 445-2100", Distrito: "Miraflores", Latitud: -12.1219, Longitud: -77.0297 },
    { IdCentroMedico: 5, Nombre: "Centro Médico San Isidro", Direccion: "Calle Los Pinos 340, San Isidro", Telefono: "(01) 421-7788", Distrito: "San Isidro", Latitud: -12.0977, Longitud: -77.0365 },
    { IdCentroMedico: 6, Nombre: "Policlínico La Molina", Direccion: "Av. La Molina 1560, La Molina", Telefono: "(01) 349-0045", Distrito: "La Molina", Latitud: -12.0856, Longitud: -76.9419 },
    { IdCentroMedico: 7, Nombre: "Clínica Surco Vital", Direccion: "Av. Caminos del Inca 2200, Santiago de Surco", Telefono: "987 321 654", Distrito: "Santiago de Surco", Latitud: -12.1453, Longitud: -76.9954 },
    { IdCentroMedico: 8, Nombre: "Laboratorio Miraflores Diagnóstica", Direccion: "Av. Benavides 1234, Miraflores", Telefono: "(01) 242-5566", Distrito: "Miraflores", Latitud: -12.1275, Longitud: -77.0198 },
  ];

  function norm(s) {
    return String(s == null ? "" : s).normalize("NFD").replace(/[\u0300-\u036f]/g, "").toLowerCase().trim();
  }

  function tabla() {
    let t = [];
    try { const x = JSON.parse(localStorage.getItem(TABLE_KEY)); if (Array.isArray(x)) t = x; } catch (e) {}
    EXTRA.forEach((c) => { if (!t.some((r) => String(r.IdCentroMedico) === String(c.IdCentroMedico))) t.push(c); });
    t.forEach((r) => { if (!r.Distrito && DISTRITO_BASE[r.IdCentroMedico]) r.Distrito = DISTRITO_BASE[r.IdCentroMedico]; });
    try { localStorage.setItem(TABLE_KEY, JSON.stringify(t)); } catch (e) {}
    return t;
  }

  function normalizar(c) {
    return {
      IdCentroMedico: c.IdCentroMedico ?? c.id,
      NombreComercial: c.NombreComercial ?? c.Nombre ?? c.nombre ?? "Centro médico",
      Distrito: c.Distrito ?? c.distrito ?? "",
      Direccion: c.Direccion ?? c.direccion ?? "",
      Telefono: c.Telefono ?? c.telefono ?? "",
    };
  }

  function coincide(c, q) {
    return norm(c.NombreComercial).includes(q) || norm(c.Distrito).includes(q);
  }

  S.distritos = function () {
    return Array.from(new Set(tabla().map((c) => c.Distrito).filter(Boolean))).sort((a, b) => a.localeCompare(b, "es"));
  };

  // Devuelve { ok, data:[...] } o { ok:false, error }
  S.buscar = async function (texto) {
    const q = norm(texto);
    let lista = null;

    // 1) Backend: GET /api/centro-medico?q=...
    try {
      const res = await fetch(`${API_URL}?q=${encodeURIComponent((texto || "").trim())}`, {
        method: "GET",
        headers: { Accept: "application/json" },
      });
      const type = res.headers.get("content-type") || "";
      if (res.ok && type.includes("application/json")) {
        const json = await res.json();
        if (Array.isArray(json)) lista = json.map(normalizar);
      }
    } catch (e) {
      /* sin backend: se usa la tabla local */
    }

    // 2) Respaldo local
    if (!lista) {
      try {
        lista = tabla().map(normalizar).filter((c) => !q || coincide(c, q));
      } catch (e) {
        return { ok: false, error: "No se pudo realizar la búsqueda. Inténtalo nuevamente." };
      }
    }
    return { ok: true, data: lista };
  };
})(window);
