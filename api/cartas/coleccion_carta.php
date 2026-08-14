<?php
require __DIR__ . '/../config/session_config.php';
require __DIR__ . '/../config/db.php';
require __DIR__ . '/../middlewares/auth_check.php';

header('Content-Type: application/json');

$stmt = $pdo->prepare('
    SELECT c.slug AS carta_slug, uc.fecha_obtenida
    FROM usuario_cartas uc
    JOIN cartas c ON c.id = uc.carta_id
    WHERE uc.user_id = ?
');
$stmt->execute([$_SESSION['user_id']]);
$coleccion = $stmt->fetchAll();

echo json_encode(['coleccion' => $coleccion]);