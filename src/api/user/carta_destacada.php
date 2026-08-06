<?php
require __DIR__ . '/../config/session_config.php';
require __DIR__ . '/../config/db.php';
require __DIR__ . '/../middlewares/auth_check.php';
require __DIR__ . '/../includes/cartas_helper.php';

header('Content-Type: application/json; charset=utf-8');

$userId = $_SESSION['user_id'];

$stmt = $pdo->prepare('
    SELECT uc.carta_id, uc.fecha_obtenida
    FROM usuario_cartas uc
    WHERE uc.user_id = ?
    ORDER BY uc.fecha_obtenida DESC, uc.id DESC
    LIMIT 1
');
$stmt->execute([$userId]);
$destacada = $stmt->fetch();

if (!$destacada) {
    echo json_encode(['carta' => null]);
    exit;
}

$filas = obtenerFilasCartas($pdo, [(int) $destacada['carta_id']]);

if (empty($filas)) {
    echo json_encode(['carta' => null]);
    exit;
}

$carta = construirCartaDesdeFila($filas[0]);
$carta['fecha_obtenida'] = $destacada['fecha_obtenida'];

echo json_encode(['carta' => $carta], JSON_UNESCAPED_SLASHES | JSON_UNESCAPED_UNICODE);
