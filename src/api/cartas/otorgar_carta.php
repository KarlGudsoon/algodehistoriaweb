<?php
require __DIR__ . '/../config/session_config.php';
require __DIR__ . '/../config/db.php';
require __DIR__ . '/../config/csrf.php';
require __DIR__ . '/../middlewares/auth_check.php';
require __DIR__ . '/../includes/xp_helper.php';

header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    die(json_encode(['error' => 'Método no permitido']));
}

validarCSRFToken();

$data = json_decode(file_get_contents('php://input'), true);
$slug = trim($data['slug'] ?? '');

if (empty($slug)) {
    http_response_code(400);
    die(json_encode(['error' => 'Falta el slug de la carta']));
}

$stmt = $pdo->prepare('SELECT id, rareza FROM cartas WHERE slug = ?');
$stmt->execute([$slug]);
$carta = $stmt->fetch();

if (!$carta) {
    http_response_code(404);
    die(json_encode(['error' => 'Carta no encontrada']));
}

$cartaId = (int) $carta['id'];
$rareza = strtolower($carta['rareza']);

$stmt = $pdo->prepare('SELECT id FROM usuario_cartas WHERE user_id = ? AND carta_id = ?');
$stmt->execute([$_SESSION['user_id'], $cartaId]);

if ($stmt->fetch()) {
    echo json_encode(['message' => 'Ya tienes esta carta', 'nueva' => false]);
    exit;
}

$stmt = $pdo->prepare('INSERT INTO usuario_cartas (user_id, carta_id) VALUES (?, ?)');
$stmt->execute([$_SESSION['user_id'], $cartaId]);

$accionXP = "carta_obtenida_{$rareza}";
$xpGanado = otorgarXP($pdo, $_SESSION['user_id'], $accionXP, $slug);

echo json_encode([
    'message' => 'Carta obtenida', 
    'nueva' => true,
    'xp_ganado' => $xpGanado,
]);