/* Directorio de ComparaSalud: 10 servicios, 10 médicos y 10 clínicas.
 * Lo usan 4_search_results.html (listado) y 4_detalle.html (información de cada tarjeta). */
(function (g) {
  const DATA = (function () {
        /* [nombre, sub, categoría, precio, rating, reseñas, distrito, km, disponible, ícono, etiquetas, descripción] */
        const mk = (a, ic, img) => a.map((x, i) => {
          const o = { id: i + 1, nombre: x[0], sub: x[1], cat: x[2], precio: x[3], rating: x[4], rev: x[5], distrito: x[6], dist: x[7], disp: !!x[8], icon: x[9] || ic, tags: x[10].split("|"), desc: x[11] };
          if (img) o.img = "doctor" + ((i % 4) + 1) + ".png";
          return o;
        });
        return {
          servicios: mk([
            ["Consulta Médica General","Clínica San Juan","Consultas",80,4.8,124,"Miraflores",1.2,1,"","30 minutos|Receta incluida","Evaluación inicial con médico general. Incluye receta y orientación."],
            ["Chequeo Cardiovascular","Centro Cardiológico","Chequeos",180,4.7,67,"San Borja",4.0,1,"fa-heartbeat","ECG|Informe digital","Evaluación cardíaca completa con electrocardiograma."],
            ["Análisis de Sangre Completo","Laboratorio Médico Central","Laboratorio",65,4.6,89,"Lince",0.8,1,"fa-microscope","Resultados en 24h","Hemograma, glucosa, colesterol y triglicéridos."],
            ["Ecografía Abdominal","Clínica Médica Central","Imágenes",180,4.5,128,"San Isidro",5.2,0,"fa-x-ray","45 minutos|Con informe","Evaluación completa de órganos abdominales."],
            ["Limpieza Dental","Clínica Surco Vital","Odontología",60,4.8,156,"Santiago de Surco",6.4,1,"fa-teeth","Sin dolor|Control incluido","Profilaxis y control de placa con instrumental esterilizado."],
            ["Examen Visual","Clínica San Juan","Oftalmología",50,4.4,73,"Miraflores",1.2,0,"fa-eye","Lentes opcionales","Medición de agudeza visual y revisión de salud ocular."],
            ["Vacunación Adulto","Policlínico La Molina","Consultas",35,4.6,98,"La Molina",8.3,1,"fa-syringe","Carné incluido","Aplicación de vacunas con registro en carné."],
            ["Radiografía de Tórax","Clínica Miraflores Salud","Imágenes",45,4.5,112,"Miraflores",1.6,1,"fa-x-ray","Resultado el mismo día","Imagen diagnóstica con informe médico."],
            ["Control Prenatal","Clínica Surco Vital","Chequeos",140,4.9,201,"Santiago de Surco",6.4,0,"fa-baby","Ecografía incluida","Seguimiento del embarazo con especialista."],
            ["Perfil Lipídico","Laboratorio Miraflores Diagnóstica","Laboratorio",55,4.3,64,"Lince",1.1,1,"fa-flask","Ayuno 12h|Resultados en 24h","Colesterol total, HDL, LDL y triglicéridos."]
          ], "fa-stethoscope"),
          medicos: mk([
            ["Dr. Carlos García Mendoza","Cardiólogo • 15 años de experiencia","Cardiología",150,4.8,124,"Miraflores",2.5,1,"","ECG|Ecocardiograma|Prueba de esfuerzo","Especialista en cardiología intervencionista y enfermedades cardiovasculares."],
            ["Dra. Ana López Rodríguez","Dermatóloga • 12 años de experiencia","Dermatología",180,4.9,89,"San Isidro",5.2,0,"","Acné|Dermatoscopía","Experta en dermatología clínica y estética."],
            ["Dr. Roberto Martínez Sánchez","Neurólogo • 20 años de experiencia","Neurología",220,4.7,156,"La Molina",8.1,1,"","EEG|Migrañas","Diagnóstico y tratamiento de migrañas, epilepsia y trastornos del movimiento."],
            ["Dra. Laura Mendoza","Ginecóloga • 10 años de experiencia","Ginecología",130,4.7,245,"Santiago de Surco",6.4,1,"","Control prenatal|Papanicolau","Control prenatal, salud preventiva y atención ginecológica integral."],
            ["Dr. Roberto Silva","Traumatólogo • 12 años de experiencia","Traumatología",160,4.8,287,"San Borja",4.0,0,"","Rodilla|Columna","Lesiones deportivas, fracturas y rehabilitación."],
            ["Dra. María González","Pediatra • 15 años de experiencia","Pediatría",110,4.9,312,"Miraflores",1.8,1,"","Vacunación|Control niño sano","Control de crecimiento y atención de niños desde recién nacidos."],
            ["Dr. Luis Paredes","Médico general • 8 años de experiencia","Medicina General",70,4.5,178,"Lince",0.9,1,"","Chequeo|Receta","Consulta general y orientación preventiva."],
            ["Dra. Patricia Núñez","Oftalmóloga • 14 años de experiencia","Oftalmología",140,4.6,95,"San Isidro",5.0,1,"","Fondo de ojo|Glaucoma","Salud visual de adultos y niños."],
            ["Dr. Andrés Vega","Endocrinólogo • 11 años de experiencia","Endocrinología",190,4.7,83,"San Borja",4.2,0,"","Diabetes|Tiroides","Manejo de diabetes y trastornos hormonales."],
            ["Dra. Sofía Ramírez","Psicóloga clínica • 9 años de experiencia","Psicología",100,4.8,141,"La Molina",7.9,1,"","Ansiedad|Terapia","Terapia individual y de pareja."]
          ], "fa-user-md", true),
          clinicas: mk([
            ["Clínica San Juan","Médico general • Odontología","Clínica",80,4.8,124,"Miraflores",1.2,1,"fa-hospital","Abierto hasta 20:00|Pago con tarjeta","Atención ambulatoria con consulta general, odontología y exámenes básicos."],
            ["Laboratorio Médico Central","Análisis clínicos • Diagnóstico","Laboratorio",45,4.6,89,"Lince",0.8,1,"fa-flask","Resultados online|Abierto hasta 18:00","Toma de muestras y resultados en línea con entrega rápida."],
            ["Clínica Médica Central","Centro de salud de primer nivel","Clínica",80,4.5,128,"San Isidro",5.2,1,"fa-clinic-medical","Estacionamiento|Seguros aceptados","Más de 15 años con medicina general, pediatría y ginecología."],
            ["Centro Cardiológico","Especialidad en corazón","Centro especializado",150,4.9,203,"San Borja",4.0,0,"fa-heartbeat","Ecocardiograma|Holter","Diagnóstico y seguimiento cardiovascular."],
            ["Clínica Angloamericana","Hospital • Servicios completos","Hospital",200,4.6,342,"La Molina",8.1,1,"fa-hospital-alt","24 horas|Emergencias","Hospitalización, emergencias 24 horas y especialidades."],
            ["Clínica Surco Vital","Centro médico • Especialidades","Centro especializado",120,4.4,218,"Santiago de Surco",6.4,0,"fa-stethoscope","8:00 - 20:00|Pago con Yape","Consultas de especialidad, odontología y laboratorio."],
            ["Clínica Miraflores Salud","Consultas • Imágenes","Clínica",95,4.5,167,"Miraflores",1.6,1,"fa-hospital","Rayos X|Farmacia","Atención ambulatoria con imágenes diagnósticas."],
            ["Centro Médico San Isidro","Especialidades médicas","Centro especializado",170,4.7,139,"San Isidro",4.8,1,"fa-clinic-medical","Citas el mismo día","Consultas de especialidad y chequeos ejecutivos."],
            ["Policlínico La Molina","Medicina familiar","Policlínico",65,4.3,102,"La Molina",8.3,1,"fa-house-medical","Vacunas|Pediatría","Atención familiar a precio accesible."],
            ["Laboratorio Miraflores Diagnóstica","Análisis clínicos","Laboratorio",50,4.4,76,"Miraflores",1.4,0,"fa-microscope","Abierto hasta 18:00","Exámenes de sangre y orina con resultados en línea."]
          ], "fa-hospital")
        };
      })();

  const CLI = [
    ["Av. Larco 345, Miraflores", "(01) 445-1200"],
    ["Av. Arequipa 1450, Lince", "(01) 500-1200"],
    ["Av. Principal 123, San Isidro", "(01) 234-5678"],
    ["Av. Javier Prado Este 2100, San Borja", "987 654 321"],
    ["Av. La Molina 1200, La Molina", "(01) 616-8900"],
    ["Av. Caminos del Inca 2200, Santiago de Surco", "987 321 654"],
    ["Av. Larco 812, Miraflores", "(01) 445-2100"],
    ["Calle Los Pinos 340, San Isidro", "(01) 421-7788"],
    ["Av. La Molina 1560, La Molina", "(01) 349-0045"],
    ["Av. Benavides 1234, Miraflores", "(01) 242-5566"]
  ];
  const MED_CLI = [1, 3, 5, 6, 4, 7, 2, 8, 4, 9]; // clínica donde atiende cada médico
  const TIPOS = {
    servicios: { singular: "Servicio", plural: "Servicios" },
    medicos: { singular: "Médico", plural: "Médicos" },
    clinicas: { singular: "Clínica", plural: "Clínicas" }
  };
  function buscar(tipo, id) { return (DATA[tipo] || []).find((x) => String(x.id) === String(id)) || null; }
  function clinicaDe(tipo, x) {
    if (tipo === "clinicas") return x;
    if (tipo === "servicios") return DATA.clinicas.find((c) => c.nombre === x.sub);
    return DATA.clinicas[MED_CLI[x.id - 1] - 1];
  }
  g.Directorio = {
    DATA, TIPOS, buscar, clinicaDe,
    dir: (c) => CLI[c.id - 1][0],
    tel: (c) => CLI[c.id - 1][1],
    serviciosDe: (c) => DATA.servicios.filter((s) => s.sub === c.nombre),
    medicosDe: (c) => DATA.medicos.filter((m, i) => MED_CLI[i] === c.id)
  };
})(window);
