/*
Ejercicios generados con ChatGPT
*/

-- Nivel Básico
-- Seleccionar todas las filas de la tabla Marcas.

SELECT * FROM Marcas;

-- Seleccionar todos los aceites de oliva (tabla AceitesOliva) con su tipo.

SELECT aceite, tipoAceite FROM AceitesOliva;

-- Seleccionar solamente los aceites de tipo ‘AOV’.

SELECT * FROM AceitesOliva WHERE tipoAceite = 'AOV';

-- Seleccionar el nombre del aceite y la denominación de su marca, haciendo el JOIN apropiado.

SELECT aceite, denominacion FROM AceitesOliva O JOIN Marcas M ON O.marcaID = M.marcaID;

-- Nivel Intermedio
-- Mostrar el aceite y el nombre de la marca de aquellos aceites que no sean de tipo AOV.

SELECT aceite, marca FROM (
SELECT * FROM AceitesOliva NATURAL JOIN Marcas WHERE tipoAceite = 'AOV') X;

-- Contar cuántos aceites de cada tipo existen.

SELECT tipoAceite Tipo, COUNT(*) Cuenta FROM AceitesOliva GROUP BY tipoAceite;

-- Mostrar el aceite y el nombre de la marca de aquellos aceites que no sean de tipo AOV.

SELECT aceite, marca FROM AceitesOliva NATURAL JOIN Marcas
EXCEPT
SELECT aceite, marca FROM AceitesOliva NATURAL JOIN Marcas WHERE tipoAceite = 'AOV';

-- Actualizar el nombre de un aceite (por ejemplo, cambiar ‘Oliva Oro en Rama’ a ‘Oliva Oro de Cádiz’).
UPDATE AceitesOliva
SET aceite = 'Oliva Oro de Cádiz'
WHERE aceite = 'La Almazara Ligero';

-- Nivel Avanzado
-- Obtener las Marcas que tengan aceites de todos los tipos existentes en la tabla (AOV, AO, AOO). 
SELECT marca FROM Marcas M WHERE NOT EXISTS (
	SELECT tipoAceite FROM AceitesOliva T WHERE NOT EXISTS(
		SELECT * FROM AceitesOliva A WHERE
			A.marcaID = M.marcaID AND A.tipoAceite = T.tipoAceite));
			
-- Obtener las marcas que tienen exactamente un tipo de aceite asociado.
SELECT tipoAceite,COUNT(*) C FROM AceitesOliva NATURAL JOIN Marcas
GROUP BY tipoAceite
HAVING C = 2; -- He cogido dos porque he modificado la BD y no hay ninguno con 1.