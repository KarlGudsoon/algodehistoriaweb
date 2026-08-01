// svg_a_geojson.js — Convierte un SVG editable en GeoJSON para el globo.
// Uso: node svg_a_geojson.js [entrada.svg] [salida.geojson]
// Ejemplo: node svg_a_geojson.js src/assets/maps/mapa-1914.svg src/data/mapas/1914.geojson
//
// Convenciones del SVG:
//  - Un país/entidad = uno o varios <path> con el mismo id="..." y title="Nombre en español".
//  - Los <path> con el mismo id se agrupan en una sola feature (útil para fusionar imperios).
//  - La proyección (Web Mercator) se lee del propio SVG: width, height y mapsvg:geoViewBox.
//    Si faltan, se usan las constantes de world.svg. NO cambies el tamaño del lienzo.

const fs = require('fs');
const os = require('os');
const path = require('path');

const SRC_SVG = process.argv[2] || 'src/assets/maps/world.svg';
const OUT_GEOJSON = process.argv[3] || 'src/data/countries.geojson';
const ES_JSON = path.join(os.homedir(), 'AppData', 'Local', 'Temp', 'opencode', 'countries_es.json');

const R = 6378137;

// Constantes por defecto (world.svg MapSVG, Web Mercator / EPSG:3857)
let W = 1009.6727;
let H = 665.96301;
let MIN_LON = -169.110266;
let MAX_LON = 190.486279;
let MAX_LAT = 83.600842;
let MIN_LAT = -58.508473;

const svg = fs.readFileSync(SRC_SVG, 'utf8');

// Leer proyección del propio SVG
const vb = /mapsvg:geoViewBox="([-\d.]+) ([-\d.]+) ([-\d.]+) ([-\d.]+)"/.exec(svg);
if (vb) {
  MIN_LON = parseFloat(vb[1]);
  MAX_LAT = parseFloat(vb[2]);
  MAX_LON = parseFloat(vb[3]);
  MIN_LAT = parseFloat(vb[4]);
}
const wm = /width="([\d.]+)"/.exec(svg);
if (wm) W = parseFloat(wm[1]);
const hm = /height="([\d.]+)"/.exec(svg);
if (hm) H = parseFloat(hm[1]);

const merc = (latDeg) => R * Math.log(Math.tan(Math.PI / 4 + (latDeg * Math.PI) / 360));
const M_TOP = merc(MAX_LAT);
const M_BOT = merc(MIN_LAT);
const M_SPAN = M_TOP - M_BOT;

function interpretar(d) {
  const toks = d
    .match(/\s*([a-zA-Z])\s*|(-?\d+(?:\.\d+)?(?:e-?\d+)?)(?:\s*,)?/g)
    .map((t) => t.trim())
    .filter(Boolean);

  let x = 0, y = 0, sx = 0, sy = 0;
  let cur = '';
  const nums = [];
  const subpaths = [];
  let actual = null;

  const flush = () => {
    if (cur === 'z' || cur === 'Z') {
      x = sx;
      y = sy;
      if (actual) actual.push([x, y]);
      if (actual && actual.length) subpaths.push(actual);
      actual = null;
    } else if (nums.length) {
      if (!actual) actual = [];
      if (cur === 'm' || cur === 'M') {
        x += nums[0];
        y += nums[1];
        sx = x;
        sy = y;
        actual.push([x, y]);
        for (let i = 2; i + 1 < nums.length; i += 2) {
          x += nums[i];
          y += nums[i + 1];
          actual.push([x, y]);
        }
      } else {
        for (let i = 0; i + 1 < nums.length; i += 2) {
          x += nums[i];
          y += nums[i + 1];
          actual.push([x, y]);
        }
      }
      nums.length = 0;
      cur = '';
    }
  };

  for (const t of toks) {
    if (/^[a-zA-Z]$/.test(t)) {
      flush();
      cur = t;
    } else {
      nums.push(parseFloat(t));
    }
  }
  flush();

  if (actual && actual.length) subpaths.push(actual);
  return subpaths.filter((p) => p.length >= 3);
}

function toLonLat(subpath) {
  return subpath.map(([px, py]) => {
    const lon = MIN_LON + (px / W) * (MAX_LON - MIN_LON);
    const mercM = M_TOP - (py / H) * M_SPAN;
    const lat = (Math.atan(Math.exp(mercM / R)) * 2 - Math.PI / 2) * (180 / Math.PI);
    return [lon, lat];
  });
}

function ajustarBanda(anillo) {
  let max = -1e9;
  let min = 1e9;
  for (const [lo] of anillo) {
    if (lo > max) max = lo;
    if (lo < min) min = lo;
  }
  if (max > 180) return anillo.map(([lo, la]) => [lo - 360, la]);
  if (min < -180) return anillo.map(([lo, la]) => [lo + 360, la]);
  return anillo;
}

const RAD = Math.PI / 180;
// Simplificación Douglas-Peucker (grados). 0 = conservar todas tus ediciones.
// Para probar: node ... con DP=0.15 env var. Ej: $env:DP="0.15"
const TOLERANCIA = parseFloat(process.env.DP || '0');

function distanciaPuntos(a, b) {
  const dy = b[1] - a[1];
  const dx = (b[0] - a[0]) * Math.cos(((a[1] + b[1]) / 2) * RAD);
  return Math.hypot(dx, dy);
}

function distanciaASegmento(p, a, b) {
  const ab = [b[0] - a[0], b[1] - a[1]];
  const ap = [p[0] - a[0], p[1] - a[1]];
  const l2 = ab[0] * ab[0] + ab[1] * ab[1];
  let t = l2 === 0 ? 0 : (ap[0] * ab[0] + ap[1] * ab[1]) / l2;
  t = Math.max(0, Math.min(1, t));
  return distanciaPuntos(p, [a[0] + t * ab[0], a[1] + t * ab[1]]);
}

function simplificar(anillo) {
  const n = anillo.length;
  if (n <= 4) return anillo;
  const mantener = [anillo[0]];
  const pila = [[0, n - 1]];
  while (pila.length) {
    const [s, e] = pila.pop();
    let maxD = -1;
    let idx = -1;
    for (let i = s + 1; i < e; i++) {
      const d = distanciaASegmento(anillo[i], anillo[s], anillo[e]);
      if (d > maxD) {
        maxD = d;
        idx = i;
      }
    }
    if (idx !== -1 && maxD > TOLERANCIA) {
      pila.push([s, idx]);
      pila.push([idx, e]);
    } else if (e > s + 1) {
      mantener.push(anillo[e]);
    }
  }
  mantener.push(anillo[n - 1]);
  return mantener;
}

function redondear(anillo) {
  return anillo.map(([lo, la]) => [Math.round(lo * 1000) / 1000, Math.round(la * 1000) / 1000]);
}

function limpiarDuplicados(anillo) {
  const limpio = [];
  for (const p of anillo) {
    const ultimo = limpio[limpio.length - 1];
    if (ultimo && ultimo[0] === p[0] && ultimo[1] === p[1]) continue;
    limpio.push(p);
  }
  return limpio;
}

function normalizar(anillo) {
  return anillo.map(([lo, la]) => [lo > 180 ? lo - 360 : lo < -180 ? lo + 360 : lo, la]);
}

function dividirEnAntimeridiano(ring) {
  let arr = ring;
  const n0 = arr.length;
  if (n0 >= 2 && arr[0][0] === arr[n0 - 1][0] && arr[0][1] === arr[n0 - 1][1]) {
    arr = arr.slice(0, -1);
  }
  const P = arr.length;

  const cuts = [];
  for (let i = 0; i < P; i++) {
    const a = arr[i];
    const b = arr[(i + 1) % P];
    const lo = Math.min(a[0], b[0]);
    const hi = Math.max(a[0], b[0]);
    if (lo === hi) continue;
    for (let m = Math.ceil(lo / 180); m <= Math.floor(hi / 180); m++) {
      const bnd = m * 180;
      if (bnd > lo && bnd < hi) {
        const t = (bnd - a[0]) / (b[0] - a[0]);
        cuts.push({ at: i, lon: bnd, lat: a[1] + t * (b[1] - a[1]) });
      }
    }
  }

  if (!cuts.length) return [ajustarBanda(arr)];

  cuts.sort((x, y) => x.at - y.at);
  const result = [];
  for (let c = 0; c < cuts.length; c++) {
    const cut = cuts[c];
    const next = cuts[(c + 1) % cuts.length];
    const sub = [[cut.lon, cut.lat]];
    let idx = (cut.at + 1) % P;
    let pasos = 0;
    while (idx !== next.at && pasos <= P) {
      sub.push([arr[idx][0], arr[idx][1]]);
      idx = (idx + 1) % P;
      pasos++;
    }
    sub.push([next.lon, next.lat]);
    result.push(ajustarBanda(sub));
  }
  return result;
}

// Nombres en español (respaldado por iso)
let porIso2 = new Map();
let porIso3 = new Map();
try {
  const es = JSON.parse(fs.readFileSync(ES_JSON, 'utf8'));
  porIso2 = new Map(es.map((c) => [c.iso2, c.nameES]));
  porIso3 = new Map(es.map((c) => [c.iso3, c.nameES]));
} catch {
  // sigue sin nombres, se usará el title del SVG
}

// Nombres manuales para casos/entidades especiales (añade aquí imperios históricos)
const manual = {
  UM: 'Islas Ultramarinas Menores de Estados Unidos',
  BQ: 'Bonaire, San Eustaquio y Saba',
  GO: 'Islas Gloriosas',
  JU: 'Isla Juan de Nova',
  XK: 'Kosovo',
};

// Continente por ISO desde el GeoJSON previo (respaldo, si existe)
let continentePorIso = new Map();
try {
  const prev = JSON.parse(fs.readFileSync(OUT_GEOJSON, 'utf8'));
  for (const f of prev.features) {
    if (f.properties.iso && f.properties.CONTINENT) {
      continentePorIso.set(f.properties.iso, f.properties.CONTINENT);
    }
  }
} catch {
  // no importa
}

// Agrupar paths con el mismo id en una sola feature
function claveId(rawId) {
  if (/^[A-Z]{2}$/.test(rawId)) return rawId;
  const m5 = /^([A-Z]{2})-[A-Z]{2}$/.exec(rawId);
  if (m5) return m5[1];
  return rawId;
}

const porClave = new Map();
const re = /<path\b([^>]*)>/g;
let m;
while ((m = re.exec(svg))) {
  const attrs = m[1];
  const idm = /id="([^"]*)"/.exec(attrs);
  const tm = /title="([^"]*)"/.exec(attrs);
  const dm = / d="([^"]*)"/.exec(attrs);
  if (!idm || !dm) continue;

  const clave = claveId(idm[1]);
  const pipeline = interpretar(dm[1])
    .map(toLonLat)
    .flatMap(dividirEnAntimeridiano)
    .map(normalizar)
    .map(redondear)
    .map(limpiarDuplicados);
  // Simplificación opcional: solo si se define DP>0 (ej. $env:DP="0.15")
  const rings = TOLERANCIA > 0
    ? pipeline.map(simplificar)
    : pipeline;
  const anillos = rings.map((ring) => {
    const primera = ring[0];
    const ultima = ring[ring.length - 1];
    if (primera[0] !== ultima[0] || primera[1] !== ultima[1]) {
      ring.push([primera[0], primera[1]]);
    }
    return ring;
  });

  if (!porClave.has(clave)) porClave.set(clave, { title: tm ? tm[1] : clave, rings: [] });
  for (const r of anillos) porClave.get(clave).rings.push(r);
}

const features = [];
for (const [clave, { title, rings }] of porClave) {
  const iso = clave;
  const admin = title;
  const nameES = manual[iso] || porIso2.get(iso) || porIso3.get(iso) || admin;

  features.push({
    type: 'Feature',
    properties: {
      nameES,
      iso,
      ADMIN: admin,
      CONTINENT: continentePorIso.get(iso) || null,
    },
    geometry:
      rings.length === 1
        ? { type: 'Polygon', coordinates: rings }
        : { type: 'MultiPolygon', coordinates: rings.map((r) => [r]) },
  });
}

const out = { type: 'FeatureCollection', features };
fs.writeFileSync(OUT_GEOJSON, JSON.stringify(out));
console.log('features:', features.length);

let bad = 0;
for (const f of features) {
  const rings = f.geometry.type === 'Polygon' ? f.geometry.coordinates : f.geometry.coordinates.flat();
  for (const [lo, la] of rings.flat()) {
    if (!Number.isFinite(lo) || !Number.isFinite(la) || lo < -180 || lo > 180 || la < -90 || la > 90) bad++;
  }
}
console.log('coordenadas inválidas:', bad);
