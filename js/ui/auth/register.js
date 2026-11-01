const registerForm = document.getElementById("registerForm");
const registerBtn = document.getElementById("btn-register");

const nameInputRegister = document.getElementById("nameRegister");
const emailInputRegister = document.getElementById("emailRegister");
const passwordInputRegister = document.getElementById("passwordRegister");

registerForm.addEventListener("submit", async (e) => {
  e.preventDefault();

  // Obtener los datos del formulario
  const name = nameInputRegister.value.trim();
  const email = emailInputRegister.value.trim();
  const password = passwordInputRegister.value;

  // Limpiar errores anteriores
  errorBox.textContent = "";
  errorBox.classList.add("hidden");

  // Validar campos
  if (!name || !email || !password) {
    showError("Por favor, completa todos los campos.");
    return;
  }

  // Validar correo electrónico
  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

  if (!emailRegex.test(email)) {
    showError("Introduce un correo electrónico válido.");
    return;
  }

  // Validar longitud de contraseña
  if (password.length < 8) {
    showError("La contraseña debe tener al menos 8 caracteres.");
    return;
  }

  // Activar estado de carga
  setLoading(registerBtn, true, "Registrando...", "Registrarse");

  try {
    // Registrar usuario
    await register(email, password, name);

    // Redirigir después del registro
    window.location.assign("/dashboard");
  } catch (error) {
    console.error("Error durante el registro:", error);

    showError(
      error?.message ||
        "No se pudo completar el registro. Inténtalo nuevamente.",
    );
  } finally {
    setLoading(false);
  }
});
