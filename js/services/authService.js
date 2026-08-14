window.csrfToken = null;

async function register(email, password, name) {
  const res = await fetch("/api/auth/registro.php", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    credentials: "include",
    body: JSON.stringify({ email, password, name }),
  });

  const data = await res.json();
  if (!res.ok) throw new Error(data.error || "Ocurrió un error al registrarse");
  if (data.csrf_token) window.csrfToken = data.csrf_token;
  return data;
}

async function login(email, password) {
  const res = await fetch("/api/auth/login.php", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    credentials: "include",
    body: JSON.stringify({ email, password }),
  });

  const data = await res.json();
  if (!res.ok) throw new Error(data.error || "Error al iniciar sesión");
  if (data.csrf_token) window.csrfToken = data.csrf_token;
  return data;
}

async function logout() {
  await fetch("/api/auth/logout.php", {
    method: "POST",
    credentials: "include",
  });
  window.csrfToken = null;
  window.location.href = "/";
}

async function checkSession() {
  try {
    const res = await fetch("/api/auth/me.php", { credentials: "include" });
    if (!res.ok) return null;
    const data = await res.json();
    if (data.csrf_token) window.csrfToken = data.csrf_token;
    return data.user;
  } catch {
    return null;
  }
}
