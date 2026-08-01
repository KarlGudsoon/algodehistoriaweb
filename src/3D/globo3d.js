// js/3D/globo3d.js — Globo 3D interactivo con globe.gl (basado en three.js)

const contenedor = document.getElementById("globoViz");

const estilos = getComputedStyle(document.documentElement);
const COLOR_OCEANO = estilos.getPropertyValue("--red").trim() || "#e92a41";
const COLOR_PAIS = estilos.getPropertyValue("--yellow").trim() || "#ffa218";
const COLOR_HOVER = "#ffffff";
const ALTURA_BASE = 0.007;

let paisSobrevolado = null;

const mundo = Globe({
  rendererConfig: { antialias: false },
})
  .showAtmosphere(true)
  .atmosphereColor(COLOR_OCEANO)
  .atmosphereAltitude(0.12)
  .showGraticules(false)
  .polygonAltitude(ALTURA_BASE)
  .polygonCapColor((d) => (d === paisSobrevolado ? COLOR_HOVER : COLOR_PAIS))
  .polygonSideColor(() => "rgba(0, 0, 0, 0)")
  .polygonStrokeColor(() => COLOR_OCEANO)
  .polygonLabel(({ properties: d }) => `<b>${d.nameES}</b>`)
  .onPolygonHover((poligono) => {
    paisSobrevolado = poligono || null;
    mundo.polygonCapColor((d) =>
      d === paisSobrevolado ? COLOR_HOVER : COLOR_PAIS,
    );
  })(contenedor);

mundo.globeMaterial().color.set(COLOR_OCEANO);

// Rotación automática suave cuando no se interactúa
mundo.controls().autoRotate = true;
mundo.controls().autoRotateSpeed = 0.4;
mundo.pointOfView({ lat: -25, lng: -70, altitude: 2.4 }, 0);

// Botón para activar/desactivar la rotación automática
const botonRotacion = document.getElementById("botonRotacion");

function sincronizarBoton() {
  botonRotacion.textContent = mundo.controls().autoRotate
    ? "Detener rotación"
    : "Reanudar rotación";
}

botonRotacion.addEventListener("click", () => {
  const controles = mundo.controls();
  controles.autoRotate = !controles.autoRotate;
  sincronizarBoton();
});

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
    sincronizarBoton();
  }
  puntoInicial = null;
});

// Cargar mapas disponibles y aplicar el elegido (por URL ?mapa= o por selector)
const selectorMapa = document.getElementById("selectorMapa");
const mapaPorUrl = new URLSearchParams(location.search).get("mapa");

function cargarMapa(mapa) {
  fetch("/data/" + mapa.archivo)
    .then((res) => {
      if (!res.ok) throw new Error("No se pudo cargar " + mapa.archivo);
      return res.json();
    })
    .then((geo) => {
      const paises = geo.features.filter(
        (f) => f.properties.iso && f.properties.iso !== "AQ",
      );
      mundo.polygonsData(paises);
    })
    .catch((error) => {
      console.error("Error al cargar el globo:", error);
    });
}

fetch("/data/mapas/index.json")
  .then((res) => res.json())
  .then((lista) => {
    if (!lista.length) throw new Error("No hay mapas en index.json");
    const inicial = lista.find((m) => m.id === mapaPorUrl) || lista[0];
    for (const m of lista) {
      const opcion = document.createElement("option");
      opcion.value = m.id;
      opcion.textContent = m.etiqueta;
      if (m.id === inicial.id) opcion.selected = true;
      selectorMapa.appendChild(opcion);
    }
    selectorMapa.addEventListener("change", () => {
      const elegido = lista.find((m) => m.id === selectorMapa.value);
      if (elegido) cargarMapa(elegido);
    });
    cargarMapa(inicial);
  })
  .catch((error) => {
    console.error("Error al cargar la lista de mapas:", error);
  });
