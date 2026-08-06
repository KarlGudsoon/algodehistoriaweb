<?php
require __DIR__ . '/../config/session_config.php';
require __DIR__ . '/../config/db.php';
require __DIR__ . '/../middlewares/auth_check.php';
require __DIR__ . '/../includes/paises_helper.php';

header('Content-Type: application/json; charset=utf-8');

$userId = $_SESSION['user_id'];

$stmt = $pdo->prepare('
    SELECT up.pais_id, up.fecha_obtenida
    FROM usuario_paises up
    WHERE up.user_id = ?
    ORDER BY up.fecha_obtenida DESC, up.id DESC
    LIMIT 1
');
$stmt->execute([$userId]);
$destacado = $stmt->fetch();

if (!$destacado) {
    echo json_encode(['pais' => null]);
    exit;
}

$filas = obtenerFilasPaises($pdo, [(int) $destacado['pais_id']]);

if (empty($filas)) {
    echo json_encode(['pais' => null]);
    exit;
}

$pais = construirPaisDesdeFila($filas[0]);
$pais['fecha_obtenida'] = $destacado['fecha_obtenida'];

echo json_encode(
    ['slug' => $filas[0]['slug'], 'pais' => $pais],
    JSON_UNESCAPED_SLASHES | JSON_UNESCAPED_UNICODE
);
