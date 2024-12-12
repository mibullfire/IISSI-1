-- Nuevas marcas (incluyendo todas las denominaciones disponibles)
INSERT INTO Marcas(marca, denominacion) VALUES
    ('La Laguna', 'Sierra Cazorla'),
    ('El Convento', 'Baena'),
    ('La Almazara', 'Sierra Cádiz'),
    ('Olivar de la Luna', 'Sierra Cazorla'),
    ('Aceites del Sur', 'Baena');

-- Nuevos aceites (Asegúrate del orden para conocer los marcaID asignados)
-- Suponiendo que:
-- 1: Núñez de Prado (Baena)
-- 2: Oro en Rama (Sierra Cádiz)
-- 3: La Laguna (Sierra Cazorla)
-- 4: El Convento (Baena)
-- 5: La Almazara (Sierra Cádiz)
-- 6: Olivar de la Luna (Sierra Cazorla)
-- 7: Aceites del Sur (Baena)

-- Para la marca La Laguna (3)
INSERT INTO AceitesOliva(marcaID, aceite, tipoAceite) VALUES
    (3, 'La Laguna Virgen Extra', 'AOV'),
    (3, 'La Laguna Suave', 'AO');

-- Para la marca El Convento (4)
INSERT INTO AceitesOliva(marcaID, aceite, tipoAceite) VALUES
    (4, 'El Convento Tradicional', 'AOO'),
	 (4, 'El Convento Meridional', 'AOV');

-- Para la marca La Almazara (5)
INSERT INTO AceitesOliva(marcaID, aceite, tipoAceite) VALUES
    (5, 'La Almazara Premium', 'AOV'),
    (5, 'La Almazara Selección', 'AO'),
    (5, 'La Almazara Ligero', 'AOO');
