// js/services/dashboardService.js
async function obtenerDatosUsuario() {
  const res = await fetch("/api/auth/me.php", {
    credentials: "include",
  });
  if (res.status === 401) throw new Error("No autenticado");
  const data = await res.json();
  if (!res.ok) throw new Error(data.error || "Error al obtener estadísticas");
  return data.user;
}

async function obtenerNivelUsuario() {
  const res = await fetch("/api/dashboard/nivel.php", {
    credentials: "include",
  });
  if (res.status === 401) throw new Error("No autenticado");
  const data = await res.json();
  if (!res.ok) throw new Error(data.error || "Error al obtener el nivel");
  return data;
}

async function obtenerEstadisticasDashboard() {
  const res = await fetch("/api/dashboard/estadisticas.php", {
    credentials: "include",
  });
  if (res.status === 401) throw new Error("No autenticado");
  const data = await res.json();
  if (!res.ok) throw new Error(data.error || "Error al obtener estadísticas");
  return data;
}

async function obtenerColeccionDashboard() {
  const res = await fetch("/api/dashboard/coleccion.php", {
    credentials: "include",
  });
  if (res.status === 401) throw new Error("No autenticado");
  const data = await res.json();
  if (!res.ok) throw new Error(data.error || "Error al obtener colección");
  return data;
}

async function obtenerPerfilDashboard() {
  const res = await fetch("/api/dashboard/perfil.php", {
    credentials: "include",
  });
  if (res.status === 401) throw new Error("No autenticado");
  const data = await res.json();
  if (!res.ok) throw new Error(data.error || "Error al obtener perfil");
  return data.usuario;
}

async function obtenerCatalogoCartas() {
  const res = await fetch("/api/cartas/catalogo.php", {
    credentials: "include",
  });
  const data = await res.json();
  if (!res.ok) throw new Error(data.error || "Error al obtener catálogo");
  return data;
}

async function obtenerCartaDestacada() {
  const res = await fetch("/api/dashboard/carta_destacada.php", {
    credentials: "include",
  });
  if (res.status === 401) throw new Error("No autenticado");
  const data = await res.json();
  if (!res.ok)
    throw new Error(data.error || "Error al obtener carta destacada");
  return data.carta;
}

async function obtenerArticulosCompletados() {
  const res = await fetch("/api/dashboard/articulos_completados.php", {
    credentials: "include",
  });
  if (res.status === 401) throw new Error("No autenticado");
  const data = await res.json();
  if (!res.ok)
    throw new Error(data.error || "Error al obtener artículos completados");
  return data.completados;
}
