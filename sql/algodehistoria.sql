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
-- Estructura de tabla para la tabla `paises`
--

CREATE TABLE `paises` (
  `id` int NOT NULL,
  `slug` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `nombre` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `color_fondo` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `descripcion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `etiqueta_texto` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `etiqueta_clase` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `bandera` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `economia` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `politica` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `territorio` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `tiempo_inicio` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `tiempo_fin` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `personaje` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `fondo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `anio_inicio` int DEFAULT NULL,
  `foco_lat` decimal(9,6) DEFAULT NULL,
  `foco_lng` decimal(9,6) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `paises`
--

INSERT INTO `paises` (`id`, `slug`, `nombre`, `color_fondo`, `descripcion`, `etiqueta_texto`, `etiqueta_clase`, `bandera`, `economia`, `politica`, `territorio`, `tiempo_inicio`, `tiempo_fin`, `personaje`, `fondo`, `anio_inicio`, `foco_lat`, `foco_lng`) VALUES
(1, 'imperioinca', 'Imperio Inca', 'rgba(32, 102, 5, 0.6)', 'El Imperio Inca, llamado Tahuantinsuyo, fue el imperio más grande de la América precolombina, que se extendió desde Ecuador hasta Chile y Argentina entre los siglos XV y XVI, con su centro en la ciudad de Cusco.', 'Imperio Precolombino', 'etiqueta-precolombino', '/img/banderas/estandarte-inca.svg', 'Economía basada en la agricultura, el comercio y el tributo.', 'Sistema de gobierno centralizado con un emperador (Sapa Inca)', 'Ubicación: Región andina de América del Sur, principalmente en Perú, Ecuador, Bolivia y partes de Chile y Argentina.', 'Siglo XV', '1533', NULL, '/img/moderna/descubrimiento-chile/9c7cecfd-5b8a-4916-82f4-34e3fb119004.webp', 1438, -13.531900, -71.967500),
(2, 'imperioespañol', 'Imperio Español', 'rgba(188, 22, 42, 0.6)', 'El Imperio Español fue uno de los imperios más grandes de la historia, abarcando territorios en Europa, América, Asia y África desde el siglo XV hasta el siglo XIX.', 'Imperio Colonial', 'etiqueta-moderna', '/img/banderas/bandera-imperio-español.webp', 'Economía basada en la explotación de metales preciosos como oro y plata, el comercio transatlántico, la agricultura de plantación en América y el sistema de encomiendas.', 'Monarquía absoluta con un sistema de virreinatos y gobernadores para administrar los territorios coloniales.', 'Territorios en Europa (España, Portugal por unión dinástica), gran parte de América (desde México hasta el Cono Sur, además del Caribe), Filipinas y otras islas en Asia, así como enclaves en África.', '1492', '1898', NULL, '/img/moderna/fondo.webp', 1492, 12.000000, -60.000000),
(3, 'reinochile', 'Reino de Chile', 'rgba(0, 80, 158, 0.6)', 'El Reino de Chile fue una entidad territorial del Imperio Español en América del Sur, establecida tras la conquista y consolidación de Pedro de Valdivia, gobernada por la Corona española desde la fundación de Santiago en 1541 hasta el proceso de independencia de Chile.', 'Reino Colonial', 'etiqueta-moderna', '/img/banderas/bandera-imperio-español.webp', 'Economía colonial basada en la agricultura, la ganadería, el trabajo de los indígenas en encomiendas y la extracción de oro y plata.', 'Colonia gobernada por un Gobernador y Capitán General nombrado por la Corona española, con la Real Audiencia como tribunal superior.', 'Territorio de la Capitanía General de Chile, que se extendía desde el desierto de Atacama hasta la frontera del río Biobío, limitando al sur con el territorio mapuche independiente.', '1541', '1818', '/img/moderna/descubrimiento-chile/pedro-valdivia.png', '/img/moderna/descubrimiento-chile/fundacionsantiago.webp', 1541, -33.450000, -70.660000),
(4, 'peru', 'Perú', 'rgba(217, 16, 40, 0.6)', 'Perú es una república de la costa occidental de América del Sur, sucesora del Virreinato del Perú e independiente desde 1821, heredera de la herencia cultural del Tahuantinsuyo.', 'República', 'etiqueta-moderna', '/assets/icons/bandera.svg', 'Economía basada en minería, agricultura, pesca y servicios.', 'República democrática con gobierno presidencialista.', 'Perú: costa del Pacífico, sierra andina y Amazonía.', '1821', 'Actualidad', NULL, '/img/moderna/descubrimiento-chile/9c7cecfd-5b8a-4916-82f4-34e3fb119004.webp', 1821, -12.046400, -77.042800),
(5, 'chile', 'Chile', 'rgba(0, 57, 166, 0.6)', 'Chile es una república de América del Sur que se extiende entre la cordillera de los Andes y el océano Pacífico, independiente desde 1818 y sucesora del Reino de Chile colonial.', 'República', 'etiqueta-moderna', '/assets/icons/bandera.svg', 'Economía basada en la minería del cobre, agricultura, industria y servicios.', 'República democrática con régimen presidencial.', 'Chile continental, desde la región de Arica y Parinacota hasta la Patagonia.', '1818', 'Actualidad', NULL, '/img/moderna/descubrimiento-chile/fundacionsantiago.webp', 1818, -33.448900, -70.669300),
(6, 'españa', 'España', 'rgba(170, 21, 21, 0.6)', 'España es un Estado europeo de la península ibérica, heredero de los reinos cristianos y del antiguo Imperio Español, con una monarquía parlamentaria desde 1978.', 'Estado Moderno', 'etiqueta-moderna', '/assets/icons/bandera.svg', 'Economía basada en servicios, turismo, industria y agricultura.', 'Monarquía parlamentaria con sistema democrático.', 'España peninsular, islas Baleares y Canarias.', '1978', 'Actualidad', NULL, '/img/moderna/fondo.webp', 1978, 40.416800, -3.703800),
(7, 'ecuador', 'Ecuador', 'rgba(255, 221, 0, 0.6)', 'Ecuador es una república ubicada en la línea ecuatorial de América del Sur, independiente desde 1830, con territorios en la costa, la sierra y la Amazonía.', 'República', 'etiqueta-moderna', '/assets/icons/bandera.svg', 'Economía basada en petróleo, agricultura, banano y servicios.', 'República democrática presidencialista.', 'Ecuador: costa del Pacífico, sierra andina y Amazonía.', '1830', 'Actualidad', NULL, '/img/moderna/descubrimiento-chile/9c7cecfd-5b8a-4916-82f4-34e3fb119004.webp', 1830, -0.180700, -78.467800),
(8, 'bolivia', 'Bolivia', 'rgba(213, 43, 30, 0.6)', 'Bolivia es un país andino de América del Sur, independiente desde 1825, conocido por su diversidad étnica y cultural y por ser el corazón del antiguo territorio incaico.', 'República', 'etiqueta-moderna', '/assets/icons/bandera.svg', 'Economía basada en gas natural, minería y agricultura.', 'República democrática plurinacional.', 'Bolivia: altiplano andino, valles y llanuras orientales.', '1825', 'Actualidad', NULL, '/img/moderna/descubrimiento-chile/9c7cecfd-5b8a-4916-82f4-34e3fb119004.webp', 1825, -16.500000, -68.150000),
(9, 'argentina', 'Argentina', 'rgba(117, 170, 219, 0.6)', 'Argentina es una república de América del Sur, independiente desde 1816, con un vasto territorio que se extiende desde los Andes hasta el Atlántico.', 'República', 'etiqueta-moderna', '/assets/icons/bandera.svg', 'Economía basada en agricultura, ganadería, industria y servicios.', 'República democrática federal presidencialista.', 'Argentina: desde el altiplano y Cuyo hasta la Patagonia y Tierra del Fuego.', '1816', 'Actualidad', NULL, '/img/moderna/fondo.webp', 1816, -34.603700, -58.381600),
(10, 'colombia', 'Colombia', 'rgba(255, 204, 0, 0.6)', 'Colombia es una república de América del Sur, independiente desde 1810, con costas en el Pacífico y el Caribe y un territorio andino diverso.', 'República', 'etiqueta-moderna', '/assets/icons/bandera.svg', 'Economía basada en café, petróleo, flores y servicios.', 'República democrática presidencialista.', 'Colombia: Andes, Caribe, Pacífico, Orinoquía y Amazonía.', '1810', 'Actualidad', NULL, '/img/moderna/fondo.webp', 1810, 4.711000, -74.072100);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `paises_logros`
--

CREATE TABLE `paises_logros` (
  `id` int NOT NULL,
  `pais_id` int NOT NULL,
  `orden` tinyint NOT NULL,
  `texto` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `icono` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `imagen` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `paises_logros`
--

INSERT INTO `paises_logros` (`id`, `pais_id`, `orden`, `texto`, `icono`, `imagen`) VALUES
(1, 1, 1, 'Construcción de una vasta red de caminos y puentes.', '/assets/icons/recorrido.svg', NULL),
(2, 1, 2, 'Desarrollo de técnicas agrícolas avanzadas, como las terrazas.', '/assets/icons/trigo.svg', NULL),
(3, 1, 3, 'Sistema de administración eficiente y centralizada.', '/assets/icons/inca.svg', NULL),
(4, 2, 1, 'Primer imperio global con territorios en los cinco continentes.', '/assets/icons/subway--world-1.svg', '/img/moderna/1423px-F0087_Louvre_Gellee_port_au_soleil_couchant-_INV4715_rwk.webp'),
(5, 2, 2, 'Desarrollo del comercio transatlántico y la ruta de Manila-Acapulco.', '/assets/icons/moneda.svg', '/img/moderna/fondo.webp'),
(6, 2, 3, 'Difusión de la lengua española, el cristianismo y la cultura europea en América y Asia.', '/assets/icons/corona.png', '/img/moderna/Lorrain.seaport.webp'),
(7, 3, 1, 'Fundación de Santiago del Nuevo Extremo en 1541 y consolidación de la conquista.', '/assets/icons/bandera.svg', NULL),
(8, 3, 2, 'Organización colonial con instituciones como la Real Audiencia y el sistema de encomiendas.', '/assets/icons/gobierno.svg', NULL),
(9, 3, 3, 'Resistencia en la Guerra de Arauco y defensa de la frontera del río Biobío frente al territorio mapuche.', '/assets/icons/arma.svg', NULL),
(10, 4, 1, 'Independencia proclamada en 1821 y consolidación republicana.', '/assets/icons/bandera.svg', NULL),
(11, 4, 2, 'Recuperación del legado cultural y arqueológico del Tahuantinsuyo.', '/assets/icons/inca.svg', NULL),
(12, 4, 3, 'Crecimiento económico sostenido basado en minería y servicios.', '/assets/icons/moneda.svg', NULL),
(13, 5, 1, 'Independencia de Chile en 1818 y consolidación del Estado nacional.', '/assets/icons/bandera.svg', NULL),
(14, 5, 2, 'Expansión territorial hacia el sur y el norte durante el siglo XIX.', '/assets/icons/subway--world-1.svg', NULL),
(15, 5, 3, 'Modernización económica con la minería del cobre.', '/assets/icons/moneda.svg', NULL),
(16, 6, 1, 'Constitución democrática de 1978 y transición a la democracia.', '/assets/icons/gobierno.svg', NULL),
(17, 6, 2, 'Integración europea y apertura económica.', '/assets/icons/subway--world-1.svg', NULL),
(18, 6, 3, 'Difusión de la lengua y la cultura hispánicas en el mundo.', '/assets/icons/corona.png', NULL),
(19, 7, 1, 'Independencia en 1830 y creación de la República del Ecuador.', '/assets/icons/bandera.svg', NULL),
(20, 7, 2, 'Rica biodiversidad en Galápagos y la Amazonía.', '/assets/icons/trigo.svg', NULL),
(21, 7, 3, 'Economía petrolera y agrícola.', '/assets/icons/moneda.svg', NULL),
(22, 8, 1, 'Independencia en 1825 y nacimiento del Estado plurinacional.', '/assets/icons/bandera.svg', NULL),
(23, 8, 2, 'Herencia cultural del altiplano y el antiguo Tahuantinsuyo.', '/assets/icons/inca.svg', NULL),
(24, 8, 3, 'Recursos naturales como el gas y la minería.', '/assets/icons/moneda.svg', NULL),
(25, 9, 1, 'Independencia en 1816 y organización federal.', '/assets/icons/bandera.svg', NULL),
(26, 9, 2, 'Consolidación agrícola y ganadera de la pampa.', '/assets/icons/trigo.svg', NULL),
(27, 9, 3, 'Desarrollo industrial y cultural del siglo XX.', '/assets/icons/gobierno.svg', NULL),
(28, 10, 1, 'Independencia en 1810 y consolidación republicana.', '/assets/icons/bandera.svg', NULL),
(29, 10, 2, 'Producción mundial de café y flores.', '/assets/icons/trigo.svg', NULL),
(30, 10, 3, 'Diversidad geográfica entre Andes, Caribe y Pacífico.', '/assets/icons/subway--world-1.svg', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `paises_acontecimientos`
--

CREATE TABLE `paises_acontecimientos` (
  `id` int NOT NULL,
  `pais_id` int NOT NULL,
  `orden` tinyint NOT NULL,
  `texto` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `paises_acontecimientos`
--

INSERT INTO `paises_acontecimientos` (`id`, `pais_id`, `orden`, `texto`) VALUES
(1, 2, 0, 'Origen'),
(2, 2, 1, 'Termino'),
(3, 3, 0, 'Fundación de Santiago del Nuevo Extremo'),
(4, 3, 1, 'Proceso de independencia de Chile');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `paises_territorios`
--

CREATE TABLE `paises_territorios` (
  `id` int NOT NULL,
  `pais_id` int NOT NULL,
  `iso` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `orden` tinyint NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `paises_territorios`
--

INSERT INTO `paises_territorios` (`id`, `pais_id`, `iso`, `orden`) VALUES
(1, 1, 'PE', 1),
(2, 1, 'EC', 2),
(3, 1, 'BO', 3),
(4, 1, 'CL', 4),
(5, 1, 'AR', 5),
(6, 1, 'CO', 6),
(7, 2, 'ES', 1),
(8, 2, 'MX', 2),
(9, 2, 'GT', 3),
(10, 2, 'SV', 4),
(11, 2, 'HN', 5),
(12, 2, 'NI', 6),
(13, 2, 'CR', 7),
(14, 2, 'PA', 8),
(15, 2, 'CO', 9),
(16, 2, 'VE', 10),
(17, 2, 'EC', 11),
(18, 2, 'PE', 12),
(19, 2, 'BO', 13),
(20, 2, 'CL', 14),
(21, 2, 'AR', 15),
(22, 2, 'UY', 16),
(23, 2, 'PY', 17),
(24, 2, 'CU', 18),
(25, 2, 'DO', 19),
(26, 2, 'PR', 20),
(27, 2, 'PH', 21),
(28, 3, 'CL', 1),
(29, 4, 'PE', 1),
(30, 5, 'CL', 1),
(31, 6, 'ES', 1),
(32, 7, 'EC', 1),
(33, 8, 'BO', 1),
(34, 9, 'AR', 1),
(35, 10, 'CO', 1);

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
  `pais_id` int NOT NULL,
  `fecha_obtenida` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuario_paises`
--

INSERT INTO `usuario_paises` (`id`, `user_id`, `pais_id`, `fecha_obtenida`) VALUES
(13, 1, 2, '2026-07-22 18:34:46'),
(14, 1, 3, '2026-07-22 19:20:45'),
(15, 1, 1, '2026-07-28 05:19:54');

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
-- Indices de la tabla `paises`
--
ALTER TABLE `paises`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`);

--
-- Indices de la tabla `paises_acontecimientos`
--
ALTER TABLE `paises_acontecimientos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pais_id` (`pais_id`);

--
-- Indices de la tabla `paises_logros`
--
ALTER TABLE `paises_logros`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pais_id` (`pais_id`);

--
-- Indices de la tabla `paises_territorios`
--
ALTER TABLE `paises_territorios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `pais_iso` (`pais_id`,`iso`),
  ADD KEY `pais_id` (`pais_id`);

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
  ADD KEY `user_id` (`user_id`),
  ADD KEY `pais_id` (`pais_id`);

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
-- AUTO_INCREMENT de la tabla `paises`
--
ALTER TABLE `paises`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `paises_acontecimientos`
--
ALTER TABLE `paises_acontecimientos`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `paises_logros`
--
ALTER TABLE `paises_logros`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT de la tabla `paises_territorios`
--
ALTER TABLE `paises_territorios`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

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
  ADD CONSTRAINT `usuario_paises_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `usuario_paises_ibfk_2` FOREIGN KEY (`pais_id`) REFERENCES `paises` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `paises_acontecimientos`
--
ALTER TABLE `paises_acontecimientos`
  ADD CONSTRAINT `paises_acontecimientos_ibfk_1` FOREIGN KEY (`pais_id`) REFERENCES `paises` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `paises_logros`
--
ALTER TABLE `paises_logros`
  ADD CONSTRAINT `paises_logros_ibfk_1` FOREIGN KEY (`pais_id`) REFERENCES `paises` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `paises_territorios`
--
ALTER TABLE `paises_territorios`
  ADD CONSTRAINT `paises_territorios_ibfk_1` FOREIGN KEY (`pais_id`) REFERENCES `paises` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `xp_historial`
--
ALTER TABLE `xp_historial`
  ADD CONSTRAINT `xp_historial_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
