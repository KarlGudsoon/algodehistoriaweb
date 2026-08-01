let catalogoPaisesActual = {};
let modoTerritorioActivo = false;

async function inicializarPaises() {
  try {
    const datos = await obtenerColeccionDashboard();
    const catalogo = await fetch("/api/paises/catalogo.php").then((r) =>
      r.json(),
    );

    catalogoPaisesActual = catalogo;

    const obtenidos = new Set((datos.paises || []).map((p) => p.pais_slug));
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
      colorFondo: "rgba(0 0 0 / 0)",
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
