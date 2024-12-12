DROP TABLE IF EXISTS AceitesOliva;
DROP TABLE IF EXISTS Marcas;

CREATE TABLE Marcas(
	marcaID INT AUTO_INCREMENT KEY,
	denominacion ENUM('Baena', 'Sierra Cádiz', 'Sierra Cazorla'),
	marca VARCHAR(30)
);

CREATE TABLE AceitesOliva(
	aceiteID INT AUTO_INCREMENT KEY,
	marcaID INT NOT NULL,
	aceite VARCHAR(30) UNIQUE,
	tipoAceite ENUM('AOV', 'AO', 'AOO'),
	FOREIGN KEY (marcaID) REFERENCES Marcas (marcaID),
	CONSTRAINT RN_1 UNIQUE (marcaID, tipoAceite)
);