-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Servidor: db
-- Tiempo de generación: 30-07-2026 a las 02:34:00
-- Versión del servidor: 8.0.46
-- Versión de PHP: 8.3.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `algodehistoria`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `articulos`
--

CREATE TABLE `articulos` (
  `id` int NOT NULL,
  `slug` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `titulo` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `resumen` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `descripcion` varchar(250) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `url` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `periodo_historico` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `fecha_exacta` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `fondo` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `personaje` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `articulos`
--

INSERT INTO `articulos` (`id`, `slug`, `titulo`, `resumen`, `descripcion`, `url`, `periodo_historico`, `fecha_exacta`, `fondo`, `personaje`, `created_at`) VALUES
(1, 'conquistadechile', 'Conquista de Chile', 'Desde el primer avistamiento de Chile hasta la fundación de Santiago', 'La conquista de Chile fue un proceso histórico que se inició en 1536 con la expedición de Diego de Almagro y culminó con la fundación de Santiago por Pedro de Valdivia en 1541.', '/articulos/moderna/origenes-chile/', 'Edad Moderna', '1520 - 1541', '/img/moderna/descubrimiento-chile/ONOFRE-JARPA_Araucarias-min.jpg', '/img/moderna/descubrimiento-chile/pedro-valdivia.png', '2026-07-15 01:11:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `articulo_completado`
--

CREATE TABLE `articulo_completado` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `articulo_id` int NOT NULL,
  `nota` decimal(3,1) NOT NULL,
  `aprobado` tinyint(1) NOT NULL DEFAULT '0',
  `fecha_completado` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `articulo_completado`
--

INSERT INTO `articulo_completado` (`id`, `user_id`, `articulo_id`, `nota`, `aprobado`, `fecha_completado`) VALUES
(5, 1, 1, 5.5, 1, '2026-07-28 06:21:54');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cuestionario_preguntas`
--

CREATE TABLE `cuestionario_preguntas` (
  `id` int NOT NULL,
  `articulo_id` int NOT NULL,
  `orden` int NOT NULL,
  `pregunta` text COLLATE utf8mb4_general_ci NOT NULL,
  `opcion_1` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `opcion_2` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `opcion_3` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `opcion_4` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `respuesta_correcta` tinyint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cuestionario_preguntas`
--

INSERT INTO `cuestionario_preguntas` (`id`, `articulo_id`, `orden`, `pregunta`, `opcion_1`, `opcion_2`, `opcion_3`, `opcion_4`, `respuesta_correcta`) VALUES
(1, 1, 0, '¿Cuales son los períodos de la Prehistoria?', 'Paleolítico, Mesolítico y Neolítico', 'Paleolítico y Neolítico', 'Paleolítico inferior, medio y superior', 'Ninguna de las anteriores', 1),
(2, 1, 1, 'Es la progresiva adquisición de las características que acabaron diferenciando a los homínidos del resto de primates.', 'Evolución', 'Hominización', 'Humanización', 'Adaptación', 2),
(3, 1, 2, '¿Qué habilidad permite a los Homo Sapiens realizar cosas como rituales, enterramientos, arte, lenguaje, etc.?', 'Abstracción', 'Herramientas', 'Bipedismo', 'Adaptación', 1),
(4, 1, 3, '¿Por qué se caracterizó la especie humana Homo Habilis?', 'Descubrimiento del fuego', 'Vivir en cuevas', 'Creación de herramientas', 'Ninguna de las anteriores', 3),
(5, 1, 4, '¿Cuál fue la primera de las especies de Homos de emigrar de África hacia otros continentes?', 'Homo Habilis', 'Homo Erectus', 'Homo Sapiens', 'Homo Neanderthal', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `password_hash` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `email`, `password_hash`, `name`, `created_at`) VALUES
(1, 'adrian.buscando123@gmail.com', '$2y$12$1yW2aogGL0vy6hbhbuvMzuYxWW/fwz.EaXb.9p.gVVSlTqiOEpGKe', 'Romina Maturana Muñoz', '2026-07-10 04:44:15');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario_cartas`
--

CREATE TABLE `usuario_cartas` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `carta_slug` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `fecha_obtenida` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuario_cartas`
--

INSERT INTO `usuario_cartas` (`id`, `user_id`, `carta_slug`, `fecha_obtenida`) VALUES
(27, 1, 'aymara', '2026-07-22 18:28:36'),
(28, 1, 'sapiens', '2026-07-22 18:28:41'),
(29, 1, 'neandertal', '2026-07-22 18:28:52'),
(30, 1, 'colon', '2026-07-22 18:41:14'),
(31, 1, 'magallanes', '2026-07-22 18:41:24');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario_experiencia`
--

CREATE TABLE `usuario_experiencia` (
  `user_id` int NOT NULL,
  `xp_total` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuario_experiencia`
--

INSERT INTO `usuario_experiencia` (`user_id`, `xp_total`) VALUES
(1, 350);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario_paises`
--

CREATE TABLE `usuario_paises` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `pais_slug` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `fecha_obtenida` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuario_paises`
--

INSERT INTO `usuario_paises` (`id`, `user_id`, `pais_slug`, `fecha_obtenida`) VALUES
(13, 1, 'imperioespañol', '2026-07-22 18:34:46'),
(14, 1, 'reinochile', '2026-07-22 19:20:45'),
(15, 1, 'imperioinca', '2026-07-28 05:19:54');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `xp_configuracion`
--

CREATE TABLE `xp_configuracion` (
  `accion` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `xp_otorgado` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `xp_configuracion`
--

INSERT INTO `xp_configuracion` (`accion`, `xp_otorgado`) VALUES
('articulo_completado', 75),
('articulo_completado_nota_perfecta', 25),
('carta_obtenida_bronce', 20),
('carta_obtenida_comun', 10),
('carta_obtenida_oro', 40),
('carta_obtenida_plata', 30),
('pais_obtenido', 30);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `xp_historial`
--

CREATE TABLE `xp_historial` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `accion` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `referencia` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `xp_otorgado` int NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `xp_historial`
--

INSERT INTO `xp_historial` (`id`, `user_id`, `accion`, `referencia`, `xp_otorgado`, `fecha`) VALUES
(37, 1, 'carta_obtenida_bronce', 'aymara', 20, '2026-07-22 18:28:36'),
(38, 1, 'carta_obtenida_oro', 'sapiens', 40, '2026-07-22 18:28:41'),
(39, 1, 'carta_obtenida_plata', 'neandertal', 30, '2026-07-22 18:28:52'),
(40, 1, 'pais_obtenido', 'imperioespañol', 30, '2026-07-22 18:34:46'),
(41, 1, 'carta_obtenida_oro', 'colon', 40, '2026-07-22 18:41:14'),
(42, 1, 'carta_obtenida_plata', 'magallanes', 30, '2026-07-22 18:41:24'),
(43, 1, 'pais_obtenido', 'reinochile', 30, '2026-07-22 19:20:45'),
(44, 1, 'pais_obtenido', 'imperioinca', 30, '2026-07-28 05:19:54'),
(45, 1, 'articulo_completado', '1', 75, '2026-07-28 05:20:30'),
(46, 1, 'articulo_completado_nota_perfecta', '1', 25, '2026-07-28 05:20:31');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `articulos`
--
ALTER TABLE `articulos`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`);

--
-- Indices de la tabla `articulo_completado`
--
ALTER TABLE `articulo_completado`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unico_articulo` (`user_id`,`articulo_id`),
  ADD KEY `articulo_id` (`articulo_id`);

--
-- Indices de la tabla `cuestionario_preguntas`
--
ALTER TABLE `cuestionario_preguntas`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unico_pregunta` (`articulo_id`,`orden`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indices de la tabla `usuario_cartas`
--
ALTER TABLE `usuario_cartas`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unico_carta` (`user_id`,`carta_slug`);

--
-- Indices de la tabla `usuario_experiencia`
--
ALTER TABLE `usuario_experiencia`
  ADD PRIMARY KEY (`user_id`);

--
-- Indices de la tabla `usuario_paises`
--
ALTER TABLE `usuario_paises`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unico_pais` (`user_id`,`pais_slug`);

--
-- Indices de la tabla `xp_configuracion`
--
ALTER TABLE `xp_configuracion`
  ADD PRIMARY KEY (`accion`);

--
-- Indices de la tabla `xp_historial`
--
ALTER TABLE `xp_historial`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unico_xp_por_accion` (`user_id`,`accion`,`referencia`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `articulos`
--
ALTER TABLE `articulos`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `articulo_completado`
--
ALTER TABLE `articulo_completado`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `cuestionario_preguntas`
--
ALTER TABLE `cuestionario_preguntas`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `usuario_cartas`
--
ALTER TABLE `usuario_cartas`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT de la tabla `usuario_paises`
--
ALTER TABLE `usuario_paises`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `xp_historial`
--
ALTER TABLE `xp_historial`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `articulo_completado`
--
ALTER TABLE `articulo_completado`
  ADD CONSTRAINT `articulo_completado_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `articulo_completado_ibfk_2` FOREIGN KEY (`articulo_id`) REFERENCES `articulos` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `cuestionario_preguntas`
--
ALTER TABLE `cuestionario_preguntas`
  ADD CONSTRAINT `cuestionario_preguntas_ibfk_1` FOREIGN KEY (`articulo_id`) REFERENCES `articulos` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `usuario_cartas`
--
ALTER TABLE `usuario_cartas`
  ADD CONSTRAINT `usuario_cartas_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `usuario_experiencia`
--
ALTER TABLE `usuario_experiencia`
  ADD CONSTRAINT `usuario_experiencia_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `usuario_paises`
--
ALTER TABLE `usuario_paises`
  ADD CONSTRAINT `usuario_paises_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `xp_historial`
--
ALTER TABLE `xp_historial`
  ADD CONSTRAINT `xp_historial_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
