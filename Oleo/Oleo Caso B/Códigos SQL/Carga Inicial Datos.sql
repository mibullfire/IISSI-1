-- Carga inicial de datos
INSERT INTO DenominacionOrigen (denominacion) VALUES
	('Baena'),
	('Sierra de Segura');

INSERT INTO Aceituna (aceituna) VALUES
	('Hojiblanca'),
	('Picual'),
	('Arbequina');
    
INSERT INTO Marca (marca, denominacionID) VALUES
	('Núñez Prado', 1),
	('La Española', NULL);

INSERT INTO AceiteOliva (aceite, tipoAceite, acidez, precioLitro, marcaID, aceitunaID) VALUES 
	('Oliva Virgen Extra Núñez Prado', 'AOV', 0.2, 22.5, 1, 2),
	('Aceite de Oliva Suave 0,4 La Española', 'AO', 0.4, 7.39, 2, NULL);