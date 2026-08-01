(function () {
  "use strict";

  let catalogoPaises = null;
  let fechaInicio = null;
  let fechaTermino = null;
  let economiaPais = null;
  let politicaPais = null;
  let territorioPais = null;

  if (typeof window.sonidoSeleccion !== "function") {
    window.sonidoSeleccion = function () {
      let sonido = new Audio("/audio/seleccion2.mp3");
      sonido.volume = 0.3;
      sonido.preload = "auto";
      sonido.play();
    };
  }

  async function cargarCatalogoPaises() {
    if (catalogoPaises) return catalogoPaises;
    try {
      const res = await fetch("/api/paises/catalogo.php");
      catalogoPaises = await res.json();
      return catalogoPaises;
    } catch (error) {
      console.error("Error al cargar el catálogo de países:", error);
      return {};
    }
  }

  function crearTippyInstancias() {
    [fechaInicio, fechaTermino, economiaPais, politicaPais, territorioPais].forEach(
      (instancia) => {
        if (instancia) {
          instancia[0] && instancia[0].destroy();
        }
      },
    );

    const existeElemento = (id) => document.getElementById(id);

    fechaInicio = existeElemento("capsula-pais-fecha-inicio")
      ? tippy("#capsula-pais-fecha-inicio", {
          allowHTML: true,
          interactive: true,
          theme: "basico",
          placement: "top",
          appendTo: document.body,
          zIndex: 99999999999,
        })
      : null;
    fechaTermino = existeElemento("capsula-pais-fecha-termino")
      ? tippy("#capsula-pais-fecha-termino", {
          allowHTML: true,
          interactive: true,
          theme: "basico",
          placement: "top",
          appendTo: document.body,
          zIndex: 99999999999,
        })
      : null;

    economiaPais = existeElemento("capsula-economia-pais")
      ? tippy("#capsula-economia-pais", {
          allowHTML: true,
          interactive: false,
          theme: "basico",
          placement: "top",
          appendTo: document.body,
          zIndex: 99999999999,
        })
      : null;

    politicaPais = existeElemento("capsula-gobierno-pais")
      ? tippy("#capsula-gobierno-pais", {
          allowHTML: true,
          interactive: false,
          theme: "basico",
          placement: "top",
          appendTo: document.body,
          zIndex: 99999999999,
        })
      : null;

    territorioPais = existeElemento("capsula-territorio-pais")
      ? tippy("#capsula-territorio-pais", {
          allowHTML: true,
          interactive: false,
          theme: "basico",
          placement: "top",
          appendTo: document.body,
          zIndex: 99999999999,
        })
      : null;
  }

  function cargarPaises(paises) {
    document.querySelectorAll(".paises").forEach((elemento) => {
      if (elemento.dataset.capsulaPaisBindeado === "true") return;
      elemento.dataset.capsulaPaisBindeado = "true";

      elemento.addEventListener("click", () => {
        const idPais = elemento.getAttribute("data-pais");

        if (paises[idPais]) {
          mostrarSkeletonPais();
          actualizarPais(paises[idPais], idPais);
          document
            .querySelector(".contenedor-capsula-pais")
            .classList.add("active");
          document.querySelector(".capsula-pais").classList.add("active");
          vincularSkeletonImagenes();
          sonidoSeleccion();
        } else {
          console.error("Pais no encontrado en catálogo:", idPais);
        }
      });
    });
  }

  function actualizarPais(pais, idPais) {
    document.querySelector(".capsula-pais").style.backgroundColor =
      pais.colorFondo || "rgba(105, 105, 105, 0.562)";
    document.getElementById("capsula-pais-nombre").textContent = pais.nombre;
    document.getElementById("capsula-pais-descripcion").textContent =
      pais.descripcion;

    let etiqueta = document.getElementById("capsula-pais-etiqueta");
    etiqueta.className = "";
    etiqueta.textContent = pais.etiqueta[0];
    etiqueta.classList.add(pais.etiqueta[1]);

    document.getElementById("capsula-pais-fecha-inicio").textContent =
      pais.tiempo[0];
    document.getElementById("capsula-pais-fecha-termino").textContent =
      pais.tiempo[1];

    const economia = document.getElementById("capsula-economia-pais");
    const gobierno = document.getElementById("capsula-gobierno-pais");
    const territorio = document.getElementById("capsula-territorio-pais");

    economia.textContent = pais.economia;
    gobierno.textContent = pais.politica;
    territorio.textContent = pais.territorio;

    if (pais.economia.trim().split(/\s+/).length < 12) {
      economiaPais[0].disable();
    } else {
      economiaPais[0].enable();
      economiaPais[0].setContent(pais.economia);
    }

    if (pais.politica.trim().split(/\s+/).length < 12) {
      politicaPais[0].disable();
    } else {
      politicaPais[0].enable();
      politicaPais[0].setContent(pais.politica);
    }

    if (pais.territorio.trim().split(/\s+/).length < 12) {
      territorioPais[0].disable();
    } else {
      territorioPais[0].enable();
      territorioPais[0].setContent(pais.territorio);
    }

    document.querySelectorAll(".caracteristicas-pais li span").forEach((span) => {
      if (span.textContent.trim().split(/\s+/).length > 12) {
        span.textContent =
          span.textContent.trim().split(" ").slice(0, 10).join(" ") + "…";
      }
    });

    let bandera = document.getElementById("capsula-pais-bandera");
    bandera.src = pais.bandera;
    bandera.alt = `Bandera de ${pais.nombre}`;

    document.getElementById("capsula-pais-fondo").src = pais.fondo;
    document.getElementById("capsula-pais-personaje").src = pais.personaje;

    document
      .querySelectorAll(".logros-pais li")
      .forEach(
        (li) =>
          (li.style.backgroundColor =
            pais.colorFondo || "rgba(105, 105, 105, 0.562)"),
      );
    document
      .querySelector("#logros-pais-1")
      .setAttribute("data-logro-pais-exp", pais.logro1[0]);
    document
      .querySelector("#logros-pais-2")
      .setAttribute("data-logro-pais-exp", pais.logro2[0]);
    document
      .querySelector("#logros-pais-3")
      .setAttribute("data-logro-pais-exp", pais.logro3[0]);
    document.querySelector("#logros-pais-1 img").src = pais.logro1[1];
    document.querySelector("#logros-pais-2 img").src = pais.logro2[1];
    document.querySelector("#logros-pais-3 img").src = pais.logro3[1];
    document.querySelector("#capsula-pais-img1").src = pais.logro1[2];
    document.querySelector("#capsula-pais-img2").src = pais.logro2[2];
    document.querySelector("#capsula-pais-img3").src = pais.logro3[2];

    fechaInicio[0].setContent(
      pais.acontecimientos ? pais.acontecimientos[0] : "Sin información",
    );
    fechaTermino[0].setContent(
      pais.acontecimientos ? pais.acontecimientos[1] : "Sin información",
    );

    quitarSkeletonTextos();
  }

  function vincularHoverLogros() {
    document.querySelectorAll(".logros-pais li").forEach((li) => {
      if (li.dataset.capsulaHoverBindeado === "true") return;
      li.dataset.capsulaHoverBindeado = "true";

      li.addEventListener("mouseenter", () => {
        let logro = li.getAttribute("data-logro-pais");
        let logroExp = li.getAttribute("data-logro-pais-exp");
        let imgLogro = document.querySelector(
          `.capsula-pais-img img[data-logro-pais="${logro}"]`,
        );
        let imgFondo = document.getElementById("capsula-pais-fondo");
        let logrosExp = document.getElementById("capsula-pais-logros-exp");
        logrosExp.textContent = logroExp;
        logrosExp.style.opacity = "1";

        if (imgLogro) {
          imgLogro.classList.add("active");
          imgFondo.style.opacity = "0";
        }
      });

      li.addEventListener("mouseleave", () => {
        let logro = li.getAttribute("data-logro-pais");
        let imgLogro = document.querySelector(
          `.capsula-pais-img img[data-logro-pais="${logro}"]`,
        );
        let imgFondo = document.getElementById("capsula-pais-fondo");
        let logrosExp = document.getElementById("capsula-pais-logros-exp");
        logrosExp.style.opacity = "0";

        if (imgLogro) {
          imgLogro.classList.remove("active");
          imgFondo.style.opacity = "1";
        }
      });
    });
  }

  function vincularCierre() {
    const botonCerrar = document.getElementById("capsula-pais-cerrar");
    if (botonCerrar && botonCerrar.dataset.capsulaCerrarBindeado !== "true") {
      botonCerrar.dataset.capsulaCerrarBindeado = "true";
      botonCerrar.addEventListener("click", () => {
        document
          .querySelector(".contenedor-capsula-pais")
          .classList.remove("active");
        document.querySelector(".capsula-pais").classList.remove("active");
        sonidoSeleccion();
      });
    }

    const contenedor = document.querySelector(".contenedor-capsula-pais");
    if (contenedor && contenedor.dataset.capsulaFondoBindeado !== "true") {
      contenedor.dataset.capsulaFondoBindeado = "true";
      contenedor.addEventListener("click", function (e) {
        if (e.target === this) {
          this.classList.remove("active");
          document.querySelector(".capsula-pais").classList.remove("active");
          sonidoSeleccion();
        }
      });
    }
  }

  function mostrarSkeletonPais() {
    document
      .querySelectorAll(
        "#capsula-pais-nombre, #capsula-pais-descripcion, #capsula-pais-etiqueta, #capsula-pais-fecha-inicio, #capsula-pais-fecha-termino, #capsula-economia-pais, #capsula-gobierno-pais, #capsula-territorio-pais, #capsula-pais-bandera, #capsula-pais-fondo, #capsula-pais-personaje, #logros-pais-1 img, #logros-pais-2 img, #logros-pais-3 img",
      )
      .forEach((el) => el.classList.add("skeleton"));
  }

  function quitarSkeletonTextos() {
    document
      .querySelectorAll(
        "#capsula-pais-nombre, #capsula-pais-descripcion, #capsula-pais-etiqueta, #capsula-pais-fecha-inicio, #capsula-pais-fecha-termino, #capsula-economia-pais, #capsula-gobierno-pais, #capsula-territorio-pais",
      )
      .forEach((el) => el.classList.remove("skeleton"));
  }

  function vincularSkeletonImagenes() {
    document.querySelectorAll(".capsula-pais img.skeleton").forEach((img) => {
      const quitar = () => img.classList.remove("skeleton");
      if (img.complete) {
        quitar();
      } else {
        img.addEventListener("load", quitar, { once: true });
        img.addEventListener("error", quitar, { once: true });
      }
    });
  }

  async function inicializarCapsulaPais() {
    const catalogo = await cargarCatalogoPaises();
    cargarPaises(catalogo);
    crearTippyInstancias();
    vincularHoverLogros();
    vincularCierre();
  }

  window.inicializarCapsulaPais = inicializarCapsulaPais;

  document.addEventListener("DOMContentLoaded", inicializarCapsulaPais);
})();
