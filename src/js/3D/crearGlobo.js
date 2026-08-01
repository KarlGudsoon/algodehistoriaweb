// js/3D/crearGlobo.js — Globo 3D reutilizable (globe.gl / three.js)
// Uso: const globo = crearGlobo(contenedor, { onPaisClick, focoInicial });

window.crearGlobo = function crearGlobo(contenedor, opciones = {}) {
  const estilos = getComputedStyle(document.documentElement);
  const COLOR_OCEANO = estilos.getPropertyValue("--red").trim() || "#e92a41";
  const COLOR_PAIS = estilos.getPropertyValue("--yellow").trim() || "#ffa218";
  const COLOR_OSCURO = opciones.colorOscuro || "#8c1726";
  const COLOR_RESALTADO = opciones.colorResaltado || "#ffffff";
  const ALTURA_BASE = opciones.alturaBase ?? 0.007;

  let paisSobrevolado = null;
  let isosDestacados = opciones.isosDestacados || new Set();
  let isosResaltados = new Set();

  function aclararColor(hex, factor = 0.1) {
    const n = parseInt(hex.replace("#", ""), 16);
    const r = (n >> 16) & 255;
    const g = (n >> 8) & 255;
    const b = n & 255;
    return `rgb(${Math.round(r + (255 - r) * factor)}, ${Math.round(
      g + (255 - g) * factor,
    )}, ${Math.round(b + (255 - b) * factor)})`;
  }

  function colorBase(d) {
    if (isosResaltados.has(d.properties.iso)) return COLOR_RESALTADO;
    return isosDestacados.has(d.properties.iso) ? COLOR_PAIS : COLOR_OSCURO;
  }

  function colorPoligono(d) {
    return d === paisSobrevolado ? aclararColor(colorBase(d)) : colorBase(d);
  }

  function colorBordePoligono(d) {
    return d === paisSobrevolado ? "" : COLOR_OCEANO;
  }

  const mundo = Globe({
    rendererConfig: { antialias: opciones.antialias ?? false },
  })
    .showAtmosphere(true)
    .atmosphereColor(COLOR_OCEANO)
    .atmosphereAltitude(0.12)
    .showGraticules(false)
    .polygonsTransitionDuration(250)
    .polygonAltitude(ALTURA_BASE)
    .polygonCapColor(colorPoligono)
    .polygonSideColor(() => "#8c1726")
    .polygonStrokeColor(colorBordePoligono)
    .polygonLabel(({ properties: d }) => `<b>${d.nameES}</b>`)
    .onPolygonHover((poligono) => {
      paisSobrevolado = poligono || null;
      mundo.polygonCapColor(colorPoligono);
      mundo.polygonStrokeColor(colorBordePoligono);
    })
    .onPolygonClick((poligono) => {
      if (poligono && opciones.onPaisClick) {
        opciones.onPaisClick(poligono.properties);
      }
    })(contenedor);

  mundo.globeMaterial().color.set(COLOR_OCEANO);

  if (opciones.colorFondo) {
    mundo.backgroundColor(opciones.colorFondo);
  }

  // Rotación automática suave cuando no se interactúa
  mundo.controls().autoRotate = true;
  mundo.controls().autoRotateSpeed = 0.4;

  const focoInicial = opciones.focoInicial || {
    lat: -25,
    lng: -70,
    altitude: 2.4,
  };
  mundo.pointOfView(focoInicial, 0);

  // Un click sobre el globo (sin arrastrar) también detiene la rotación
  let puntoInicial = null;
  contenedor.addEventListener("pointerdown", (e) => {
    puntoInicial = { x: e.clientX, y: e.clientY };
  });
  contenedor.addEventListener("pointerup", (e) => {
    if (
      puntoInicial &&
      Math.hypot(e.clientX - puntoInicial.x, e.clientY - puntoInicial.y) < 5
    ) {
      mundo.controls().autoRotate = false;
    }
    puntoInicial = null;
  });

  function cargarMapa(archivo) {
    return fetch("/data/" + archivo)
      .then((res) => {
        if (!res.ok) throw new Error("No se pudo cargar " + archivo);
        return res.json();
      })
      .then((geo) => {
        const paises = geo.features.filter(
          (f) => f.properties.iso && f.properties.iso !== "AQ",
        );
        mundo.polygonsData(paises);
        mundo.polygonCapColor(colorPoligono);
        return paises;
      })
      .catch((error) => {
        console.error("Error al cargar el globo:", error);
      });
  }

  function destacarIsos(isos) {
    isosDestacados = isos || new Set();
    mundo.polygonCapColor(colorPoligono);
  }

  function resaltarIsos(isos) {
    isosResaltados = new Set(isos || []);
    mundo.polygonCapColor(colorPoligono);
  }

  function focoEn(coords) {
    if (coords && coords.lat != null && coords.lng != null) {
      mundo.pointOfView(
        { lat: coords.lat, lng: coords.lng, altitude: 1.6 },
        1200,
      );
    }
  }

  function toggleRotacion() {
    const controles = mundo.controls();
    controles.autoRotate = !controles.autoRotate;
    return controles.autoRotate;
  }

  function sincronizarBoton(boton) {
    if (boton) {
      boton.textContent = mundo.controls().autoRotate
        ? "Detener rotación"
        : "Reanudar rotación";
    }
  }

  // globe.gl fija el canvas al tamaño de la ventana (sin ResizeObserver propio),
  // así que lo dimensionamos explícitamente según el contenedor y lo mantenemos al día.
  let marcoPendiente = null;

  function dimensionar() {
    const rect = contenedor.getBoundingClientRect();
    const ancho = rect.width;
    const alto = rect.height;
    if (ancho > 0 && alto > 0) {
      mundo.width(ancho);
      mundo.height(alto);
    }
  }

  function programarDimensionar() {
    if (marcoPendiente) return;
    marcoPendiente = requestAnimationFrame(() => {
      marcoPendiente = null;
      dimensionar();
    });
  }

  requestAnimationFrame(dimensionar);

  let observador = null;
  if (typeof ResizeObserver !== "undefined") {
    observador = new ResizeObserver(programarDimensionar);
    observador.observe(contenedor);
  } else {
    window.addEventListener("resize", programarDimensionar);
  }

  function destruir() {
    if (marcoPendiente) {
      cancelAnimationFrame(marcoPendiente);
      marcoPendiente = null;
    }
    if (observador) {
      observador.disconnect();
      observador = null;
    } else {
      window.removeEventListener("resize", programarDimensionar);
    }
  }

  return {
    mundo,
    cargarMapa,
    destacarIsos,
    resaltarIsos,
    focoEn,
    toggleRotacion,
    sincronizarBoton,
    destruir,
  };
};
