<?php
require __DIR__ . '/../config/session_config.php';
require __DIR__ . '/../config/db.php';
require __DIR__ . '/../includes/cartas_helper.php';

header('Content-Type: application/json; charset=utf-8');

$filas = obtenerFilasCartas($pdo);
$catalogo = construirCatalogo($filas);

echo json_encode($catalogo, JSON_UNESCAPED_SLASHES | JSON_UNESCAPED_UNICODE);
