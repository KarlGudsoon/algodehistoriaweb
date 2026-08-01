<?php
require __DIR__ . '/../config/session_config.php';
require __DIR__ . '/../config/db.php';
require __DIR__ . '/../middlewares/auth_check.php';

// Recibe los slugs vía query string, ej: ?slugs=imperioinca,reinochile
$slugsParam = $_GET['slugs'] ?? '';
$slugs = array_filter(array_map('trim', explode(',', $slugsParam)));

if (empty($slugs)) {
    echo json_encode(['coleccion' => []]);
    exit;
}

// Genera los placeholders (?, ?, ?) según la cantidad de slugs recibidos
$placeholders = implode(',', array_fill(0, count($slugs), '?'));

$stmt = $pdo->prepare("
    SELECT p.slug AS pais_slug
    FROM usuario_paises up
    JOIN paises p ON p.id = up.pais_id
    WHERE up.user_id = ? AND p.slug IN ($placeholders)
");

$stmt->execute([$_SESSION['user_id'], ...$slugs]);
$coleccion = $stmt->fetchAll();

echo json_encode(['coleccion' => $coleccion]);
