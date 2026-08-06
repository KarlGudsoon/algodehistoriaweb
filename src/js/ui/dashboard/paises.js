let catalogoPaisesActual = {};
let modoTerritorioActivo = false;

async function inicializarPaises() {
  try {
    const datosColeccion = await obtenerColeccionPaises();

    const catalogo = await fetch("/api/paises/catalogo.php").then((r) =>
      r.json(),
    );

    catalogoPaisesActual = catalogo;

    renderizarResumenProgresoPaises(datosColeccion);
    renderizarListaPaises(datosColeccion, catalogo);

    const datos = datosColeccion.coleccion || [];

    const obtenidos = new Set((datos || []).map((p) => p.pais_slug));
    const isosObtenidos = new Set();
    const mapIsoEvoluciones = new Map();

    Object.entries(catalogo).forEach(([slug, pais]) => {
      const central = pais.territorioCentral;
      if (!central || !obtenidos.has(slug)) return;
      isosObtenidos.add(central);
      if (!mapIsoEvoluciones.has(central)) mapIsoEvoluciones.set(central, []);
      mapIsoEvoluciones.get(central).push(slug);
    });

    mapIsoEvoluciones.forEach((slugs) => {
      slugs.sort(
        (a, b) =>
          (catalogo[a].anioInicio ?? Infinity) -
          (catalogo[b].anioInicio ?? Infinity),
      );
    });

    const contenedor = document.getElementById("globoPaises");
    if (!contenedor) return;

    const globo = crearGlobo(contenedor, {
      antialias: false,
      alturaBase: 0.007,
      colorFondo: "rgba(255 255 255 / 1)",
      isosDestacados: isosObtenidos,
      focoInicial: { lat: -25, lng: -70, altitude: 2.4 },
      onPaisClick: (props) => {
        const lista = mapIsoEvoluciones.get(props.iso) || [];
        if (lista.length) {
          abrirCapsulaConEvoluciones(lista, lista.length - 1);
        }
      },
    });

    window.onCapsulaPaisAbierta = (pais) => {
      globo.focoEn(pais.foco);
      globo.seleccionarIsos(pais.territorios || [], pais.colorFondo);
      if (modoTerritorioActivo) {
        globo.resaltarIsos(pais.territorios);
      } else {
        globo.resaltarIsos([]);
      }
    };

    window.onMostrarTerritorios = (pais) => {
      modoTerritorioActivo = !modoTerritorioActivo;
      if (modoTerritorioActivo) {
        globo.resaltarIsos(pais.territorios);
      } else {
        globo.resaltarIsos([]);
      }
    };

    window.onCapsulaPaisCerrada = () => {
      modoTerritorioActivo = false;
      globo.seleccionarIsos([]);
      globo.resaltarIsos([]);
    };

    globo.cargarMapa("countries.geojson");

    if (typeof inicializarCapsulaPais === "function") {
      await inicializarCapsulaPais();
    }
  } catch (error) {
    console.error("Error al cargar la vista de países:", error);
  }
}

async function renderizarResumenProgresoPaises(datosColeccion) {
  try {
    const contenedor = document.getElementById("resumenProgresoPaises");

    el("paisesObtenidos", datosColeccion.cantidad);
    el("paisesTotales", datosColeccion.total);

    contenedor.querySelectorAll(".infocards").forEach((card) => {
      card.classList.remove("skeleton");
    });
  } catch (error) {
    console.error(
      "Error al renderizar el resumen de progreso de países:",
      error,
    );
  }
}

async function renderizarListaPaises(datosColeccion, catalogo) {
  try {
    const contenedor = document.querySelector(".contenedor-lista-paises");
    const listaPaises = document.getElementById("listaPaises");
    if (!listaPaises) return;

    const datos = datosColeccion.coleccion || [];

    const obtenidos = new Set((datos || []).map((p) => p.pais_slug));

    const entradas = Object.entries(catalogo).sort(([a, x], [b, y]) => {
      const ax = obtenidos.has(a) ? 0 : 1;
      const bx = obtenidos.has(b) ? 0 : 1;
      return ax - bx || (x.anioInicio ?? Infinity) - (y.anioInicio ?? Infinity);
    });

    listaPaises.innerHTML = "";

    entradas.forEach(([slug, pais]) => {
      const estaObtenido = obtenidos.has(slug);
      const item = document.createElement("li");
      const nombre = document.createElement("span");
      const icono = document.createElement("span");

      nombre.textContent = pais.nombre;
      icono.textContent = "🌍";
      item.appendChild(nombre);
      item.appendChild(icono);
      item.className = "pais-item";
      if (estaObtenido) {
        item.classList.add("obtenido");
        icono.textContent = "Descubierto";
        item.addEventListener("click", () => abrirCapsulaPais(slug));
      } else {
        item.classList.add("no-obtenido");
        icono.textContent = "Bloqueado";
        item.setAttribute("aria-disabled", "true");
      }

      item.dataset.busqueda = pais.nombre.toLowerCase();
      listaPaises.appendChild(item);
    });

    contenedor.querySelectorAll("*").forEach((card) => {
      card.classList.remove("skeleton");
    });

    const buscador = document.getElementById("buscadorPaises");
    if (buscador) {
      buscador.addEventListener("input", () => {
        const termino = buscador.value.trim().toLowerCase();
        listaPaises.querySelectorAll(".pais-item").forEach((item) => {
          item.style.display =
            termino && !item.dataset.busqueda.includes(termino) ? "none" : "";
        });
      });
    }
  } catch (error) {
    console.error(
      "Error al renderizar el resumen de progreso de países:",
      error,
    );
  }
}
