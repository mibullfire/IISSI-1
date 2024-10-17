-- Volcando estructura de base de datos para grados
DROP DATABASE IF EXISTS `grados`;
CREATE DATABASE IF NOT EXISTS `grados`;
USE `grados`;

-- Volcando estructura para tabla grados.asignaturas
DROP TABLE IF EXISTS `asignaturas`;
CREATE TABLE IF NOT EXISTS `asignaturas` (
	`asignaturaId` int(11) NOT NULL AUTO_INCREMENT,
	`curso` int(11) DEFAULT NULL,
	`nombre` varchar(255) COLLATE latin1_spanish_ci NOT NULL,
	`codigo` varchar(7) COLLATE latin1_spanish_ci NOT NULL,
	`creditos` int(11) NOT NULL,
	`tipo` enum('Formación Básica','Obligatoria','Optativa','Trabajo fin de grado') COLLATE latin1_spanish_ci NOT NULL,
	`departamento` varchar(255) COLLATE latin1_spanish_ci NOT NULL,
	`vigencia` tinyint(1) NOT NULL DEFAULT 1,
	PRIMARY KEY (`asignaturaId`)
);

-- Volcando estructura para procedimiento grados.spInsertarAsignatura
DROP PROCEDURE IF EXISTS `spInsertarAsignatura`;
DELIMITER //
CREATE PROCEDURE `spInsertarAsignatura`(
	IN `curso` INT,
	IN `nombre` VARCHAR(255),
	IN `codigo` VARCHAR(7),
	IN `creditos` INT,
	IN `tipo` VARCHAR(31),
	IN `departamento` VARCHAR(255),
	IN `vigencia` TINYINT
	)
BEGIN
	INSERT INTO asignaturas(curso, nombre, codigo, creditos, tipo, departamento, vigencia)
	VALUES (curso, nombre, codigo, creditos, tipo, departamento, vigencia);
END//
DELIMITER ;

-- Volcando estructura para procedimiento grados.spInsertarDatosAsignaturas
DROP PROCEDURE IF EXISTS `spInsertarDatosAsignaturas`;
DELIMITER //
CREATE PROCEDURE `spInsertarDatosAsignaturas`()
BEGIN
CALL spInsertarAsignatura('1', 'Álgebra Lineal y Numérica', '2060006', '6', 'Formación Básica', 'MATEMÁTICA APLICADA I', '1');
CALL spInsertarAsignatura('1', 'Cálculo Infinitesimal y Numérico', '2060003', '6', 'Formación Básica', 'MATEMÁTICA APLICADA I', '1');
CALL spInsertarAsignatura('1', 'Administración de Empresas', '2060002', '6', 'Formación Básica', 'ORGANIZACIÓN INDUSTRIAL Y GESTIÓN DE EMPRESAS I', '1');
CALL spInsertarAsignatura('1', 'Circuitos Electrónicos Digitales', '2060004', '6', 'Formación Básica', 'TECNOLOGÍA ELECTRÓNICA', '1');
CALL spInsertarAsignatura('1', 'Estadística', '2060007', '6', 'Formación Básica', 'ESTADÍSTICA E INVESTIGACIÓN OPERATIVA', '1');
CALL spInsertarAsignatura('1', 'Estructura de Computadores', '2060008', '6', 'Formación Básica', 'TECNOLOGÍA ELECTRÓNICA', '1');
CALL spInsertarAsignatura('1', 'Fundamentos de Programación', '2060001', '12', 'Formación Básica', 'LENGUAJES Y SISTEMAS INFORMÁTICOS', '1');
CALL spInsertarAsignatura('1', 'Fundamentos Físicos de la Informática', '2060009', '6', 'Formación Básica', 'FÍSICA APLICADA I', '1');
CALL spInsertarAsignatura('1', 'Introducción a la Matemática Discreta', '2060005', '6', 'Formación Básica', 'MATEMÁTICA APLICADA I', '1');
CALL spInsertarAsignatura('2', 'Análisis y Diseño de Datos y Algoritmos', '2060010', '12', 'Obligatoria', 'LENGUAJES Y SISTEMAS INFORMÁTICOS', '1');
CALL spInsertarAsignatura('2', 'Lógica Informática', '2060012', '6', 'Optativa', 'CIENCIAS DE LA COMPUTACIÓN E INTELIGENCIA ARTIFICIAL', '1');
CALL spInsertarAsignatura('2', 'Matemática Discreta', '2060013', '6', 'Obligatoria', 'MATEMÁTICA APLICADA I', '1');
CALL spInsertarAsignatura('2', 'Redes de Computadores', '2060014', '6', 'Obligatoria', 'TECNOLOGÍA ELECTRÓNICA', '1');
CALL spInsertarAsignatura('2', 'Arquitectura de Computadores', '2060015', '6', 'Obligatoria', 'ARQUITECTURA Y TECNOLOGÍA DE COMPUTADORES', '1');
CALL spInsertarAsignatura('2', 'Arquitectura de Redes', '2060016', '6', 'Optativa', 'TECNOLOGÍA ELECTRÓNICA', '1');
CALL spInsertarAsignatura('2', 'Sistemas Operativos', '2060017', '6', 'Obligatoria', 'LENGUAJES Y SISTEMAS INFORMÁTICOS', '1');
CALL spInsertarAsignatura('2', 'Introducción a la Ingeniería del Software y los Sistemas de Información I', '2060054', '6', 'Obligatoria', 'LENGUAJES Y SISTEMAS INFORMÁTICOS', '1');
CALL spInsertarAsignatura('2', 'Introducción a la Ingeniería del Software y los Sistemas de Información II', '2060055', '6', 'Obligatoria', 'LENGUAJES Y SISTEMAS INFORMÁTICOS', '1');
CALL spInsertarAsignatura('3', 'Configuración Implementación y Mantenimiento de Sistemas Informáticos', '2060018', '6', 'Optativa', 'ARQUITECTURA Y TECNOLOGÍA DE COMPUTADORES', '1');
CALL spInsertarAsignatura('3', 'Gestión de Sistemas de Información', '2060019', '6', 'Optativa', 'LENGUAJES Y SISTEMAS INFORMÁTICOS', '1');
CALL spInsertarAsignatura('3', 'Gestión y Estrategia Empresarial', '2060020', '6', 'Optativa', 'ORGANIZACIÓN INDUSTRIAL Y GESTIÓN DE EMPRESAS I', '1');
CALL spInsertarAsignatura('3', 'Inteligencia Artificial', '2060021', '6', 'Obligatoria', 'CIENCIAS DE LA COMPUTACIÓN E INTELIGENCIA ARTIFICIAL', '1');
CALL spInsertarAsignatura('3', 'Procesadores de Lenguajes', '2060022', '6', 'Optativa', 'LENGUAJES Y SISTEMAS INFORMÁTICOS', '1');
CALL spInsertarAsignatura('3', 'Programación Declarativa', '2060023', '6', 'Optativa', 'CIENCIAS DE LA COMPUTACIÓN E INTELIGENCIA ARTIFICIAL', '1');
CALL spInsertarAsignatura('3', 'Tecnologías Avanzadas de la Información', '2060024', '6', 'Optativa', 'TECNOLOGÍA ELECTRÓNICA', '1');
CALL spInsertarAsignatura('3', 'Ampliación de Inteligencia Artificial', '2060025', '6', 'Optativa', 'CIENCIAS DE LA COMPUTACIÓN E INTELIGENCIA ARTIFICIAL', '1');
CALL spInsertarAsignatura('3', 'Arquitectura de Sistemas Distribuidos', '2060026', '6', 'Optativa', 'ARQUITECTURA Y TECNOLOGÍA DE COMPUTADORES', '1');
CALL spInsertarAsignatura('3', 'Matemática Aplicada a Sistemas de Información', '2060027', '6', 'Optativa', 'MATEMÁTICA APLICADA I', '1');
CALL spInsertarAsignatura('3', 'Sistemas de Información Empresiales', '2060028', '6', 'Optativa', 'LENGUAJES Y SISTEMAS INFORMÁTICOS', '1');
CALL spInsertarAsignatura('3', 'Sistemas Inteligentes', '2060029', '6', 'Optativa', 'CIENCIAS DE LA COMPUTACIÓN E INTELIGENCIA ARTIFICIAL', '1');
CALL spInsertarAsignatura('3', 'Sistemas Orientados a Servicios', '2060030', '6', 'Optativa', 'LENGUAJES Y SISTEMAS INFORMÁTICOS', '1');
CALL spInsertarAsignatura('4', 'Prácticas Externas', '2060031', '6', 'Optativa', 'LENGUAJES Y SISTEMAS INFORMÁTICOS', '1');
CALL spInsertarAsignatura('4', 'Acceso Inteligente a la Información', '2060032', '6', 'Optativa', 'LENGUAJES Y SISTEMAS INFORMÁTICOS', '1');
CALL spInsertarAsignatura('4', 'Administración de Sistemas de Información', '2060033', '6', 'Optativa', 'TECNOLOGÍA ELECTRÓNICA', '1');
CALL spInsertarAsignatura('4', 'Gestión de Procesos y Servicios', '2060034', '6', 'Optativa', 'LENGUAJES Y SISTEMAS INFORMÁTICOS', '1');
CALL spInsertarAsignatura('4', 'Infraestructura de Sistemas de Información', '2060035', '6', 'Optativa', 'TECNOLOGÍA ELECTRÓNICA', '1');
CALL spInsertarAsignatura('4', 'Integración de Sistemas Físicos e Informáticos', '2060036', '6', 'Optativa', 'FÍSICA APLICADA I', '0');
CALL spInsertarAsignatura('4', 'Interacción Persona-ordenador', '2060037', '6', 'Optativa', 'LENGUAJES Y SISTEMAS INFORMÁTICOS', '1');
CALL spInsertarAsignatura('4', 'Matemática Aplicada a Tecnologías de la Información', '2060038', '6', 'Optativa', 'MATEMÁTICA APLICADA I', '1');
CALL spInsertarAsignatura('4', 'Matemáticas para la Computación', '2060039', '6', 'Optativa', 'MATEMÁTICA APLICADA I', '1');
CALL spInsertarAsignatura('4', 'Planificación y Gestión de Proyectos Informáticos', '2060040', '6', 'Obligatoria', 'MATEMÁTICA APLICADA I', '1');
CALL spInsertarAsignatura('4', 'Procesamiento de Imágenes Digitales', '2060041', '6', 'Optativa', 'MATEMÁTICA APLICADA I', '1');
CALL spInsertarAsignatura('4', 'Seguridad en Sistemas Informáticos y en Internet', '2060042', '6', 'Optativa', 'LENGUAJES Y SISTEMAS INFORMÁTICOS', '1');
CALL spInsertarAsignatura('4', 'Teledetección', '2060043', '6', 'Optativa', 'TECNOLOGÍA ELECTRÓNICA', '1');
CALL spInsertarAsignatura('4', 'Aplicaciones de Soft Computing', '2060044', '6', 'Optativa', 'ELECTRÓNICA Y ELECTROMAGNETISMO', '1');
CALL spInsertarAsignatura('4', 'Computación Móvil', '2060045', '6', 'Optativa', 'ARQUITECTURA Y TECNOLOGÍA DE COMPUTADORES', '1');
CALL spInsertarAsignatura('4', 'Criptografía', '2060046', '6', 'Optativa', 'MATEMÁTICA APLICADA I', '1');
CALL spInsertarAsignatura('4', 'Estadística Computacional', '2060047', '6', 'Optativa', 'ESTADÍSTICA E INVESTIGACIÓN OPERATIVA', '1');
CALL spInsertarAsignatura('4', 'Gestión de la Producción', '2060048', '6', 'Optativa', 'ORGANIZACIÓN INDUSTRIAL Y GESTIÓN DE EMPRESAS I', '1');
CALL spInsertarAsignatura('4', 'Inteligencia Empresarial', '2060049', '6', 'Optativa', 'LENGUAJES Y SISTEMAS INFORMÁTICOS', '1');
CALL spInsertarAsignatura('4', 'Modelado y Análisis de Requisitos en Sistemas de Información', '2060050', '6', 'Optativa', 'LENGUAJES Y SISTEMAS INFORMÁTICOS', '1');
CALL spInsertarAsignatura('4', 'Modelos de Computación y Complejidad', '2060051', '6', 'Optativa', 'CIENCIAS DE LA COMPUTACIÓN E INTELIGENCIA ARTIFICIAL', '1');
CALL spInsertarAsignatura('4', 'Tecnología Informática y Sociedad', '2060052', '6', 'Optativa', 'TECNOLOGÍA ELECTRÓNICA', '1');
CALL spInsertarAsignatura('4', 'Trabajo Fin de Grado', '2060053', '12', 'Trabajo fin de grado', 'TECNOLOGÍA ELECTRÓNICA', '1');
END//
DELIMITER ;

/* Inserción de datos */
CALL spInsertarDatosAsignaturas();