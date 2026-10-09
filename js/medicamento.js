/**
 * Servicio de Medicamentos (HU20 - EP03)
 * Simula la tabla Medicamento y el endpoint POST /api/medicamento.
 * Si existe un backend real en /api/medicamento se usa; si no, persiste en localStorage.
 *
 * Tabla Medicamento: { Id, NombreComercial, Descripcion, Precio, IdCentroMedico }
 */
(function (global) {
  const SESSION_KEY = "cs_session";
  const TABLE_KEY = "cs_tabla_medicamento";
  const FLASH_KEY = "cs_flash_message";

  const Session = {
    get() {
      try {
        return JSON.parse(sessionStorage.getItem(SESSION_KEY));
      } catch (e) {
        return null;
      }
    },
    // Exige un usuario autenticado con rol Proveedor (centro médico)
    require() {
      const s = Session.get();
      if (!s) {
        window.location.href = "./1_2_auth.html";
        return null;
      }
      if (s.rol !== "proveedor" || !s.idCentroMedico) {
        window.location.href =
          s.rol === "administrador" ? "./3_admin_home.html" : "./3_user_dashboard.html";
        return null;
      }
      return s;
    },
  };

  function readTable() {
    try {
      return JSON.parse(localStorage.getItem(TABLE_KEY)) || [];
    } catch (e) {
      return [];
    }
  }

  function writeTable(rows) {
    try {
      localStorage.setItem(TABLE_KEY, JSON.stringify(rows));
      return true;
    } catch (e) {
      return false;
    }
  }

  // Guarda siempre el medicamento en la tabla local (el catálogo lee de aquí)
  function guardarLocal(med) {
    const rows = readTable();
    if (!rows.some((m) => m.Id === med.Id)) rows.push(med);
    return writeTable(rows);
  }

  function validar(data) {
    const errores = {};
    const nombre = (data.NombreComercial || "").trim();
    const descripcion = (data.Descripcion || "").trim();
    const precio = Number(data.Precio);

    if (!nombre) errores.NombreComercial = "El nombre comercial es obligatorio.";
    else if (nombre.length > 100) errores.NombreComercial = "Máximo 100 caracteres.";

    if (!descripcion) errores.Descripcion = "La descripción es obligatoria.";
    else if (descripcion.length > 500) errores.Descripcion = "Máximo 500 caracteres.";

    if (data.Precio === "" || data.Precio === null || isNaN(precio))
      errores.Precio = "Ingresa un precio válido.";
    else if (precio <= 0) errores.Precio = "El precio debe ser mayor a 0.";

    return errores;
  }

  // POST /api/medicamento
  async function crear(data) {
    const session = Session.get();
    if (!session || session.rol !== "proveedor" || !session.idCentroMedico) {
      return { ok: false, status: 401, error: "Sesión no válida." };
    }

    const errores = validar(data);
    if (Object.keys(errores).length) {
      return { ok: false, status: 400, errores };
    }

    const payload = {
      NombreComercial: data.NombreComercial.trim(),
      Descripcion: data.Descripcion.trim(),
      Precio: Math.round(Number(data.Precio) * 100) / 100,
      IdCentroMedico: session.idCentroMedico,
    };

    // 1) Intento contra backend real (si existe y devuelve JSON válido)
    let creado = null;
    try {
      const res = await fetch("/api/medicamento", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(payload),
      });
      if (res.status === 400 || res.status === 401 || res.status === 403) {
        return { ok: false, status: res.status, error: "No se pudo registrar el medicamento." };
      }
      const type = res.headers.get("content-type") || "";
      if (res.ok && type.includes("application/json")) {
        creado = await res.json().catch(() => null);
      }
    } catch (e) {
      /* sin backend: continúa con el simulado */
    }

    // 2) Persistencia local: el catálogo siempre lee de la tabla Medicamento local
    const nuevo = {
      ...payload,
      Id: creado && creado.Id != null ? creado.Id : Date.now(),
    };
    if (!guardarLocal(nuevo)) {
      return { ok: false, status: 500, error: "No se pudo guardar el medicamento en el navegador." };
    }
    return { ok: true, status: 201, medicamento: nuevo };
  }

  function listarPorCentro(idCentroMedico) {
    return readTable()
      .filter((m) => String(m.IdCentroMedico) === String(idCentroMedico))
      .sort((a, b) => b.Id - a.Id);
  }

  const Flash = {
    set(msg) {
      sessionStorage.setItem(FLASH_KEY, msg);
    },
    take() {
      const m = sessionStorage.getItem(FLASH_KEY);
      sessionStorage.removeItem(FLASH_KEY);
      return m;
    },
  };

  global.MedicamentoService = { Session, crear, listarPorCentro, validar, Flash };
})(window);
