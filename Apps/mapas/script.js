document.addEventListener("DOMContentLoaded", () => {
  fetch("mapas-interactivos.json")
    .then((response) => response.json())
    .then((data) => {
      renderizarMapas(data);
      agregarEventosDeClic(data);

      // Seleccionar un mapa aleatorio al inicio
      const mapaAleatorio = data[Math.floor(Math.random() * data.length)];
      actualizarMapaSeleccionado(mapaAleatorio);

      // Marcarlo como activo
      document
        .querySelector(`.mapa[data-id="${mapaAleatorio.id}"]`)
        .classList.add("active");
    })
    .catch((error) => console.error("Error cargando JSON:", error));
});

function renderizarMapas(mapas) {
  const contenedorMapas = document.querySelector(
    ".contenedor-mapas-interactivos",
  );
  contenedorMapas.innerHTML = "";

  mapas.forEach((mapa) => {
    let divMapa = document.createElement("div");
    divMapa.classList.add("mapa");
    divMapa.setAttribute("data-id", mapa.id);

    divMapa.innerHTML = `
        <img src="${mapa.imagen}" alt="${mapa.titulo}">
        <div class="mapa-texto">
          <span class="${mapa.clasePeriodo}">${mapa.periodo}</span>
          <h1>${mapa.titulo}</h1>
          <p>${mapa.descripcion}</p>
        </div>
      `;

    contenedorMapas.appendChild(divMapa);
  });
}

function agregarEventosDeClic(mapas) {
  document.querySelectorAll(".mapa").forEach((mapaElement) => {
    mapaElement.addEventListener("click", () => {
      const mapaId = mapaElement.getAttribute("data-id");
      const mapaSeleccionado = mapas.find((mapa) => mapa.id === mapaId);

      document
        .querySelectorAll(".mapa")
        .forEach((m) => m.classList.remove("active"));

      if (mapaSeleccionado) {
        actualizarMapaSeleccionado(mapaSeleccionado);
        mapaElement.classList.add("active");
      }
    });
  });
}

function actualizarMapaSeleccionado(mapa) {
  document.getElementById("mapa").src = mapa.srcMapa;
}

var abrirMapa = document.getElementById("abrir-menu");

abrirMapa.addEventListener("click", () => {
  const menu = document.getElementById("menu-mapa");

  menu.classList.add("active");
});

var cerrarMapa = document.getElementById("cerrar-menu");

cerrarMapa.addEventListener("click", () => {
  const menu = document.getElementById("menu-mapa");

  menu.classList.remove("active");
});
