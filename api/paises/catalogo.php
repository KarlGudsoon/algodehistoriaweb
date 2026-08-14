<?php
require __DIR__ . '/../config/session_config.php';
require __DIR__ . '/../config/db.php';
require __DIR__ . '/../includes/paises_helper.php';

header('Content-Type: application/json; charset=utf-8');

$filas = obtenerFilasPaises($pdo);
$catalogo = construirCatalogoPaises($filas);

echo json_encode($catalogo, JSON_UNESCAPED_SLASHES | JSON_UNESCAPED_UNICODE);
