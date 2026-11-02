<?php
require __DIR__ . '/../config/session_config.php';
require __DIR__ . '/../config/csrf.php';

header('Content-Type: application/json');
header('Cache-Control: no-store');

session_start();

if (!isset($_SESSION['user_id'])) {
    http_response_code(401);
    die(json_encode(['error' => 'No hay sesión activa']));
}

$csrfToken = generarCSRFToken();

echo json_encode([
    'csrf_token' => $csrfToken,
    'user' => [
        'id' => $_SESSION['user_id'],
        'email' => $_SESSION['email'],
        'name' => $_SESSION['name'],
    ]
]);