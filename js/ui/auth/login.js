// Inicio de sesión

const loginForm = document.getElementById("loginForm");
const emailInput = document.getElementById("emailLogin");
const passwordInput = document.getElementById("passwordLogin");
const errorBox = document.getElementById("errorMessage");
const loginBtn = document.getElementById("loginBtn");

const authButtons = document.querySelectorAll(".btn-auth");

authButtons.forEach((button) => {
  button.addEventListener("click", () => {
    const view = button.dataset.view;

    // Comprobar que la vista sea válida
    if (view !== "login" && view !== "register") return;

    // Actualizar botones
    authButtons.forEach((btn) => {
      const isActive = btn === button;

      btn.classList.toggle("active", isActive);
      btn.setAttribute("aria-selected", String(isActive));
    });

    // Mostrar el formulario correspondiente
    loginForm.classList.toggle("hidden", view !== "login");
    registerForm.classList.toggle("hidden", view !== "register");
  });
});

loginForm.addEventListener("submit", async (e) => {
  e.preventDefault();

  // Obtener y limpiar los datos
  const email = emailInput.value.trim();
  const password = passwordInput.value;

  // Ocultar errores anteriores
  errorBox.textContent = "";
  errorBox.classList.add("hidden");

  // Validar campos
  if (!email || !password) {
    showError("Por favor, completa todos los campos.");
    return;
  }

  // Validar formato del correo
  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

  if (!emailRegex.test(email)) {
    showError("Introduce un correo electrónico válido.");
    return;
  }

  // Deshabilitar botón durante el proceso
  setLoading(true);

  try {
    // Intentar iniciar sesión
    await login(email, password);

    // Redirigir si la autenticación es correcta
    window.location.assign("/dashboard/");
  } catch (error) {
    // Mostrar mensaje de error
    showError(
      error?.message || "No se pudo iniciar sesión. Inténtalo nuevamente.",
    );
  } finally {
    // Restaurar botón si seguimos en esta página
    setLoading(false);
  }
});

// Mostrar mensajes de error
function showError(message) {
  errorBox.textContent = message;
  errorBox.classList.remove("hidden");
}

// Controlar estado del botón
function setLoading(loading) {
  loginBtn.disabled = loading;
  loginBtn.textContent = loading ? "Ingresando..." : "Ingresar";
}

// Registro de usuario
