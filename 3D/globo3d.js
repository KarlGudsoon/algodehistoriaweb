// js/3D/globo3d.js — Página standalone del Globo 3D
// El globo reutilizable vive en /js/3D/crearGlobo.js

const globo = crearGlobo(document.getElementById("globoViz"), {
  alturaBase: 0.007,
  antialias: false,
  focoInicial: { lat: -25, lng: -70, altitude: 2.4 },
});

// Botón para activar/desactivar la rotación automática
const botonRotacion = document.getElementById("botonRotacion");

botonRotacion.addEventListener("click", () => {
  globo.toggleRotacion();
  globo.sincronizarBoton(botonRotacion);
});

// Cargar mapas disponibles y aplicar el elegido (por URL ?mapa= o por selector)
const selectorMapa = document.getElementById("selectorMapa");
const mapaPorUrl = new URLSearchParams(location.search).get("mapa");

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
      if (elegido) globo.cargarMapa(elegido.archivo);
    });
    globo.cargarMapa(inicial.archivo);
  })
  .catch((error) => {
    console.error("Error al cargar la lista de mapas:", error);
  });
