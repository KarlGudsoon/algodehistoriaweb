// js/services/articuloService.js

async function obtenerResultadoCuestionario(articuloSlug) {
  const res = await fetch(
    `/api/articulos/obtener_progreso.php?articulo_slug=${encodeURIComponent(articuloSlug)}`,
    {
      credentials: "include",
    },
  );
  if (res.status === 401) throw new Error("No autenticado");
  const data = await res.json();
  if (!res.ok) throw new Error(data.error || "Error al obtener el resultado");
  // El backend responde { resultado: {...} | null }
  return data.resultado ?? null;
}
