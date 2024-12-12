-- Creación de la base de datos
CREATE DATABASE IF NOT EXISTS OleoDB;
USE OleoDB;

-- Tabla: Aceitunas
CREATE TABLE Aceituna (
    id INT AUTO_INCREMENT PRIMARY KEY,
    variedad VARCHAR(50) NOT NULL,
    descripcion TEXT,
    UNIQUE (variedad) -- Cada variedad de aceituna debe ser única
);

-- Tabla: Aceite
CREATE TABLE Aceite (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    tipoAceite ENUM('Virgen', 'Extra', 'Lampante') NOT NULL,
    aceituna_id INT NOT NULL,
    descripcion TEXT,
    CONSTRAINT fk_aceituna FOREIGN KEY (aceituna_id) REFERENCES Aceituna(id) ON DELETE CASCADE,
    CONSTRAINT ck_tipoAceite CHECK (tipoAceite IN ('Virgen', 'Extra', 'Lampante')),
    UNIQUE (nombre, tipoAceite) -- Restricción para evitar duplicados de aceites con el mismo nombre y tipo
);

-- Tabla: Marca
CREATE TABLE Marca (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    paisOrigen VARCHAR(50),
    añoFundacion YEAR NOT NULL,
    UNIQUE (nombre, paisOrigen) -- Una marca debe ser única por nombre y país
);

-- Tabla: Relación entre Marca y Aceite
CREATE TABLE MarcaAceite (
    marca_id INT,
    aceite_id INT,
    PRIMARY KEY (marca_id, aceite_id),
    FOREIGN KEY (marca_id) REFERENCES Marca(id) ON DELETE CASCADE,
    FOREIGN KEY (aceite_id) REFERENCES Aceite(id) ON DELETE CASCADE
);

-- Carga inicial de datos
-- Insertando aceitunas
INSERT INTO Aceituna (variedad, descripcion)
VALUES
    ('Picual', 'Aceituna de sabor intenso y alta estabilidad.'),
    ('Hojiblanca', 'Aceituna de sabor suave y equilibrado.'),
    ('Arbequina', 'Aceituna pequeña y de sabor afrutado.');

-- Insertando aceites
INSERT INTO Aceite (nombre, tipoAceite, aceituna_id, descripcion)
VALUES
    ('Aceite Virgen Extra', 'Extra', 1, 'Aceite de alta calidad, sabor intenso.'),
    ('Aceite Virgen', 'Virgen', 2, 'Sabor equilibrado y afrutado.'),
    ('Aceite Lampante', 'Lampante', 3, 'No apto para consumo directo.');

-- Insertando marcas
INSERT INTO Marca (nombre, paisOrigen, añoFundacion)
VALUES 
    ('OleoHispania', 'España', 1985),
    ('AndalusOliva', 'España', 1975),
    ('MediterraneanGold', 'Italia', 1990);

-- Relación Marca-Aceite
INSERT INTO MarcaAceite (marca_id, aceite_id)
VALUES
    (1, 1),
    (1, 2),
    (2, 3),
    (3, 1);

-- Consultas para validar datos
SELECT * FROM Aceituna;
SELECT * FROM Aceite;
SELECT * FROM Marca;
SELECT * FROM MarcaAceite;