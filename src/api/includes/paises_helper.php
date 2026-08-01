<?php

function obtenerFilasPaises(PDO $pdo, array $paisIds = []): array
{
  $filtro = '';
  $params = [];

  if (!empty($paisIds)) {
    $placeholders = implode(',', array_fill(0, count($paisIds), '?'));
    $filtro = 'WHERE p.id IN (' . $placeholders . ')';
    $params = array_values($paisIds);
  }

  $sql = "
    SELECT
      p.slug,
      p.nombre,
      p.color_fondo      AS colorFondo,
      p.descripcion,
      p.etiqueta_texto   AS etiquetaTexto,
      p.etiqueta_clase   AS etiquetaClase,
      p.bandera,
      p.economia,
      p.politica,
      p.territorio,
      p.tiempo_inicio    AS tiempoInicio,
      p.tiempo_fin       AS tiempoFin,
      p.personaje,
      p.fondo,
      p.anio_inicio   AS anioInicio,
      p.foco_lat      AS focoLat,
      p.foco_lng      AS focoLng,
      (SELECT GROUP_CONCAT(pl.texto ORDER BY pl.orden SEPARATOR '||')
       FROM paises_logros pl WHERE pl.pais_id = p.id
      ) AS logros_texto,
      (SELECT GROUP_CONCAT(pl.icono ORDER BY pl.orden SEPARATOR '||')
       FROM paises_logros pl WHERE pl.pais_id = p.id
      ) AS logros_icono,
      (SELECT GROUP_CONCAT(IFNULL(pl.imagen, '') ORDER BY pl.orden SEPARATOR '||')
       FROM paises_logros pl WHERE pl.pais_id = p.id
      ) AS logros_imagen,
      (SELECT GROUP_CONCAT(pa.texto ORDER BY pa.orden SEPARATOR '||')
       FROM paises_acontecimientos pa WHERE pa.pais_id = p.id
      ) AS acontecimientos,
      (SELECT GROUP_CONCAT(pt.iso ORDER BY pt.orden SEPARATOR '||')
       FROM paises_territorios pt WHERE pt.pais_id = p.id
      ) AS territorios,
      (SELECT pt.iso FROM paises_territorios pt
       WHERE pt.pais_id = p.id ORDER BY pt.orden LIMIT 1
      ) AS territorio_central
    FROM paises p
    $filtro
    ORDER BY p.id
  ";

  $stmt = $pdo->prepare($sql);
  $stmt->execute($params);

  return $stmt->fetchAll();
}

function construirPaisDesdeFila(array $row): array
{
  $logros = [];
  if ($row['logros_texto'] !== null) {
    $textos = explode('||', $row['logros_texto']);
    $iconos = $row['logros_icono'] !== null ? explode('||', $row['logros_icono']) : [];
    $imagenes = $row['logros_imagen'] !== null ? explode('||', $row['logros_imagen']) : [];

    for ($i = 0; $i < count($textos); $i++) {
      $logro = [$textos[$i], $iconos[$i] ?? ''];
      $imagen = $imagenes[$i] ?? '';
      if ($imagen !== '') {
        $logro[] = $imagen;
      }
      $logros["logro" . ($i + 1)] = $logro;
    }
  }

  $pais = [
    'nombre'      => $row['nombre'],
    'colorFondo'  => $row['colorFondo'],
    'descripcion' => $row['descripcion'],
    'etiqueta'    => [$row['etiquetaTexto'], $row['etiquetaClase']],
    'bandera'     => $row['bandera'],
    'economia'    => $row['economia'],
    'politica'    => $row['politica'],
    'territorio'  => $row['territorio'],
    'tiempo'      => [$row['tiempoInicio'], $row['tiempoFin']],
    'personaje'   => $row['personaje'],
    'fondo'       => $row['fondo'],
  ];

  foreach ($logros as $clave => $logro) {
    $pais[$clave] = $logro;
  }

  if ($row['acontecimientos'] !== null) {
    $pais['acontecimientos'] = explode('||', $row['acontecimientos']);
  }

  $pais['anioInicio'] = $row['anioInicio'] !== null ? (int) $row['anioInicio'] : null;

  $pais['foco'] = [
    'lat' => $row['focoLat'] !== null ? (float) $row['focoLat'] : null,
    'lng' => $row['focoLng'] !== null ? (float) $row['focoLng'] : null,
  ];

  $pais['territorios'] =
    $row['territorios'] !== null ? explode('||', $row['territorios']) : [];

  $pais['territorioCentral'] = $row['territorio_central'] ?? null;

  return $pais;
}

function construirCatalogoPaises(array $filas): array
{
  $catalogo = [];
  foreach ($filas as $fila) {
    $catalogo[$fila['slug']] = construirPaisDesdeFila($fila);
  }
  return $catalogo;
}
