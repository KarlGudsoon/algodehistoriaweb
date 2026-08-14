# Cómo crear mapas históricos para el Globo 3D

Estos scripts convierten entre un **SVG editable** y el **GeoJSON** que usa el globo
(`src/3D/globo3d.html`). Con ellos puedes dibujar a mano las fronteras de cualquier
año y cargarlas en el globo con un selector.

## Flujo resumido

1. Abre `src/assets/maps/mapa-base.svg` en Illustrator.
2. Modifica las fronteras (une o divide países) para el año que quieras.
3. Guarda como `src/assets/maps/mapa-1914.svg`.
4. Convierte a GeoJSON (comando abajo).
5. Añade el mapa al selector en `src/data/mapas/index.json`.
6. Recarga el globo y elige "1914" en el selector (o abre `globo3d.html?mapa=1914`).

## Paso a paso en Illustrator

### Abrir el mapa base
- **Archivo → Abrir** → selecciona `src/assets/maps/mapa-base.svg`.
- Cada país es un trazo/objeto con nombre (el nombre del país en español).

### Editar fronteras
- Mueve nodos con la **Herramienta de selección directa** (A) para redibujar bordes.
- No borres los países: mejor **elimina el relleno** y únelos con el vecino si
  quieres que desaparezcan en ese año.

### Fusionar países en un imperio (2 opciones)
- **Opción A (recomendada): mismo nombre.** Selecciona varios países y asígnales el
  mismo **nombre de capa** (doble clic en el nombre en el panel Capas). Todos pasan a
  ser una sola entidad al convertir. Es reversible.
- **Opción B (unir geometría):** selecciónalos y en el panel **Buscador de formas →
  Unir**. El resultado es un solo objeto. Ojo: la unión es permanente.

### Nombre de cada entidad
- El nombre de la capa es lo que aparece como **nombre en español** en el globo y en
  el tooltip al pasar el mouse. Pónselo siempre (ej. "Imperio Otomano", "1914").

### Guardar
- **Archivo → Guardar como** → formato **SVG**.
- En las opciones de SVG: perfil **SVG 1.1**, y en "Avanzadas" elige
  **atributos de presentación**.
- IMPORTANTE: **no cambies el tamaño del lienzo** (ancho 1009.67 × alto 665.96).
  Si el lienzo cambia, el mapa se deforma al convertirlo.

## Convertir el SVG a GeoJSON

Abre una terminal en la raíz del proyecto y ejecuta:

```
node src/assets/maps/herramientas/svg_a_geojson.js src/assets/maps/mapa-1914.svg src/data/mapas/1914.geojson
```

Si todo va bien verás algo como:

```
features: 121
coordenadas inválidas: 0
```

## Añadir el mapa al globo

Edita `src/data/mapas/index.json` y agrega una entrada (después de la del mapa
actual, añade una coma):

```json
{
  "id": "1914",
  "archivo": "mapas/1914.geojson",
  "etiqueta": "1914"
}
```

- `id`: valor corto único (también sirve para la URL `?mapa=1914`).
- `archivo`: ruta relativa a `src/data/` donde guardaste el GeoJSON.
- `etiqueta`: lo que verás en el selector.

## Si algo sale mal

- **"coordenadas inválidas" o países deformados**: revisa que no cambiaste el tamaño
  del lienzo al guardar.
- **Un país no se ve o está en el lugar equivocado**: revisa que el nombre de la capa
  no tenga caracteres raros (como `*` o `&`) y que el objeto sea un trazo con datos
  de vértices (no una imagen).
- **Varios países aparecen como uno solo**: tienen el mismo nombre de capa; cámbialo.

## Bonus: regenerar el mapa base

Si quieres volver a generar `mapa-base.svg` desde el GeoJSON actual:

```
node src/assets/maps/herramientas/geojson_a_svg.js
```

Esto sirve para empezar de cero si editaste mucho el archivo base y quieres
recuperar el original.
