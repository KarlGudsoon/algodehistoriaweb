async function inicializarEstadisticas() {
  try {
    const catalogoCartas = await fetch("/data/cartas.json").then((r) =>
      r.json(),
    );
    const catalogoPaises = await fetch("/data/paises.json").then((r) =>
      r.json(),
    );
    const totalCartas = Object.keys(catalogoCartas).length;
    const totalPaises = Object.keys(catalogoPaises).length;
    const datosUsuario = await obtenerDatosUsuario();
    const datos = await obtenerEstadisticasDashboard();
    const nivelInfo = await obtenerNivelUsuario();
    const articulosC = await obtenerArticulosCompletados();

    renderizarUsuario(datosUsuario);
    renderizarNivel(nivelInfo);
    renderizarResumenProgreso(datos.progreso, totalCartas, totalPaises);
    renderizarArticuloReciente(articulosC[0]);
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

  document.querySelectorAll(".infocards").forEach((card) => {
    card.classList.remove("skeleton");
  });
}

function renderizarArticuloReciente(articulo) {
  const contenedor = document.getElementById("articuloReciente");
  if (!contenedor) return;

  console.log(articulo);

  const personajeArticulo = document.getElementById("personajeArtReciente");

  if (articulo.personaje) {
    personajeArticulo.src = articulo.personaje;
  }

  if (articulo.fondo) {
    contenedor.style.backgroundImage = `url(${articulo.fondo})`;
  }

  document.getElementById("urlArtReciente").href = articulo.url;

  el("tituloArtReciente", articulo.titulo);
  el("descArtReciente", articulo.descripcion);

  const nuevasCartas = document.querySelectorAll("[data-tilt]");
  VanillaTilt.init(nuevasCartas);
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

  console.log(articulo);

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
