<?php
require __DIR__ . '/../config/session_config.php';
require __DIR__ . '/../config/db.php';
require __DIR__ . '/../middlewares/auth_check.php';

header('Content-Type: application/json');

$stmt = $pdo->prepare('SELECT COUNT(*) FROM cartas');
$stmt->execute();
$cantidad = $stmt->fetchColumn();

echo json_encode(['cantidad' => (int) $cantidad]);