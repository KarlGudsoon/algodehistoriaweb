async function inicializarEstadisticas() {
  try {
    const { cantidad: totalCartas } = await fetch(
      "/api/cartas/cantidad_cartas.php",
    ).then((r) => r.json());
    const coleccionPaises = await fetch("/api/paises/coleccion_pais.php").then(
      (r) => r.json(),
    );
    const totalPaises = coleccionPaises.total;
    const datosUsuario = await obtenerDatosUsuario();
    const datos = await obtenerEstadisticasDashboard();
    const nivelInfo = await obtenerNivelUsuario();
    const articulosC = await obtenerArticulosCompletados();
    const paisDestacado = await obtenerPaisDestacado();

    console.log(articulosC);

    renderizarUsuario(datosUsuario);
    renderizarNivel(nivelInfo);
    renderizarResumenProgreso(datos.progreso, totalCartas, totalPaises);
    renderizarArticuloReciente(articulosC[0]);
    renderizarCartaDestacada();
    renderizarPaisDestacado(paisDestacado);
    // renderizarHistorialArticulos(datos.historial_articulos);
  } catch (error) {
    if (error.message === "No autenticado") {
      window.location.href = "/login.html";
    } else {
      console.error("Error al cargar estadísticas:", error);
    }
  }
}

function renderizarUsuario(datos) {
  const primerNombre = datos.name?.trim().split(/\s+/)[0] || "Usuario";
  document.getElementById("nombreUsuario").textContent = primerNombre;
}

function renderizarNivel(nivelInfo) {
  document.getElementById("nivelUsuario").textContent =
    `Nivel ${nivelInfo.nivel}`;
  document.getElementById("xpActual").textContent =
    nivelInfo.xp_en_nivel_actual;
  document.getElementById("xpSiguiente").textContent =
    nivelInfo.xp_para_siguiente_nivel;

  const barra = document.getElementById("barraNivel");
  if (barra) barra.style.width = `${nivelInfo.porcentaje_nivel}%`;

  document.getElementById("xpTotal").textContent = nivelInfo.xp_total;
}

function renderizarResumenProgreso(progreso, totalCartas, totalPaises) {
  const contenedor = document.getElementById("resumenProgreso");
  const porcentaje =
    progreso.articulos_totales > 0
      ? Math.round(
          (progreso.articulos_completados / progreso.articulos_totales) * 100,
        )
      : 0;

  const articulosCompletados = document.getElementById("articulosCompletados");
  const articulosTotales = document.getElementById("articulosTotales");
  articulosCompletados.textContent = progreso.articulos_completados;
  articulosTotales.textContent = progreso.articulos_totales;

  document.getElementById("cartasObtenidas").textContent =
    progreso.cartas_obtenidas;
  document.getElementById("cartasTotales").textContent = totalCartas;

  document.getElementById("paisesDescubiertos").textContent =
    progreso.paises_descubiertos;
  document.getElementById("paisesTotales").textContent = totalPaises;

  contenedor.querySelectorAll(".infocards").forEach((card) => {
    card.classList.remove("skeleton");
    card.classList.add("aparecer");
  });
}

function renderizarArticuloReciente(articulo) {
  const contenedor = document.getElementById("articuloReciente");
  const personajeArticulo = document.getElementById("personajeArtReciente");

  if (!articulo) {
    contenedor.classList.remove("skeleton");
    contenedor.classList.add("aparecer");

    document.getElementById("urlArtReciente").href = "/#articulos";
    el("urlArtReciente", "Ver artículos interactivos");

    el(
      "descArtReciente",
      "Todavía no has completado ningún artículo, ¡descúbrelos en la sección de artículos interactivos!",
    );
    document
      .querySelector(".articulo-reciente-info")
      .classList.remove("articulo-reciente-info");
    personajeArticulo.src = "/assets/icons/logo.svg";
    personajeArticulo.style.opacity = "0.2";
    return;
  }

  const fondo = document.getElementById("fondoArticuloReciente");
  if (!contenedor) return;

  if (articulo.personaje) {
    personajeArticulo.src = articulo.personaje;
  } else {
    personajeArticulo.src = "/assets/icons/logo.svg";
  }

  if (articulo.fondo) {
    fondo.style.backgroundImage = `url(${articulo.fondo})`;
  }

  document.getElementById("urlArtReciente").href = articulo.url;

  el("tituloArtReciente", articulo.titulo);
  el("descArtReciente", articulo.descripcion);

  const nuevasCartas = document.querySelectorAll("[data-tilt]");
  VanillaTilt.init(nuevasCartas);
  contenedor.classList.remove("skeleton");
  contenedor.classList.add("aparecer");
}

async function renderizarCartaDestacada() {
  const contenedor = document.getElementById("contenedorCartaDestacada");

  const contenedorCarta = document.getElementById("cartaDestacada");

  const carta = await obtenerCartaDestacada();

  if (!carta) {
    contenedorCarta.innerHTML = `
      <div class="carta-placeholder"></div>
    `;
    document.getElementById("badgeCartaDestacada").remove();
    document.getElementById("cartaDestacadaTitulo").remove();
    el(
      "cartaDestacadaDesc",
      "Todavía no has desbloqueado ninguna carta de personaje, descúbrelas en cada artículo interactivo",
    );
    contenedor.classList.remove("skeleton");
    contenedor.classList.add("aparecer");
    return;
  }

  const esp = carta.especialidad.toLowerCase();
  let especialidadImg = "";

  if (esp === "agricultor") {
    especialidadImg = "/assets/icons/trigo.svg";
  } else if (esp === "intrepido" || esp === "intrépido") {
    especialidadImg = "/assets/icons/game-icons--angry-eyes.svg";
  } else if (esp === "pensador") {
    especialidadImg = "/assets/icons/cerebro.svg";
  }

  contenedorCarta.innerHTML = "";

  contenedor.style.backgroundImage = `url(${carta.fondoFrontal})`;

  contenedorCarta.innerHTML = `
  <div class="carta-placeholder">
    <div class="item " id="personaje-historico" data-tilt>
      <div id="carta-expandir">«»</div>
      <div class="etiqueta">
          <span>Personaje Histórico</span>
          <h1 id="nombre-personaje">${carta.titulo}</h1>
          <span id="categoria-personaje" class="${carta.categoria[0].clase}">${carta.categoria[0].nombre}</span>
      </div>
      <div class="contenedor-caracteristicas">
          <span id="puntaje-carta-personaje">${carta.puntaje}</span>
          <span class="conector"></span>
          <span class="caracteristicas-personaje-frontal ${carta.personalidad[0]?.clase || "punto-basico"}" data-content="${carta.personalidad[0]?.nombre || ""}"><img src="${carta.personalidad[0]?.img || ""}"></span>
          <span class="conector"></span>
          <span class="caracteristicas-personaje-frontal ${carta.personalidad[1]?.clase || "punto-basico"}" data-content="${carta.personalidad[1]?.nombre || ""}"><img src="${carta.personalidad[1]?.img || ""}"></span>
          <span class="conector"></span>
          <span class="caracteristicas-personaje-frontal ${carta.personalidad[2]?.clase || "punto-basico"}" data-content="${carta.personalidad[2]?.nombre || ""}"><img src="${carta.personalidad[2]?.img || ""}"></span>
      </div>
      <div class="contenedor-especialidad">
          <div class="especialidad-personaje">
              <img src="${especialidadImg}">
          </div>
          <span class="especialidad-nombre">${carta.especialidad}</span>
      </div>
      <div class="img-personaje-frontal">
          <img id="imagen-personaje" class="personaje-historico-item" src="${carta.imagen}" draggable="false">
      </div>
      <div id="face-frontal" class="face frontal ${carta.rareza}">
          <div class="fondo-frontal">
              <h1 class="etiqueta-fondo" id="etiqueta-fondo-frontal">${carta.categoria[0].nombre}</h1>
              <img id="fondo-frontal" src="${carta.fondoFrontal}" draggable="false">      
          </div>
      </div>
      <div class="descripcion-personaje-trasera">
          <div class="carta-personalidad" id="personalidad-personaje">
              <span class="${carta.personalidad[0]?.clase || ""}">${carta.personalidad[0]?.nombre || ""}</span>
              <span class="${carta.personalidad[1]?.clase || ""}">${carta.personalidad[1]?.nombre || ""}</span>
              <span class="${carta.personalidad[2]?.clase || ""}">${carta.personalidad[2]?.nombre || ""}</span>
          </div>
          <div class="descripcion-personaje-texto ${carta.colorCarta}" id="descripcion-personaje-texto">
              <p id="descripcion-personaje">${carta.descripcion}</p>
          </div>
          <div class="descripcion-personaje-caracteristicas" id="iconos-personaje">
              <span class="lugar-personaje ${carta.colorCarta}" data-tippy-content="${carta.lugar ? carta.lugar : "Sin información"}"><img src="/svg/mundo.svg"><img src="${carta.bandera}" id="img-lugar-personaje"></span>
              <span class="reconocimiento-personaje ${carta.colorCarta}" data-reconocimiento='${JSON.stringify(carta.reconocimiento || [])}'><img src="/svg/ribbon.svg"></span>
              <span class="tiempo-personaje ${carta.colorCarta}" data-tippy-content="${carta.tiempo ? carta.tiempo : "Sin información"}"><img draggable="false" src="/svg/tiempo.svg"></span>
          </div>
      </div>
      <img id="imagen-personaje-trasera" class="personaje-historico-item-trasera" src="${carta.imagen}" draggable="false">
      <div id="face-trasera" class="face trasera ${carta.rareza}">
          <div class="img-personaje-trasera">
              <h1 class="etiqueta-fondo" id="etiqueta-fondo-trasera">${carta.titulo}</h1>
              <img id="fondo-trasera" src="${carta.fondoTrasera}">
          </div>
      </div>
  </div>
  </div>
  `;

  el("badgeCartaDestacada", "Nueva");
  el("cartaDestacadaTitulo", carta.titulo);
  el("cartaDestacadaTiempo", carta.tiempo);
  el("cartaDestacadaDesc", carta.descripcion);

  activarTiltEnNuevasCartas();
  activarTippyEnNuevasCartas();
  activarExpandirEnNuevasCartas();
  contenedor.classList.remove("skeleton");
  contenedor.classList.add("aparecer");
}

function renderizarPaisDestacado(pais) {
  const contenedor = document.getElementById("contenedorPaisDestacado");

  if (!pais) {
    document.getElementById("badgePaisDestacado").remove();
    document.getElementById("paisDestacadoTitulo").remove();
    el(
      "paisDestacadoDesc",
      "Todavía no has desbloqueado ningún país, descúbrelos en cada artículo interactivo",
    );
    const segundoContenedor = document.getElementById("paisDestacado");
    const placeholder = document.createElement("div");
    placeholder.classList.add("carta-placeholder");
    segundoContenedor.innerHTML = "";
    segundoContenedor.appendChild(placeholder);

    contenedor.classList.remove("skeleton");
    contenedor.classList.add("aparecer");
    return;
  }

  contenedor.setAttribute(
    "style",
    "--color: " +
      pais.colorFondo +
      "; background-image: url(" +
      pais.fondo +
      ");",
  );

  if (!contenedor) return;

  document.getElementById("badgePaisDestacado").className =
    "bg-green-600 mb-2 px-2 rounded-xl inline-block";

  el("badgePaisDestacado", "Nuevo");
  el("paisDestacadoTitulo", pais.nombre);
  el("paisDestacadoTiempo", `${pais.tiempo[0]} - ${pais.tiempo[1]}`);
  el("paisDestacadoDesc", pais.descripcion);

  contenedor.classList.remove("skeleton");
  contenedor.classList.add("aparecer");
}

function renderizarHistorialArticulos(historial) {
  const contenedor = document.getElementById("historialArticulos");

  if (historial.length === 0) {
    contenedor.innerHTML = "<p>Todavía no has completado ningún artículo.</p>";
    return;
  }

  contenedor.innerHTML = historial
    .map(
      (item) => `
    <div class="historial-item">
      <span>${item.titulo}</span>
      <span>${item.aprobado ? "✅" : "❌"} Nota: ${item.nota}</span>
    </div>
  `,
    )
    .join("");
}

function el(elemento, contenido) {
  document.getElementById(elemento).textContent = contenido;
}

function renderizarArticulos(articulo) {
  const contenedor = document.getElementById("articuloReciente");
  if (!contenedor) return;

  contenedor.innerHTML = "";

  // console.log(articulo);

  const Articulo = document.createElement("a");
  const InnerArticulo = document.createElement("div");
  InnerArticulo.classList.add("card-contenido", "active");
  InnerArticulo.setAttribute("data-tilt", "");

  const PersonajeImagen = document.createElement("img");
  PersonajeImagen.classList.add("personaje-img");

  const ContenidoImagen = document.createElement("div");
  ContenidoImagen.classList.add("card-contenido-img");
  const imgContenidoImagen = document.createElement("img");

  const ContenidoEtiqueta = document.createElement("div");
  ContenidoEtiqueta.classList.add("card-contenido-etiqueta");
  const ContenidoTitulo = document.createElement("h1");
  const ArticuloDescripcion = document.createElement("p");
  ArticuloDescripcion.classList.add("card-contenido-descripcion");
  const ArticuloFecha = document.createElement("span");
  Articulo.classList.add("art");

  contenedor.appendChild(Articulo);
  Articulo.appendChild(InnerArticulo);
  InnerArticulo.appendChild(PersonajeImagen);
  InnerArticulo.appendChild(ContenidoImagen);
  ContenidoImagen.appendChild(imgContenidoImagen);
  InnerArticulo.appendChild(ContenidoEtiqueta);
  ContenidoEtiqueta.appendChild(ContenidoTitulo);
  InnerArticulo.appendChild(ArticuloDescripcion);
  ContenidoEtiqueta.appendChild(ArticuloFecha);

  if (articulo.titulo) ContenidoTitulo.textContent = articulo.titulo;
  if (articulo.resumen) ArticuloDescripcion.textContent = articulo.resumen;
  if (articulo.fecha_exacta) ArticuloFecha.textContent = articulo.fecha_exacta;
  if (articulo.url) Articulo.href = articulo.url;

  if (articulo.fondo) {
    imgContenidoImagen.src = articulo.fondo;
  } else {
    imgContenidoImagen.style.display = "none";
  }

  if (articulo.personaje) {
    PersonajeImagen.src = articulo.personaje;
  } else {
    PersonajeImagen.style.display = "none";
  }

  el("tituloArtReciente", articulo.titulo);
  el("descArtReciente", articulo.descripcion);

  const nuevasCartas = document.querySelectorAll("[data-tilt]");
  VanillaTilt.init(nuevasCartas);
}
