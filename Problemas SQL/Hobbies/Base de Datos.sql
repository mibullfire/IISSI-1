/* Crear la Base de Datos */
CREATE OR REPLACE DATABASE hobbies
CHARACTER SET = utf8 COLLATE = 'utf8_general_ci';
USE hobbies;
/* Definición de tablas */
CREATE OR REPLACE TABLE personas (
idPersona INTEGER KEY,
persona VARCHAR(20) );
CREATE OR REPLACE TABLE hobbies (
hobby VARCHAR(20) KEY
);
CREATE OR REPLACE TABLE aficiones (
idPersona INTEGER,
hobby VARCHAR(20),
PRIMARY KEY(idPersona,hobby),
FOREIGN KEY(idPersona)
REFERENCES personas (idPersona),
FOREIGN KEY(hobby) REFERENCES hobbies (hobby)
);

/* Escenario de prueba */
INSERT INTO Personas VALUES
(1,'Ana'),
(2,'Pedro'),
(3,'Joaquín'),
(4,'Luisa'),
(5,'Amorfo');
INSERT INTO Hobbies VALUES
('Cine'),
('Lectura'),
('Fútbol'),
('Tenis'),
('Senderismo');
INSERT INTO Aficiones VALUES
(1,'Cine'),
(2,'Lectura'),(2,'Fútbol'),
(3,'Tenis'),(3,'Senderismo'),
(4,'Cine'),(4,'Lectura'),
(4,'Fútbol'),(4,'Tenis'),
(4,'Senderismo');