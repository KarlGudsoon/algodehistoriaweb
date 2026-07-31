-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Servidor: db
-- Tiempo de generación: 31-07-2026 a las 00:20:57
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
  `slug` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `titulo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `resumen` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `descripcion` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `periodo_historico` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `fecha_exacta` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `fondo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `personaje` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
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
-- Estructura de tabla para la tabla `cartas`
--

CREATE TABLE `cartas` (
  `id` int NOT NULL,
  `slug` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `titulo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `puntaje` int NOT NULL,
  `rareza` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `color_carta` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `color` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `img_sobre` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `imagen` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `fondo_frontal` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `fondo_trasera` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `origen` int DEFAULT NULL,
  `lugar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `nacimiento` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `fallecimiento` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `bandera` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `img_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `blink` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `descripcion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `fuerza` int NOT NULL,
  `defensa` int NOT NULL,
  `recoleccion` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cartas`
--

INSERT INTO `cartas` (`id`, `slug`, `titulo`, `puntaje`, `rareza`, `color_carta`, `color`, `img_sobre`, `imagen`, `fondo_frontal`, `fondo_trasera`, `origen`, `lugar`, `nacimiento`, `fallecimiento`, `bandera`, `img_class`, `blink`, `descripcion`, `fuerza`, `defensa`, `recoleccion`) VALUES
(1, 'sapiens', 'HOMO SAPIENS', 10, 'oro', 'punto-dorado', 'var(--prehistoria)', '/img/prehistoria/sobreprehistoria.webp', '/img/prehistoria/humano.webp', '/img/prehistoria/neolitico.webp', '/img/prehistoria/dawnofman.jpeg', -4000000, NULL, NULL, NULL, NULL, NULL, NULL, 'El Homo Sapiens es nuestra especie, caracterizada por su capacidad de pensamiento abstracto, comunicación avanzada y desarrollo de herramientas complejas.', 2, 2, 3),
(2, 'neandertal', 'NEANDERTAL', 3, 'plata', 'punto-plata', 'var(--prehistoria)', '/img/prehistoria/sobreprehistoria.webp', '/img/prehistoria/Neandertal.png', '/img/prehistoria/pixelcut-export (6).jpeg', '/img/prehistoria/pixelcut-export (6).jpeg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'El Homo Neandertal fue una especie humana que habitó Europa y partes de Asia, adaptada al frío y conocida por su robustez física y herramientas avanzadas.', 3, 1, 1),
(3, 'aymara', 'PUEBLO AYMARA', 5, 'bronce', 'punto-bronce', 'var(--red)', '/img/moderna/descubrimiento-chile/ONOFRE-JARPA_Araucarias-min.jpg', '/img/moderna/descubrimiento-chile/personaje-aymara.webp', '/img/moderna/descubrimiento-chile/parque-lauca.webp', '/img/moderna/descubrimiento-chile/parque-lauca.webp', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'El pueblo Aymara es una cultura indígena de los Andes, conocida por su organización social, agricultura en terrazas y su lengua ancestral.', 1, 1, 2),
(4, 'colon', 'CRISTÓBAL COLÓN', 8, 'oro', 'punto-dorado', 'var(--moderna)', '/img/moderna/fondo.webp', '/img/otros/personajes-cartas/cristobal-colon2.webp', '/img/moderna/fondo.webp', '/img/moderna/fondo.webp', NULL, 'Genovés de nacimiento, pero navegó para españa', '1421', '1506', NULL, 'CristobalColon', NULL, 'Cristóbal Colón fue un navegante genovés conocido por realizar el viaje que llevó al descubrimiento de América en 1492, bajo el auspicio de los Reyes Católicos de España.', 1, 2, 2),
(5, 'magallanes', 'FERNANDO MAGALLANES', 5, 'plata', 'punto-plata', 'var(--moderna)', '/img/moderna/fondo.webp', '/img/moderna/descubrimiento-chile/fernandomagallanes.webp', '/img/moderna/descubrimiento-chile/expedicionmagallanesyelcano.webp', '/img/moderna/descubrimiento-chile/expedicionmagallanesyelcano.webp', NULL, 'Portugués de nacimiento, navegó para España', '1480', '1521', '/img/banderas/Flag_of_Portugal_(1578).svg', NULL, '/img/moderna/descubrimiento-chile/fernandomagallanes(blink).webp', 'Fue un navegante y explorador portugués al servicio de España, comandó la primera expedición en circunnavegar el globo y descubrió el Estrecho de Magallanes.', 2, 1, 1),
(6, 'soldado', 'SOLDADO DE SEGUNDA GUERRA MUNDIAL', 6, 'plata', 'punto-plata', 'var(--contemporanea)', '/img/moderna/fondo.webp', '/img/contemporanea/soldado-ww2.png', '/img/contemporanea/soldado-ww2.jpg', '/img/contemporanea/soldado-ww2.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Soldado de la Segunda Guerra Mundial, conocido por su participación en batallas clave y su compromiso con la defensa nacional.', 3, 2, 1),
(7, 'primeraguerramundialsoldado', 'SOLDADO DE PRIMERA GUERRA MUNDIAL', 5, 'plata', 'punto-plata', 'var(--contemporanea)', '/img/moderna/fondo.webp', '/img/contemporanea/soldado-guerra-mundial.jpg', '/img/contemporanea/guerra-primera-batalla.webp', '/img/contemporanea/frente-trinchera.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Soldado de la Primera Guerra Mundial, conocido por su participación en las trincheras y batallas del frente occidental.', 2, 3, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cartas_especialidades`
--

CREATE TABLE `cartas_especialidades` (
  `carta_id` int NOT NULL,
  `especialidad_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cartas_especialidades`
--

INSERT INTO `cartas_especialidades` (`carta_id`, `especialidad_id`) VALUES
(1, 1),
(2, 2),
(5, 2),
(3, 3),
(4, 3),
(6, 4),
(7, 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cartas_periodos`
--

CREATE TABLE `cartas_periodos` (
  `carta_id` int NOT NULL,
  `periodo_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cartas_periodos`
--

INSERT INTO `cartas_periodos` (`carta_id`, `periodo_id`) VALUES
(1, 1),
(2, 1),
(3, 4),
(4, 5),
(5, 5),
(6, 6),
(7, 6);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cartas_personalidades`
--

CREATE TABLE `cartas_personalidades` (
  `carta_id` int NOT NULL,
  `personalidad_id` int NOT NULL,
  `orden` tinyint NOT NULL,
  `clase_rareza` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cartas_personalidades`
--

INSERT INTO `cartas_personalidades` (`carta_id`, `personalidad_id`, `orden`, `clase_rareza`) VALUES
(1, 1, 1, 'punto-dorado'),
(1, 2, 2, 'punto-dorado'),
(1, 3, 3, 'punto-bronce'),
(2, 4, 1, 'punto-bronce'),
(2, 5, 2, 'punto-dorado'),
(2, 6, 3, 'punto-bronce'),
(3, 2, 1, 'punto-dorado'),
(3, 7, 2, 'punto-dorado'),
(3, 8, 3, 'punto-bronce'),
(4, 9, 1, 'punto-plata'),
(4, 10, 2, 'punto-plata'),
(4, 11, 3, 'punto-dorado'),
(5, 9, 1, 'punto-plata'),
(5, 10, 2, 'punto-basico'),
(5, 11, 3, 'punto-bronce'),
(6, 12, 1, 'punto-plata'),
(6, 13, 2, 'punto-dorado'),
(6, 14, 3, 'punto-plata'),
(7, 13, 2, 'punto-plata'),
(7, 14, 3, 'punto-bronce'),
(7, 15, 1, 'punto-dorado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cartas_reconocimiento`
--

CREATE TABLE `cartas_reconocimiento` (
  `id` int NOT NULL,
  `carta_id` int NOT NULL,
  `texto` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `orden` tinyint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cartas_reconocimiento`
--

INSERT INTO `cartas_reconocimiento` (`id`, `carta_id`, `texto`, `orden`) VALUES
(1, 4, 'Descubrió América', 1),
(2, 4, 'Lideró el primer viaje transatlántico documentado', 2),
(3, 5, 'Comandó la primera circunnavegación del globo', 1),
(4, 5, 'Descubrió el Estrecho de Magallanes', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cuestionario_preguntas`
--

CREATE TABLE `cuestionario_preguntas` (
  `id` int NOT NULL,
  `articulo_id` int NOT NULL,
  `orden` int NOT NULL,
  `pregunta` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `opcion_1` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `opcion_2` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `opcion_3` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `opcion_4` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
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
-- Estructura de tabla para la tabla `especialidades`
--

CREATE TABLE `especialidades` (
  `id` int NOT NULL,
  `nombre` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `icono` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `especialidades`
--

INSERT INTO `especialidades` (`id`, `nombre`, `icono`) VALUES
(1, 'Agricultor', NULL),
(2, 'Intrépido', NULL),
(3, 'Pensador', NULL),
(4, 'Defensor', NULL),
(5, 'Luchador', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `periodos_historicos`
--

CREATE TABLE `periodos_historicos` (
  `id` int NOT NULL,
  `nombre` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `clase` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `orden` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `periodos_historicos`
--

INSERT INTO `periodos_historicos` (`id`, `nombre`, `clase`, `orden`) VALUES
(1, 'Prehistoria', 'etiqueta-prehistoria', 0),
(2, 'Antigua', 'etiqueta-antigua', 1),
(3, 'Medieval', 'etiqueta-medieval', 2),
(4, 'Edad Medieval', 'etiqueta-medieval', 3),
(5, 'Edad Moderna', 'etiqueta-moderna', 4),
(6, 'Contemporánea', 'etiqueta-contemporanea', 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personalidades`
--

CREATE TABLE `personalidades` (
  `id` int NOT NULL,
  `nombre` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `icono` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `personalidades`
--

INSERT INTO `personalidades` (`id`, `nombre`, `icono`) VALUES
(1, 'Pensador', '/assets/icons/cerebro.svg'),
(2, 'Agricultor', '/assets/icons/trigo.svg'),
(3, 'Intrépido', '/assets/icons/prehistoria/stone-spear.svg'),
(4, 'Agresivo', NULL),
(5, 'Cazador', '/assets/icons/prehistoria/stone-spear.svg'),
(6, 'Resistente', NULL),
(7, 'Cultista', NULL),
(8, 'Andino', NULL),
(9, 'Navegante', '/assets/icons/brujula.svg'),
(10, 'Explorador', '/assets/icons/mapa.svg'),
(11, 'Visionario', '/assets/icons/telescopio.svg'),
(12, 'Luchador', '/assets/icons/brujula.svg'),
(13, 'Defensor', '/assets/icons/defensor.svg'),
(14, 'Disciplinado', '/assets/icons/disciplina.svg'),
(15, 'Guerrero', '/assets/icons/hacha.svg');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `password_hash` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
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
  `carta_id` int NOT NULL,
  `fecha_obtenida` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
  `pais_slug` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
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
  `accion` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
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
  `accion` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `referencia` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `xp_otorgado` int NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `xp_historial`
--

INSERT INTO `xp_historial` (`id`, `user_id`, `accion`, `referencia`, `xp_otorgado`, `fecha`) VALUES
(40, 1, 'pais_obtenido', 'imperioespañol', 30, '2026-07-22 18:34:46'),
(43, 1, 'pais_obtenido', 'reinochile', 30, '2026-07-22 19:20:45'),
(44, 1, 'pais_obtenido', 'imperioinca', 30, '2026-07-28 05:19:54'),
(45, 1, 'articulo_completado', '1', 75, '2026-07-28 05:20:30'),
(46, 1, 'articulo_completado_nota_perfecta', '1', 25, '2026-07-28 05:20:31');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `cartas`
--
ALTER TABLE `cartas`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`);

--
-- Indices de la tabla `cartas_especialidades`
--
ALTER TABLE `cartas_especialidades`
  ADD PRIMARY KEY (`carta_id`,`especialidad_id`),
  ADD KEY `especialidad_id` (`especialidad_id`);

--
-- Indices de la tabla `cartas_periodos`
--
ALTER TABLE `cartas_periodos`
  ADD PRIMARY KEY (`carta_id`,`periodo_id`),
  ADD KEY `periodo_id` (`periodo_id`);

--
-- Indices de la tabla `cartas_personalidades`
--
ALTER TABLE `cartas_personalidades`
  ADD PRIMARY KEY (`carta_id`,`personalidad_id`),
  ADD KEY `personalidad_id` (`personalidad_id`);

--
-- Indices de la tabla `cartas_reconocimiento`
--
ALTER TABLE `cartas_reconocimiento`
  ADD PRIMARY KEY (`id`),
  ADD KEY `carta_id` (`carta_id`);

--
-- Indices de la tabla `especialidades`
--
ALTER TABLE `especialidades`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `periodos_historicos`
--
ALTER TABLE `periodos_historicos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `personalidades`
--
ALTER TABLE `personalidades`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `articulos`
--
ALTER TABLE `articulos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `articulo_completado`
--
ALTER TABLE `articulo_completado`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `articulo_id` (`articulo_id`);

--
-- Indices de la tabla `cuestionario_preguntas`
--
ALTER TABLE `cuestionario_preguntas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `articulo_id` (`articulo_id`);

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
  ADD KEY `user_id` (`user_id`),
  ADD KEY `carta_id` (`carta_id`);

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
  ADD KEY `user_id` (`user_id`);

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
  ADD KEY `user_id` (`user_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `cartas`
--
ALTER TABLE `cartas`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `cartas_reconocimiento`
--
ALTER TABLE `cartas_reconocimiento`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `especialidades`
--
ALTER TABLE `especialidades`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `periodos_historicos`
--
ALTER TABLE `periodos_historicos`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `personalidades`
--
ALTER TABLE `personalidades`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `articulos`
--
ALTER TABLE `articulos`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `articulo_completado`
--
ALTER TABLE `articulo_completado`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

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
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuario_paises`
--
ALTER TABLE `usuario_paises`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `xp_historial`
--
ALTER TABLE `xp_historial`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `cartas_especialidades`
--
ALTER TABLE `cartas_especialidades`
  ADD CONSTRAINT `cartas_especialidades_ibfk_1` FOREIGN KEY (`carta_id`) REFERENCES `cartas` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `cartas_especialidades_ibfk_2` FOREIGN KEY (`especialidad_id`) REFERENCES `especialidades` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `cartas_periodos`
--
ALTER TABLE `cartas_periodos`
  ADD CONSTRAINT `cartas_periodos_ibfk_1` FOREIGN KEY (`carta_id`) REFERENCES `cartas` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `cartas_periodos_ibfk_2` FOREIGN KEY (`periodo_id`) REFERENCES `periodos_historicos` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `cartas_personalidades`
--
ALTER TABLE `cartas_personalidades`
  ADD CONSTRAINT `cartas_personalidades_ibfk_1` FOREIGN KEY (`carta_id`) REFERENCES `cartas` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `cartas_personalidades_ibfk_2` FOREIGN KEY (`personalidad_id`) REFERENCES `personalidades` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `cartas_reconocimiento`
--
ALTER TABLE `cartas_reconocimiento`
  ADD CONSTRAINT `cartas_reconocimiento_ibfk_1` FOREIGN KEY (`carta_id`) REFERENCES `cartas` (`id`) ON DELETE CASCADE;

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
  ADD CONSTRAINT `usuario_cartas_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `usuario_cartas_ibfk_2` FOREIGN KEY (`carta_id`) REFERENCES `cartas` (`id`) ON DELETE CASCADE;

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
