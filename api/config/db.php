<?php

$config = require __DIR__ . '/../../config/db.php';

$host = $config['host'];
$db   = $config['db'];
$user = $config['user'];
$pass = $config['pass'];

try {
    $pdo = new PDO(
        "mysql:host=$host;dbname=$db;charset=utf8mb4",
        $user,
        $pass,
        [
            PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
            PDO::MYSQL_ATTR_INIT_COMMAND => "SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci",
        ]
    );
} catch (PDOException $e) {
    http_response_code(500);
    die(json_encode(['error' => 'Error de conexión a la base de datos']));
}

?>