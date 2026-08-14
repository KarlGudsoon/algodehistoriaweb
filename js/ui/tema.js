(function () {
  "use strict";

  var clave = "tema";

  function temaInicial() {
    var guardado = localStorage.getItem(clave);
    if (guardado === "dark" || guardado === "light") return guardado;
    return window.matchMedia("(prefers-color-scheme: dark)").matches
      ? "dark"
      : "light";
  }

  function aplicar(tema) {
    document.documentElement.dataset.theme = tema;
    document.querySelectorAll("[data-tema-boton]").forEach(function (btn) {
      btn.classList.toggle("tema-oscuro", tema === "dark");
      btn.setAttribute(
        "aria-label",
        tema === "dark" ? "Activar modo claro" : "Activar modo oscuro",
      );
    });
  }

  aplicar(temaInicial());

  document.addEventListener("click", function (e) {
    var btn = e.target.closest("[data-tema-boton]");
    if (!btn) return;
    var nuevo =
      document.documentElement.dataset.theme === "dark" ? "light" : "dark";
    localStorage.setItem(clave, nuevo);
    aplicar(nuevo);
  });
})();
