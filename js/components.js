const HEADER_HTML = `
<header>
  <button id="btn-menu-mobile">
    <img src="/assets/icons/menu.svg" alt="Menu" />
  </button>

  <div class="flex-1">
    <img src="/assets/icons/logo.svg" />
  </div>

  <nav class="flex-1">
    <ul>
      <li><a href="/">Inicio</a></li>
      <li><a href="/#articulos">Artículos</a></li>
      <li><a href="/#aplicaciones">Aplicaciones</a></li>
      <li><a href="/#acerca-de">Acerca de</a></li>
    </ul>
  </nav>

  <div class="flex-1 flex justify-end gap-4">
    <button
      data-tema-boton
      type="button"
      aria-label="Activar modo oscuro"
      class="btn-tema"
    >
      <svg
        class="icono-sol"
        xmlns="http://www.w3.org/2000/svg"
        width="1em"
        height="1em"
        viewBox="0 0 24 24"
      >
        <path d="M0 0h24v24H0z" fill="none" />
        <g fill="none">
          <g fill="currentColor" clip-path="url(#SVGHcSWxdhd)">
            <path
              d="M12 20a1 1 0 0 1 1 1v2a1 1 0 1 1-2 0v-2a1 1 0 0 1 1-1m-7.071-2.343a1 1 0 1 1 1.414 1.414l-1.414 1.414a1 1 0 0 1-1.414-1.414zm12.728 0a1 1 0 0 1 1.414 0l1.414 1.414a1 1 0 0 1-1.414 1.414l-1.414-1.414a1 1 0 0 1 0-1.414M12 6a6 6 0 1 1 0 12a6 6 0 0 1 0-12m-9 5a1 1 0 1 1 0 2H1a1 1 0 1 1 0-2zm20 0a1 1 0 1 1 0 2h-2a1 1 0 1 1 0-2zM3.515 3.515a1 1 0 0 1 1.414 0l1.414 1.414a1 1 0 1 1-1.414 1.414L3.515 4.929a1 1 0 0 1 0-1.414m15.556 0a1 1 0 0 1 1.414 1.414l-1.414 1.414a1 1 0 1 1-1.414-1.414zM12 0a1 1 0 0 1 1 1v2a1 1 0 1 1-2 0V1a1 1 0 0 1 1-1"
            />
          </g>
          <defs>
            <clipPath id="SVGHcSWxdhd">
              <path fill="#fff" d="M0 0h24v24H0z" />
            </clipPath>
          </defs>
        </g>
      </svg>

      <svg
        class="icono-luna"
        xmlns="http://www.w3.org/2000/svg"
        width="1em"
        height="1em"
        viewBox="0 0 24 24"
      >
        <path d="M0 0h24v24H0z" fill="none" />
        <path
          fill="currentColor"
          d="M9.272 2.406a1 1 0 0 0-1.23-1.355C6.59 1.535 5.432 2.488 4.37 3.55a11.4 11.4 0 0 0 0 16.182c4.518 4.519 11.51 4.261 15.976-.205c1.062-1.062 2.014-2.22 2.498-3.673A1 1 0 0 0 21.55 14.6c-3.59 1.322-7.675.734-10.433-2.025C8.35 9.808 7.788 5.744 9.272 2.406"
        />
      </svg>
    </button>
    <div id="navUserSection"></div>
  </div>
</header>
`;

const FOOTER_HTML = `
<div class="container-footer-1">
  <div class="footer-container footer-1">
    <div class="contenedor-logo-footer">
      <span><img class="logo" src="/svg/logo.svg" /></span>
    </div>
    <div>
      <a target="_blank" href="https://www.instagram.com/algodehistoria.cl/"
        ><span><img src="/assets/icons/instagram.svg" /></span
      ></a>
      <a target="_blank" href="https://www.youtube.com/@algodehistoriaYT"
        ><span><img src="/assets/icons/mdi--youtube.svg" /></span
      ></a>
      <p>
        Pagina web interactiva para aprender Historia, Geografía y Ciencias
        Sociales
      </p>
    </div>
  </div>
  <div class="footer-container footer-2">
    <h1>Prehistoria</h1>
    <h1>Antiguedad</h1>
    <h1>Medieval</h1>
    <h1>Moderna</h1>
    <h1>Contemporanea</h1>
  </div>
  <div class="footer-container footer-3">
    <span>Artículo recomendado</span>
    <ul>
      <li
        class="card-articulo-recomendado"
        style="--fondo: url(&quot;/img/prehistoria/fondo.webp&quot;)"
      >
        <div class="card-articulo-recomendado-texto">
          <h1>PREHISTORIA</h1>
          <p>
            La prehistoria es el periodo más largo de la historia humana,
            abarcando desde la aparición de los primeros homínidos hasta la
            invención de la escritura.
          </p>
          <button>
            <a href="/Articulos/Prehistoria/template.html">Ver más</a>
          </button>
        </div>
        <div class="card-articulo-recomendado-img">
          <img src="/img/prehistoria/humano.webp" alt="" />
        </div>
      </li>
    </ul>
  </div>
</div>
<div class="container-footer-2">
  <p>
    © <span id="actualYear"></span> Adrián Maturana. Este sitio está licenciado
    bajo
    <a target="_blank" href="https://creativecommons.org/licenses/by-nc-nd/4.0/"
      ><u> CC BY-NC-ND 4.0 (Atribución - No Comercial - Sin Derivadas)</u></a
    >.<br />
    Puedes compartir el contenido con fines educativos y sin modificaciones,
    siempre que menciones al autor y no tenga fines comerciales.<br />
  </p>
</div>
`;

const NAVMOBILE_HTML = `
<div class="menu-mobile">
  <img src="/assets/icons/logo.svg" />
  <ul>
    <li><a href="/">Inicio</a></li>
    <li><a href="#articulos">Articulos</a></li>
    <li><a href="#aplicaciones">Aplicaciones</a></li>
    <li><a href="#acerca-de">Acerca de</a></li>
  </ul>
  <button id="btn-cerrar-menu">
    <img src="/assets/icons/close.svg" alt="" />
  </button>
</div>
`;

class SiteHeader extends HTMLElement {
  connectedCallback() {
    this.innerHTML = HEADER_HTML;
    this.initSession();
    this.querySelector("#btn-menu-mobile")?.addEventListener("click", () => {
      document.querySelector(".menu-mobile")?.classList.toggle("active");
    });
  }

  async initSession() {
    const section = this.querySelector("#navUserSection");
    if (!section || typeof checkSession !== "function") return;

    const user = await checkSession();

    if (user) {
      const inicial = user.name.charAt(0).toUpperCase();
      section.innerHTML = `
        <a href="/dashboard" class="avatar">${inicial}</a>
        <button id="logoutBtn">
          <img src="/assets/icons/logout.svg" alt="Cerrar sesión" />
        </button>
      `;
      section.querySelector("#logoutBtn")?.addEventListener("click", logout);
    } else {
      section.innerHTML = `<a href="/auth/">Ingresar</a>`;
    }
  }
}

class SiteFooter extends HTMLElement {
  connectedCallback() {
    this.innerHTML = FOOTER_HTML;
    this.querySelector("#actualYear").textContent = new Date().getFullYear();
  }
}

class SiteMobileNav extends HTMLElement {
  connectedCallback() {
    this.innerHTML = NAVMOBILE_HTML;
    this.querySelector("#btn-cerrar-menu")?.addEventListener("click", () => {
      this.querySelector(".menu-mobile")?.classList.remove("active");
    });
  }
}

customElements.define("site-header", SiteHeader);
customElements.define("site-footer", SiteFooter);
customElements.define("site-mobile-nav", SiteMobileNav);
