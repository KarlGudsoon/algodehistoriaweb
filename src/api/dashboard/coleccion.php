<?php
require __DIR__ . '/../config/session_config.php';
require __DIR__ . '/../config/db.php';
require __DIR__ . '/../middlewares/auth_check.php';

header('Content-Type: application/json');

$userId = $_SESSION['user_id'];

$stmt = $pdo->prepare('
    SELECT c.slug AS carta_slug, uc.fecha_obtenida
    FROM usuario_cartas uc
    JOIN cartas c ON c.id = uc.carta_id
    WHERE uc.user_id = ?
');
$stmt->execute([$userId]);
$cartas = $stmt->fetchAll();

$stmt = $pdo->prepare('
    SELECT p.slug AS pais_slug, up.fecha_obtenida
    FROM usuario_paises up
    JOIN paises p ON p.id = up.pais_id
    WHERE up.user_id = ?
');
$stmt->execute([$userId]);
$paises = $stmt->fetchAll();

echo json_encode([
    'cartas' => $cartas,
    'paises' => $paises,
]);