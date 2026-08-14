<?php

function generarCSRFToken(): string {
    if (empty($_SESSION['csrf_token'])) {
        $_SESSION['csrf_token'] = bin2hex(random_bytes(32));
    }
    return $_SESSION['csrf_token'];
}

function validarCSRFToken(): void {
    if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
        return;
    }

    $header = $_SERVER['HTTP_X_CSRF_TOKEN'] ?? '';

    if (empty($header) || empty($_SESSION['csrf_token']) || !hash_equals($_SESSION['csrf_token'], $header)) {
        http_response_code(403);
        header('Content-Type: application/json');
        die(json_encode(['error' => 'Token CSRF inválido']));
    }
}
