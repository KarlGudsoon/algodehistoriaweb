<?php
require __DIR__ . '/../config/session_config.php';
require __DIR__ . '/../config/db.php';
require __DIR__ . '/../middlewares/auth_check.php';

header('Content-Type: application/json');

$userId = $_SESSION['user_id'];

$stmt = $pdo->prepare('
    SELECT a.slug, a.titulo, a.resumen, a.descripcion, a.url, a.periodo_historico, a.fecha_exacta, a.fondo, a.personaje,
           ac.nota, ac.aprobado, ac.fecha_completado
    FROM articulo_completado ac
    JOIN articulos a ON a.id = ac.articulo_id
    WHERE ac.user_id = ?
    ORDER BY ac.fecha_completado DESC
');
$stmt->execute([$userId]);
$completados = $stmt->fetchAll();

echo json_encode(['completados' => $completados]);
