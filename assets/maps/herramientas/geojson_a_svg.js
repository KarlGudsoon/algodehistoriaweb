// geojson_a_svg.js — Convierte countries.geojson en un SVG editable (mapa-base.svg)
// Uso: node geojson_a_svg.js [entrada.geojson] [salida.svg]

const fs = require('fs');

const SRC = process.argv[2] || 'src/data/countries.geojson';
const OUT = process.argv[3] || 'src/assets/maps/mapa-base.svg';

// Misma proyección que world.svg (MapSVG, Web Mercator / EPSG:3857)
const W = 1009.6727;
const H = 665.96301;
const MIN_LON = -169.110266;
const MAX_LON = 190.486279;
const MAX_LAT = 83.600842;
const MIN_LAT = -58.508473;
const R = 6378137;

const merc = (latDeg) => R * Math.log(Math.tan(Math.PI / 4 + (latDeg * Math.PI) / 360));
const M_TOP = merc(MAX_LAT);
const M_BOT = merc(MIN_LAT);
const M_SPAN = M_TOP - M_BOT;

function aPix([lon, lat]) {
  const x = ((lon - MIN_LON) / (MAX_LON - MIN_LON)) * W;
  const mercM = R * Math.log(Math.tan(Math.PI / 4 + (lat * Math.PI) / 360));
  const y = ((M_TOP - mercM) / M_SPAN) * H;
  return [x, y];
}

const geo = JSON.parse(fs.readFileSync(SRC, 'utf8'));
const paths = [];

for (const f of geo.features) {
  const g = f.geometry;
  const id = f.properties.iso || f.properties.ADMIN || 'X';
  const titulo = f.properties.nameES || f.properties.ADMIN || id;
  const poligonos = g.type === 'Polygon' ? [g.coordinates] : g.coordinates;
  let d = '';
  let finX = 0;
  let finY = 0;
  for (const poligono of poligonos) {
    for (const ring of poligono) {
      if (!ring.length) continue;
      const pts = ring.map(aPix).map(([x, y]) => [Math.round(x * 1000) / 1000, Math.round(y * 1000) / 1000]);
      d += ` m ${(pts[0][0] - finX).toFixed(3)},${(pts[0][1] - finY).toFixed(3)}`;
      for (let i = 1; i < pts.length; i++) {
        d += ` l ${(pts[i][0] - pts[i - 1][0]).toFixed(3)},${(pts[i][1] - pts[i - 1][1]).toFixed(3)}`;
      }
      d += ' z';
      finX = pts[0][0];
      finY = pts[0][1];
    }
  }
  paths.push(`  <path id="${id}" title="${titulo}" d="${d.trim()}"/>`);
}

const svg = `<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<svg
   xmlns:mapsvg="http://mapsvg.com"
   xmlns="http://www.w3.org/2000/svg"
   mapsvg:geoViewBox="${MIN_LON} ${MAX_LAT} ${MAX_LON} ${MIN_LAT}"
   width="${W}"
   height="${H}"
   viewBox="0 0 ${W} ${H}"
   style="fill:#ffa218;stroke:#e92a41;stroke-width:0.3">
${paths.join('\n')}
</svg>
`;

fs.writeFileSync(OUT, svg);
console.log('países:', geo.features.length);
console.log('guardado en', OUT, (fs.statSync(OUT).size / 1024).toFixed(0), 'KB');
