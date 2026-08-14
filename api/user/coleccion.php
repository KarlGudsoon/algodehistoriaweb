<?php
require __DIR__ . '/../config/session_config.php';
require __DIR__ . '/../config/db.php';
require __DIR__ . '/../middlewares/auth_check.php';

header('Content-Type: application/json');

$userId = $_SESSION['user_id'];

$stmt = $pdo->prepare('SELECT COUNT(*) FROM cartas');
$stmt->execute();
$totalCartas = $stmt->fetchColumn();

$stmt = $pdo->prepare('
    SELECT c.slug AS carta_slug, c.rareza, uc.fecha_obtenida
    FROM usuario_cartas uc
    JOIN cartas c ON c.id = uc.carta_id
    WHERE uc.user_id = ?
');
$stmt->execute([$userId]);
$cartas = $stmt->fetchAll();

$conteoPorRareza = [
    'oro' => 0,
    'plata' => 0,
    'bronce' => 0
];

foreach ($cartas as $carta) {
    $rareza = strtolower($carta['rareza'] ?? '');

    if ($rareza === 'oro') {
        $conteoPorRareza['oro']++;
    } elseif ($rareza === 'plata') {
        $conteoPorRareza['plata']++;
    } elseif ($rareza === 'bronce') {
        $conteoPorRareza['bronce']++;
    }
}

echo json_encode([
    'cartas' => $cartas,
    'cartas_obtenidas' => count($cartas),
    'cartas_oro' => $conteoPorRareza['oro'],
    'cartas_plata' => $conteoPorRareza['plata'],
    'cartas_bronce' => $conteoPorRareza['bronce'],
    'cartas_totales' => (int) $totalCartas
]);