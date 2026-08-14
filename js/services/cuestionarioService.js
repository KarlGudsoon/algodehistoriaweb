async function obtenerPreguntas(articuloSlug) {
  const res = await fetch(
    `/api/articulos/cuestionario_preguntas.php?articulo_slug=${encodeURIComponent(articuloSlug)}`,
  );
  const data = await res.json();
  if (!res.ok) throw new Error(data.error || "Error al obtener preguntas");
  return data.preguntas;
}

async function corregirCuestionario(articuloSlug, respuestas) {
  const res = await fetch("/api/articulos/cuestionario_corregir.php", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
      "X-CSRF-Token": window.csrfToken || "",
    },
    credentials: "include",
    body: JSON.stringify({ articulo_slug: articuloSlug, respuestas }),
  });
  if (res.status === 401) throw new Error("No autenticado");
  if (res.status === 403) throw new Error("Token CSRF inválido");
  const data = await res.json();
  if (!res.ok) throw new Error(data.error || "Error al corregir");
  return data;
}
