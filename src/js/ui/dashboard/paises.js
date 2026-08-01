let catalogoPaisesActual = {};

async function inicializarPaises() {
  try {
    const datos = await obtenerColeccionDashboard();
    const catalogo = await fetch("/api/paises/catalogo.php").then((r) =>
      r.json(),
    );

    catalogoPaisesActual = catalogo;
    renderizarListaPaises(datos.paises, catalogo);

    if (typeof inicializarCapsulaPais === "function") {
      inicializarCapsulaPais();
    }
  } catch (error) {
    console.error("Error al cargar la vista de países:", error);
  }
}

function renderizarListaPaises(paisesUsuario, catalogo) {
  const contenedor = document.getElementById("listaPaises");

  if (Object.keys(catalogo).length === 0) {
    contenedor.innerHTML = `<p class="sin-resultados">No hay países disponibles.</p>`;
    return;
  }

  contenedor.innerHTML = Object.entries(catalogo)
    .map(
      ([slug, pais]) => `
    <h1 class="paises" data-pais="${slug}">
      ${pais.nombre} <img src="/assets/icons/bandera.svg">
    </h1>
  `,
    )
    .join("");
}
