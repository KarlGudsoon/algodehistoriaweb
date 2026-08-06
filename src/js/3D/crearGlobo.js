// js/3D/crearGlobo.js — Globo 3D reutilizable (globe.gl / three.js)
// Uso: const globo = crearGlobo(contenedor, { onPaisClick, focoInicial });

window.crearGlobo = function crearGlobo(contenedor, opciones = {}) {
  const estilos = getComputedStyle(document.documentElement);
  const COLOR_OCEANO = estilos.getPropertyValue("--red").trim() || "#eff4f9";
  const COLOR_PAIS = estilos.getPropertyValue("--yellow").trim() || "#7fb275";
  const COLOR_OSCURO = opciones.colorOscuro || "#d6d3d4";
  const COLOR_RESALTADO = opciones.colorResaltado || "#d6d5d7";
  const ALTURA_BASE = opciones.alturaBase ?? 0.007;

  let paisSobrevolado = null;
  let isosDestacados = opciones.isosDestacados || new Set();
  let isosResaltados = new Set();
  let isosSeleccionados = new Set();
  let colorSeleccionado = COLOR_PAIS;

  function aclararColor(color, factor = 0.2) {
    let r = 0,
      g = 0,
      b = 0;
    if (color.startsWith("#")) {
      const n = parseInt(color.replace("#", ""), 16);
      r = (n >> 16) & 255;
      g = (n >> 8) & 255;
      b = n & 255;
    } else {
      const m = color.match(/[\d.]+/g);
      if (!m || m.length < 3) return color;
      r = Number(m[0]);
      g = Number(m[1]);
      b = Number(m[2]);
    }
    return `rgb(${Math.round(r + (255 - r) * factor)}, ${Math.round(
      g + (255 - g) * factor,
    )}, ${Math.round(b + (255 - b) * factor)})`;
  }

  function colorBase(d) {
    const iso = d.properties.iso;
    if (isosResaltados.has(iso)) return COLOR_RESALTADO;
    if (isosSeleccionados.size > 0) {
      return isosSeleccionados.has(iso) ? colorSeleccionado : COLOR_OSCURO;
    }
    return isosDestacados.has(iso) ? COLOR_PAIS : COLOR_OSCURO;
  }

  function colorPoligono(d) {
    return d === paisSobrevolado ? aclararColor(colorBase(d)) : colorBase(d);
  }

  function colorBordePoligono(d) {
    return d === paisSobrevolado ? COLOR_OCEANO : COLOR_OCEANO;
  }

  function altitudPoligono(d) {
    return d === paisSobrevolado
      ? ALTURA_BASE + (opciones.alturaHover ?? 0.0035)
      : ALTURA_BASE;
  }

  const mundo = Globe({
    rendererConfig: { antialias: opciones.antialias ?? false },
  })
    .showAtmosphere(true)
    .atmosphereColor(COLOR_OCEANO)
    .atmosphereAltitude(0.12)
    .showGraticules(false)
    .polygonsTransitionDuration(250)
    .polygonAltitude(altitudPoligono)
    .polygonCapColor(colorPoligono)
    .polygonSideColor(() => "#eff3f8")
    .polygonStrokeColor(colorBordePoligono)
    .polygonLabel(({ properties: d }) => `<b>${d.nameES}</b>`)
    .onPolygonHover((poligono) => {
      paisSobrevolado = poligono || null;
      mundo.polygonCapColor(colorPoligono);
      mundo.polygonStrokeColor(colorBordePoligono);
      mundo.polygonAltitude(altitudPoligono);
    })
    .onPolygonClick((poligono) => {
      if (poligono && opciones.onPaisClick) {
        opciones.onPaisClick(poligono.properties);
      }
    })(contenedor);

  mundo.globeMaterial().color.set(COLOR_OCEANO);

  // Iluminación más clara: refuerza la luz ambiental y suaviza la direccional
  mundo.lights().forEach((luz) => {
    if (luz.type === "AmbientLight") {
      luz.intensity = opciones.intensidadLuzAmbiental ?? 5;
    } else if (luz.type === "DirectionalLight") {
      luz.intensity = opciones.intensidadLuzDireccional ?? 0;
    }
  });

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

  // El globo deja de girar en cuanto el usuario lo toca (clic o arrastre)
  contenedor.addEventListener("pointerdown", () => {
    mundo.controls().autoRotate = false;
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

  function seleccionarIsos(isos, color) {
    isosSeleccionados = new Set(isos || []);
    colorSeleccionado = color || COLOR_PAIS;
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
    seleccionarIsos,
    focoEn,
    toggleRotacion,
    sincronizarBoton,
    destruir,
  };
};
