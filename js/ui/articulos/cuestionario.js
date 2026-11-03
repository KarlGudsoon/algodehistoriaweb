// js/ui/articulos/cuestionario.js

let opcion_elegida = {};
let preguntasActuales = [];
let currentQuestion = 0;

async function inicializarCuestionario(articuloSlug) {
  preguntasActuales = await obtenerPreguntas(articuloSlug);
  renderizarPreguntas(preguntasActuales);

  const questions = document.querySelectorAll(".question");
  const prevButton = document.getElementById("prev");
  const nextButton = document.getElementById("next");
  const submitButton = document.querySelector("#finalizar-cuestionario-final");

  questions[currentQuestion].classList.add("active");
  updateQuestionNumber();
  currentQuestionNumber();

  try {
    const resultadoPrevio = await obtenerResultadoCuestionario(articuloSlug);

    if (resultadoPrevio?.aprobado) {
      document.getElementById("grafico-cuestionario").innerHTML =
        generarMedidor(resultadoPrevio.nota);
      mostrarResumenFinal(
        preguntasActuales,
        resultadoPrevio.respuestas_correctas,
      );
      marcarAprobado();
    }
  } catch (error) {
    console.warn("No se pudo verificar resultado previo:", error.message);
  }

  function showQuestion(index) {
    questions.forEach((q, i) => q.classList.toggle("active", i === index));
    updateQuestionNumber();
  }

  function updateQuestionNumber() {
    document.getElementById("currentQuestion").innerHTML =
      `${currentQuestion + 1}`;
  }

  function currentQuestionNumber() {
    document
      .querySelectorAll(".markerQuestion span")
      .forEach((s) => s.classList.remove("activa"));
    const actual = document.getElementById(`c-p${currentQuestion}`);
    if (actual) actual.classList.add("activa");
  }

  nextButton.addEventListener("click", () => {
    if (currentQuestion < questions.length - 1) {
      currentQuestion++;
      showQuestion(currentQuestion);
      currentQuestionNumber();
    }
  });

  prevButton.addEventListener("click", () => {
    if (currentQuestion > 0) {
      currentQuestion--;
      showQuestion(currentQuestion);
      currentQuestionNumber();
    }
  });

  window.respuesta = function (numPregunta, seleccionada) {
    opcion_elegida[numPregunta] = parseInt(seleccionada.value);

    const id = "p" + numPregunta;
    const labels = document.querySelectorAll(`#${id} label`);
    labels.forEach((l) => l.classList.remove("seleccionada"));
    seleccionada.parentNode.classList.add("seleccionada");

    const span = document.getElementById(`c-${id}`);
    if (span) span.classList.add("hecha");

    checkAllQuestionsAnswered(questions, submitButton);
  };

  submitButton.addEventListener("click", async () => {
    if (Object.keys(opcion_elegida).length < preguntasActuales.length) {
      mostrarErrorCuestionario(
        "Debes responder todas las preguntas antes de enviar el cuestionario.",
      );
      return;
    }

    submitButton.disabled = true;
    submitButton.style.pointerEvents = "none";
    ocultarErrorCuestionario();

    try {
      const resultado = await corregirCuestionario(
        articuloSlug,
        opcion_elegida,
      );

      document.getElementById("grafico-cuestionario").innerHTML =
        generarMedidor(resultado.nota);
      document.querySelector(".container-preguntas").style.display = "none";
      document
        .querySelector(".resultado-cuestionario-final")
        .classList.add("active");

      if (resultado.aprobado) {
        mostrarNotificacionXP(resultado.xp_ganado, "¡Artículo completado!");
        mostrarResumenFinal(
          preguntasActuales,
          resultado.respuestas_correctas,
        );
        marcarAprobado();
      } else {
        document
          .getElementById("reintentar-cuestionario")
          .classList.add("active");
      }
    } catch (error) {
      console.error("Error al corregir el cuestionario:", error.message);
      mostrarErrorCuestionario(
        "No se pudo guardar tu resultado. " + error.message,
      );
    } finally {
      submitButton.disabled = false;
      submitButton.style.pointerEvents = "auto";
    }
  });

  document
    .getElementById("reintentar-cuestionario")
    .addEventListener("click", () => {
      reiniciarCuestionarioUI(questions);
    });

  document
    .getElementById("finalizar-articulo")
    .addEventListener("click", () => {
      document.querySelector(".cuestionario-final").classList.remove("active");
      document.body.classList.remove("no-scroll");
      confetti({ particleCount: 200, spread: 600, origin: { x: 0.5, y: 0 } });
    });
}

function renderizarPreguntas(preguntas) {
  const contenedor = document.querySelector(".container-preguntas");
  const marcadores = document.querySelector(".markerQuestion");

  contenedor.querySelectorAll(".question").forEach((q) => q.remove());
  marcadores.innerHTML = "";

  preguntas.forEach((p, index) => {
    const opciones = [p.opcion_1, p.opcion_2, p.opcion_3, p.opcion_4];

    const seccion = document.createElement("section");
    seccion.className = "question";
    seccion.id = `p${index}`;
    seccion.innerHTML = `
      <h2>${p.pregunta}</h2>
      ${opciones
        .map(
          (op, i) => `
        <label>
          <input type="radio" value="${i + 1}" name="p${index}" onclick="respuesta(${index}, this)"> ${op}
        </label>
      `,
        )
        .join("")}
    `;
    contenedor.appendChild(seccion);

    const span = document.createElement("span");
    span.id = `c-p${index}`;
    span.innerHTML = `<p>${index + 1}</p>`;
    marcadores.appendChild(span);
  });

  const spanNumero = document.createElement("span");
  spanNumero.id = "currentQuestion";
  spanNumero.hidden = true;
  marcadores.appendChild(spanNumero);
}

function checkAllQuestionsAnswered(questions, submitButton) {
  const allAnswered = Array.from(questions).every((q) =>
    Array.from(q.querySelectorAll('input[type="radio"]')).some(
      (i) => i.checked,
    ),
  );
  submitButton.style.pointerEvents = allAnswered ? "auto" : "none";
  submitButton.style.filter = allAnswered
    ? "brightness(100%)"
    : "brightness(80%)";
}

function mostrarErrorCuestionario(mensaje) {
  const contenedor = document.querySelector(".datos");
  if (!contenedor) return;

  let error = document.getElementById("error-cuestionario");
  if (!error) {
    error = document.createElement("p");
    error.id = "error-cuestionario";
    error.style.cssText =
      "color:#eb3b3b;font-size:0.9rem;margin:0.5rem 0 0;text-align:center;";
    contenedor.appendChild(error);
  }

  error.textContent = mensaje;
  error.hidden = false;
}

function ocultarErrorCuestionario() {
  const error = document.getElementById("error-cuestionario");
  if (error) error.hidden = true;
}

function marcarAprobado() {
  const WidgetCuestionario = document.querySelector(".widget-cuestionario");
  const WidgetProgresoPagina = document.querySelector(
    ".widget-progreso-pagina",
  );
  const ArticuloCompletadoTitulo = document.querySelector(
    ".texto-inicio-pagina",
  );
  const submitButton = document.getElementById("finalizar-cuestionario-final");

  WidgetCuestionario.querySelector("img").src = "/assets/icons/check-white.svg";
  WidgetProgresoPagina.setAttribute(
    "data-tippy-content",
    "Artículo completado",
  );
  ArticuloCompletadoTitulo.classList.add("completado");

  document.querySelector(".container-preguntas").style.display = "none";
  document
    .querySelector(".resultado-cuestionario-final")
    .classList.add("active");
  document.querySelector(".progress-ring-bg").style.fill = "#408464";
  document.querySelector(
    ".progreso-cuestionario-final .progreso-completado",
  ).style.display = "block";

  if (submitButton) submitButton.style.display = "none";
  ocultarErrorCuestionario();

  document.getElementById("reintentar-cuestionario").classList.remove("active");
}

function mostrarResumenFinal(preguntas, respuestasCorrectas) {
  const contenedorResumen = document.getElementById("resumen-respuestas");
  const contenedorResultado = document.querySelector(
    ".resultado-cuestionario-final",
  );
  contenedorResumen.innerHTML = "";
  contenedorResumen.style.display = "block";
  contenedorResultado.style.justifyContent = "flex-start";

  preguntas.forEach((p, index) => {
    const opciones = [p.opcion_1, p.opcion_2, p.opcion_3, p.opcion_4];
    const correctaTexto = opciones[respuestasCorrectas[index] - 1];

    const bloque = document.createElement("div");
    bloque.classList.add("resumen-item");
    bloque.innerHTML = `
      <p><strong>${index + 1}. ${p.pregunta}</strong></p>
      <p>✅ Respuesta correcta: <span style="color:green;">${correctaTexto}</span></p>
      <hr>
    `;
    contenedorResumen.appendChild(bloque);
  });
}

function reiniciarCuestionarioUI(questions) {
  opcion_elegida = {};
  currentQuestion = 0;

  questions.forEach((q) => {
    q.querySelectorAll('input[type="radio"]').forEach(
      (r) => (r.checked = false),
    );
    q.querySelectorAll("label").forEach((l) =>
      l.classList.remove("seleccionada"),
    );
  });

  questions[0].classList.add("active");
  questions.forEach((q, i) => i !== 0 && q.classList.remove("active"));

  document
    .querySelector(".resultado-cuestionario-final")
    .classList.remove("active");
  document.getElementById("resumen-respuestas").style.display = "none";
  document.querySelector(".container-preguntas").style.display = "block";

  document
    .querySelectorAll(".markerQuestion span")
    .forEach((s) => s.classList.remove("hecha"));
}

function generarMedidor(promedio) {
  const radio = 60;
  const circunferencia = 2 * Math.PI * radio;
  const porcentaje = Math.min(Math.max(promedio, 0), 7);
  const offset = circunferencia * (1 - porcentaje / 7);
  const porcentajeNota = ((porcentaje / 7) * 100).toFixed(0);

  let color = promedio >= 5 ? "#0da761" : promedio >= 4 ? "#f2a400" : "#eb3b3b";

  return `
    <svg width="280" height="250" viewBox="0 0 180 220" xmlns="http://www.w3.org/2000/svg" style="font-family: sans-serif;">
    <circle cx="90" cy="90" r="${radio}" stroke="#ddd" stroke-width="12" fill="none"/>
    <circle cx="90" cy="90" r="${radio}" stroke="${color}" stroke-width="12" fill="none"
        stroke-dasharray="${circunferencia}" 
        stroke-dashoffset="${offset}"
        stroke-linecap="round"
        transform="rotate(-90 90 90)" />
    <text x="90" y="100" text-anchor="middle" font-family="Roboto" font-size="32" fill="#2e2e2e">${porcentajeNota}%</text>
    <text x="90" y="190" text-anchor="middle" font-family="Roboto" font-size="16" fill="#2e2e2e" font-weight="bold" letter-spacing="2">
        ${promedio === 7 ? "PERFECTO" : promedio >= 4 ? "APROBADO" : "NO APROBADO"}
    </text>
    <text x="90" y="210" text-anchor="middle" font-size="12" fill="#2e2e2e" letter-spacing="2">PORCENTAJE DE APROBACIÓN</text>
    </svg>`;
}

let cerrarCuestionario = document.querySelector(".cerrar-contenedor");

if (cerrarCuestionario) {
  cerrarCuestionario.addEventListener("click", function () {
    this.parentElement.classList.remove("active");
    document.body.classList.remove("no-scroll");
  });
}
