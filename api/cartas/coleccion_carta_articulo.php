<?php
require __DIR__ . '/../config/session_config.php';
require __DIR__ . '/../config/db.php';
require __DIR__ . '/../middlewares/auth_check.php';

$slugsParam = $_GET['slugs'] ?? '';
$slugs = array_filter(array_map('trim', explode(',', $slugsParam)));

if (empty($slugs)) {
    echo json_encode(['coleccion' => []]);
    exit;
}

$placeholders = implode(',', array_fill(0, count($slugs), '?'));

$stmt = $pdo->prepare("
    SELECT c.slug AS carta_slug
    FROM usuario_cartas uc
    JOIN cartas c ON c.id = uc.carta_id
    WHERE uc.user_id = ? AND c.slug IN ($placeholders)
");

$stmt->execute([$_SESSION['user_id'], ...$slugs]);
$coleccion = $stmt->fetchAll();

echo json_encode(['coleccion' => $coleccion]);