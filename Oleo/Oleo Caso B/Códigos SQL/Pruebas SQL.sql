-- Pruebas

-- Rn0c
-- Caso Desfavorable
INSERT INTO AceiteOliva (aceite, tipoAceite, acidez, precioLitro, marcaID, aceitunaID) VALUES 
	('Aceite Malo Malo', 'AOO', 0.2, 20, 1, 2);
-- Caso favorable
INSERT INTO AceiteOliva (aceite, tipoAceite, acidez, precioLitro, marcaID, aceitunaID) VALUES 
	('Aceite Bueno Bueno', 'AOO', 2, 20, 1, 2);
	
-- Rn0d
-- Caso Desfavorable
INSERT INTO AceiteOliva (aceite, tipoAceite, acidez, precioLitro, marcaID, aceitunaID) VALUES 
	('Aceite Malo Malo', 'AOV', 0.2, 22.5, 1, NULL);
-- Caso Favorable
INSERT INTO AceiteOliva (aceite, tipoAceite, acidez, precioLitro, marcaID, aceitunaID) VALUES 
	('Aceite Malo Malo', 'AOV', 0.2, 22.5, 1, 2);