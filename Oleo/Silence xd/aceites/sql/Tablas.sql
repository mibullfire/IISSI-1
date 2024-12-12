-- Creación de la base de datos:
CREATE DATABASE IF NOT EXISTS OleoDB;
USE OleoDB;

-- Eliminación de tablas existentes si las hay, para evitar conflictos:
DROP TABLE IF EXISTS AceiteOliva;
DROP TABLE IF EXISTS Aceituna;
DROP TABLE IF EXISTS Marca;
DROP TABLE IF EXISTS DenominacionOrigen;

-- Tabla: DenominacionOrigen
CREATE TABLE DenominacionOrigen (
	denominacionID INT AUTO_INCREMENT KEY, 
	denominacion VARCHAR(50) NOT NULL UNIQUE 
);

-- Tabla: Marca
CREATE TABLE Marca (
	marcaID INT AUTO_INCREMENT PRIMARY KEY, 
	marca VARCHAR(30) NOT NULL UNIQUE,
	denominacionID INT,
	FOREIGN KEY (denominacionID) REFERENCES DenominacionOrigen(denominacionID)
);

-- Tabla: Aceituna
CREATE TABLE Aceituna (
	aceitunaID INT AUTO_INCREMENT PRIMARY KEY,
	aceituna VARCHAR(50) NOT NULL UNIQUE
);

-- Tabla: AceiteOliva
CREATE OR REPLACE TABLE AceiteOliva (
	aceiteID INT AUTO_INCREMENT PRIMARY KEY,
	aceite VARCHAR(50) NOT NULL,
	tipoAceite ENUM('AO', 'AOO', 'AOV') NOT NULL,
	acidez DECIMAL(2,1) CHECK (acidez > 0),
	precioLitro DECIMAL(5,2) CHECK (precioLitro >= 0),
	marcaID INT,
	aceitunaID INT,
	FOREIGN KEY (marcaID) REFERENCES Marca (marcaID),
	FOREIGN KEY (aceitunaID) REFERENCES Aceituna(aceitunaID),
	CONSTRAINT Rn0c CHECK (tipoAceite <> 'AOO' OR acidez > 1),
	CONSTRAINT Rn0d CHECK (tipoAceite = 'AOV' OR aceitunaID IS NULL)
);