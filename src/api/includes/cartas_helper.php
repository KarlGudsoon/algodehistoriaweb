<?php

function obtenerFilasCartas(PDO $pdo, array $cartaIds = []): array
{
  $filtro = '';
  $params = [];

  if (!empty($cartaIds)) {
    $placeholders = implode(',', array_fill(0, count($cartaIds), '?'));
    $filtro = 'WHERE c.id IN (' . $placeholders . ')';
    $params = array_values($cartaIds);
  }

  $sql = "
    SELECT
      c.slug,
      c.titulo,
      c.puntaje,
      c.rareza,
      c.color_carta       AS colorCarta,
      c.img_sobre         AS imgSobre,
      c.imagen,
      c.fondo_frontal     AS fondoFrontal,
      c.fondo_trasera     AS fondoTrasera,
      c.origen,
      c.lugar,
      c.nacimiento,
      c.fallecimiento,
      c.bandera,
      c.img_class         AS imgClass,
      c.blink,
      c.descripcion,
      c.fuerza,
      c.defensa,
      c.recoleccion,
      c.color,
      (SELECT e2.nombre FROM especialidades e2
       JOIN cartas_especialidades ce2 ON ce2.especialidad_id = e2.id
       WHERE ce2.carta_id = c.id LIMIT 1
      ) AS especialidad_nombre,
      (SELECT p1i.nombre FROM personalidades p1i
       JOIN cartas_personalidades cp1i ON cp1i.personalidad_id = p1i.id
       WHERE cp1i.carta_id = c.id AND cp1i.orden = 1 LIMIT 1
      ) AS pers1_nombre,
      (SELECT cp1i.clase_rareza FROM cartas_personalidades cp1i
       WHERE cp1i.carta_id = c.id AND cp1i.orden = 1 LIMIT 1
      ) AS pers1_clase,
      (SELECT p1i.icono FROM personalidades p1i
       JOIN cartas_personalidades cp1i ON cp1i.personalidad_id = p1i.id
       WHERE cp1i.carta_id = c.id AND cp1i.orden = 1 LIMIT 1
      ) AS pers1_img,
      (SELECT p2i.nombre FROM personalidades p2i
       JOIN cartas_personalidades cp2i ON cp2i.personalidad_id = p2i.id
       WHERE cp2i.carta_id = c.id AND cp2i.orden = 2 LIMIT 1
      ) AS pers2_nombre,
      (SELECT cp2i.clase_rareza FROM cartas_personalidades cp2i
       WHERE cp2i.carta_id = c.id AND cp2i.orden = 2 LIMIT 1
      ) AS pers2_clase,
      (SELECT p2i.icono FROM personalidades p2i
       JOIN cartas_personalidades cp2i ON cp2i.personalidad_id = p2i.id
       WHERE cp2i.carta_id = c.id AND cp2i.orden = 2 LIMIT 1
      ) AS pers2_img,
      (SELECT p3i.nombre FROM personalidades p3i
       JOIN cartas_personalidades cp3i ON cp3i.personalidad_id = p3i.id
       WHERE cp3i.carta_id = c.id AND cp3i.orden = 3 LIMIT 1
      ) AS pers3_nombre,
      (SELECT cp3i.clase_rareza FROM cartas_personalidades cp3i
       WHERE cp3i.carta_id = c.id AND cp3i.orden = 3 LIMIT 1
      ) AS pers3_clase,
      (SELECT p3i.icono FROM personalidades p3i
       JOIN cartas_personalidades cp3i ON cp3i.personalidad_id = p3i.id
       WHERE cp3i.carta_id = c.id AND cp3i.orden = 3 LIMIT 1
      ) AS pers3_img,
      (SELECT ph2.nombre FROM periodos_historicos ph2
       JOIN cartas_periodos cp2 ON cp2.periodo_id = ph2.id
       WHERE cp2.carta_id = c.id LIMIT 1
      ) AS periodo_nombre,
      (SELECT ph2.clase FROM periodos_historicos ph2
       JOIN cartas_periodos cp2 ON cp2.periodo_id = ph2.id
       WHERE cp2.carta_id = c.id LIMIT 1
      ) AS periodo_clase,
      (SELECT ph2.orden FROM periodos_historicos ph2
       JOIN cartas_periodos cp2 ON cp2.periodo_id = ph2.id
       WHERE cp2.carta_id = c.id LIMIT 1
      ) AS periodo_orden,
      (SELECT GROUP_CONCAT(cr2.texto ORDER BY cr2.orden SEPARATOR '||')
       FROM cartas_reconocimiento cr2 WHERE cr2.carta_id = c.id
      ) AS reconocimientos
    FROM cartas c
    $filtro
    ORDER BY (SELECT ph3.orden FROM periodos_historicos ph3
              JOIN cartas_periodos cp3o ON cp3o.periodo_id = ph3.id
              WHERE cp3o.carta_id = c.id LIMIT 1)
  ";

  $stmt = $pdo->prepare($sql);
  $stmt->execute($params);

  return $stmt->fetchAll();
}

function construirCartaDesdeFila(array $row): array
{
  $reconocimientos = [];
  if ($row['reconocimientos'] !== null) {
    $reconocimientos = explode('||', $row['reconocimientos']);
  }

  $tiempo = null;
  if ($row['nacimiento'] !== null || $row['fallecimiento'] !== null) {
    $parts = [];
    if ($row['nacimiento'] !== null) {
      $parts[] = '' . $row['nacimiento'];
    }
    if ($row['fallecimiento'] !== null) {
      $parts[] = '' . $row['fallecimiento'];
    }
    $tiempo = implode(' - ', $parts);
  }

  $personalidades = [];
  for ($i = 1; $i <= 3; $i++) {
    $nombre = $row["pers{$i}_nombre"];
    if ($nombre !== null) {
      $personalidades[] = [
        'nombre' => $nombre,
        'clase'  => $row["pers{$i}_clase"],
        'img'    => $row["pers{$i}_img"],
      ];
    }
  }

  $carta = [
    'puntaje'      => (string) $row['puntaje'],
    'rareza'       => $row['rareza'],
    'colorCarta'   => $row['colorCarta'],
    'imgSobre'     => 'url(' . $row['imgSobre'] . ')',
    'titulo'       => $row['titulo'],
    'color'        => $row['color'],
    'especialidad' => $row['especialidad_nombre'],
    'categoria'    => [
      [
        'nombre'  => $row['periodo_nombre'],
        'clase'   => $row['periodo_clase'],
        'periodo' => (int) $row['periodo_orden'],
      ],
    ],
    'imagen'       => $row['imagen'],
    'fondoFrontal' => $row['fondoFrontal'],
    'fondoTrasera' => $row['fondoTrasera'],
    'personalidad' => $personalidades,
    'descripcion'  => $row['descripcion'],
    'habilidades'  => [
      ['fuerza'     => (int) $row['fuerza']],
      ['defensa'    => (int) $row['defensa']],
      ['recoleccion'=> (int) $row['recoleccion']],
    ],
    'reconocimiento' => $reconocimientos,
    'tiempo'         => $tiempo,
  ];

  if ($row['origen'] !== null) {
    $carta['origen'] = (int) $row['origen'];
  }
  if ($row['lugar'] !== null) {
    $carta['lugar'] = $row['lugar'];
  }
  if ($row['bandera'] !== null) {
    $carta['bandera'] = $row['bandera'];
  }
  if ($row['imgClass'] !== null) {
    $carta['imgClass'] = $row['imgClass'];
  }
  if ($row['blink'] !== null) {
    $carta['blink'] = $row['blink'];
  }

  return $carta;
}

function construirCatalogo(array $filas): array
{
  $catalogo = [];
  foreach ($filas as $fila) {
    $catalogo[$fila['slug']] = construirCartaDesdeFila($fila);
  }
  return $catalogo;
}
