DROP TABLE IF EXISTS AceitesOliva;
DROP TABLE IF EXISTS Marcas;

CREATE OR REPLACE TABLE Marcas(
	marcaId INT AUTO_INCREMENT KEY,
	DO ENUM('Baena', 'Sierra Cádiz', 'Sierra Cazorla'),
	marca VARCHAR(30)
);
CREATE OR REPLACE TABLE AceitesOliva(
	aceiteId INT AUTO_INCREMENT KEY, -- es lo mismo que primary key
	marcaId INT NOT NULL,
	aceite VARCHAR(50) UNIQUE,
	tipoAceite ENUM('AOV','AO','AOO'), -- Clasificación aceitestipoAceite ENUM('AOV','AO','AOO'), -- Clasificación aceites
	FOREIGN KEY (marcaId) REFERENCES Marcas(marcaId),
	CONSTRAINT RN_1 UNIQUE(marcaId,tipoAceite)
);

INSERT INTO marcas (marca, DO) VALUES
	('Núñez de Prado','Baena'),('Oro en Rama', 'Sierra Cádiz');
	
INSERT INTO aceitesoliva(marcaId, aceite, tipoAceite) VALUES
	(1, 'Oliva Virgen Extra Núñez de Prado', 'AOV'),
	(1, 'Oliva Virgen Oro en Rama', 'AO');
	
DELIMITER //
CREATE OR REPLACE TRIGGER RN_2_d BEFORE DELETE ON aceitesoliva FOR EACH ROW
BEGIN
SIGNAL SQLSTATE'45000' SET MESSAGE_TEXT = 'RN_2_d No se permite borrar instancias
de Aceites de Oliva';
END//
DELIMITER ;