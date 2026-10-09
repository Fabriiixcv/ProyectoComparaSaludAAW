/* ComparativaService - HU49
 * GET /api/comparativa?idMedicamento={Id1,Id2,...}
 * Devuelve los médicos y servicios (atenciones) que incluyen el medicamento consultado.
 * Sin backend: usa las tablas locales "cs_tabla_medicamento" (la misma que usa MedicamentoService)
 * y "cs_tabla_atencion" (médicos y servicios, con datos de demostración).
 *
 * Un medicamento se compara por nombre comercial: el mismo producto puede estar registrado
 * por varias sedes con distinto Id y precio. Cada grupo agrupa esos registros.
 */
(function (g) {
  const API_URL = "/api/comparativa";
  const MK = "cs_tabla_medicamento";
  const AK = "cs_tabla_atencion";
  const CK = "cs_tabla_centro_medico";

  const CENTROS = { 1: "Clínica Médica Central", 2: "Laboratorio Médico Central", 3: "Centro Cardiológico" };

  const SEED_MED = [
    { Id: 9001, NombreComercial: "Paracetamol 500 mg", Descripcion: "Caja x 20 tabletas", Precio: 12.5, IdCentroMedico: 1 },
    { Id: 9002, NombreComercial: "Paracetamol 500 mg", Descripcion: "Caja x 100 tabletas", Precio: 9.9, IdCentroMedico: 2 },
    { Id: 9003, NombreComercial: "Paracetamol 500 mg", Descripcion: "Caja x 20 tabletas", Precio: 14.0, IdCentroMedico: 3 },
    { Id: 9004, NombreComercial: "Ibuprofeno 400 mg", Descripcion: "Caja x 10 tabletas", Precio: 8.5, IdCentroMedico: 1 },
    { Id: 9005, NombreComercial: "Ibuprofeno 400 mg", Descripcion: "Caja x 10 tabletas", Precio: 7.2, IdCentroMedico: 2 },
    { Id: 9006, NombreComercial: "Losartán 50 mg", Descripcion: "Caja x 30 tabletas", Precio: 18.0, IdCentroMedico: 3 },
    { Id: 9007, NombreComercial: "Losartán 50 mg", Descripcion: "Caja x 30 tabletas", Precio: 21.5, IdCentroMedico: 1 },
  ];

  const SEED_ATE = [
    { IdAtencion: 1, Tipo: "medico", Nombre: "Dr. Carlos García Mendoza", Detalle: "Cardiólogo", IdCentroMedico: 3, Costo: 150, Medicamentos: ["paracetamol 500 mg", "losartan 50 mg"] },
    { IdAtencion: 2, Tipo: "medico", Nombre: "Dra. Ana López Rodríguez", Detalle: "Medicina general", IdCentroMedico: 1, Costo: 80, Medicamentos: ["paracetamol 500 mg", "ibuprofeno 400 mg"] },
    { IdAtencion: 3, Tipo: "medico", Nombre: "Dr. Roberto Martínez Sánchez", Detalle: "Traumatólogo", IdCentroMedico: 1, Costo: 120, Medicamentos: ["ibuprofeno 400 mg"] },
    { IdAtencion: 4, Tipo: "servicio", Nombre: "Consulta con especialista", Detalle: "45 minutos", IdCentroMedico: 1, Costo: 120, Medicamentos: ["paracetamol 500 mg", "losartan 50 mg"] },
    { IdAtencion: 5, Tipo: "servicio", Nombre: "Chequeo cardiovascular", Detalle: "Evaluación completa", IdCentroMedico: 3, Costo: 180, Medicamentos: ["losartan 50 mg"] },
    { IdAtencion: 6, Tipo: "servicio", Nombre: "Atención de dolor y fiebre", Detalle: "Consulta + tratamiento", IdCentroMedico: 2, Costo: 45, Medicamentos: ["paracetamol 500 mg", "ibuprofeno 400 mg"] },
  ];

  function norm(s) {
    return String(s == null ? "" : s).normalize("NFD").replace(/[\u0300-\u036f]/g, "").toLowerCase().trim();
  }

  function leer(key) {
    try { const x = JSON.parse(localStorage.getItem(key)); if (Array.isArray(x)) return x; } catch (e) {}
    return [];
  }

  function medicamentos() {
    const t = leer(MK);
    SEED_MED.forEach((m) => { if (!t.some((r) => String(r.Id) === String(m.Id))) t.push(m); });
    try { localStorage.setItem(MK, JSON.stringify(t)); } catch (e) {}
    return t;
  }

  function atenciones() {
    const t = leer(AK);
    if (!t.length) { try { localStorage.setItem(AK, JSON.stringify(SEED_ATE)); } catch (e) {} return SEED_ATE.slice(); }
    return t;
  }

  function nombreCentro(id) {
    const reg = leer(CK).find((c) => String(c.IdCentroMedico) === String(id));
    if (reg && (reg.Nombre || reg.NombreComercial)) return reg.Nombre || reg.NombreComercial;
    return CENTROS[id] || "Centro #" + id;
  }

  // Lista de medicamentos agrupados por nombre, para el selector
  function listarMedicamentos() {
    const grupos = {};
    medicamentos().forEach((m) => {
      const k = norm(m.NombreComercial);
      const gr = grupos[k] || (grupos[k] = { Clave: k, Nombre: m.NombreComercial, Ids: [], Sedes: 0, PrecioMin: Infinity });
      gr.Ids.push(m.Id);
      gr.Sedes += 1;
      gr.PrecioMin = Math.min(gr.PrecioMin, Number(m.Precio));
    });
    return Object.values(grupos).sort((a, b) => a.Nombre.localeCompare(b.Nombre, "es"));
  }

  function normalizarFila(f) {
    const centro = f.IdCentroMedico;
    const costo = Number(f.CostoAtencion ?? f.Costo ?? 0);
    const precio = Number(f.PrecioMedicamento ?? f.Precio ?? 0);
    return {
      Tipo: f.Tipo === "servicio" ? "servicio" : "medico",
      Nombre: f.Nombre,
      Detalle: f.Detalle || "",
      IdCentroMedico: centro,
      Centro: f.Centro || nombreCentro(centro),
      CostoAtencion: costo,
      PrecioMedicamento: precio,
      CostoGlobal: Number(f.CostoGlobal ?? costo + precio),
    };
  }

  // Devuelve { ok, medicamento, data:[...] } o { ok:false, error }
  async function consultar(clave) {
    const grupo = listarMedicamentos().find((x) => x.Clave === clave);
    if (!grupo) return { ok: false, error: "Selecciona un medicamento para comparar." };

    // 1) Backend: GET /api/comparativa?idMedicamento=...
    try {
      const res = await fetch(`${API_URL}?idMedicamento=${encodeURIComponent(grupo.Ids.join(","))}`, {
        method: "GET",
        headers: { Accept: "application/json" },
      });
      const type = res.headers.get("content-type") || "";
      if (res.ok && type.includes("application/json")) {
        const json = await res.json();
        const arr = Array.isArray(json) ? json : json.data;
        if (Array.isArray(arr)) return { ok: true, medicamento: grupo, data: arr.map(normalizarFila) };
      }
    } catch (e) {
      /* sin backend: se usa la tabla local */
    }

    // 2) Respaldo local
    try {
      const meds = medicamentos().filter((m) => norm(m.NombreComercial) === clave);
      const masBarato = Math.min(...meds.map((m) => Number(m.Precio)));
      const data = atenciones()
        .filter((a) => (a.Medicamentos || []).some((n) => norm(n) === clave))
        .map((a) => {
          const propio = meds.find((m) => String(m.IdCentroMedico) === String(a.IdCentroMedico));
          return normalizarFila({
            Tipo: a.Tipo,
            Nombre: a.Nombre,
            Detalle: a.Detalle,
            IdCentroMedico: a.IdCentroMedico,
            CostoAtencion: a.Costo,
            PrecioMedicamento: propio ? propio.Precio : masBarato,
          });
        })
        .sort((a, b) => a.CostoGlobal - b.CostoGlobal);
      return { ok: true, medicamento: grupo, data };
    } catch (e) {
      return { ok: false, error: "No se pudo realizar la comparación. Inténtalo nuevamente." };
    }
  }

  g.ComparativaService = { listarMedicamentos, consultar };
})(window);
