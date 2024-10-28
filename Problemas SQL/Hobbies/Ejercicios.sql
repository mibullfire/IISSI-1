-- Ejercicios

-- ¿Lista de Hobbies?
SELECT * FROM Hobbies;

-- ¿Lista de Nombres de Personas?
SELECT * FROM Personas;

-- ¿Nombres de Personas y sus Aficiones?
SELECT persona, hobby FROM Aficiones NATURAL JOIN Personas; -- Usamos un NATURAL JOIN para buscar la intersección entre ambas

-- ¿Personas a las que les gusta el tenis?

SELECT persona FROM Aficiones NATURAL JOIN Personas
WHERE hobby = 'Tenis'; -- Ponemos una condición

-- ¿Personas que no tienen Hobbies?

-- Opción 1 (Usando el EXCEPT) Nota: está opción es más correcta puesto que estamos usando el álgebra relacional con el operador de resta
SELECT persona FROM Personas
EXCEPT
SELECT persona FROM Aficiones NATURAL JOIN Personas;

-- ó (ambas son correctas, ya depende de lo que te quieras rayar)
SELECT persona FROM personas NATURAL JOIN (
SELECT idpersona FROM Personas
EXCEPT
SELECT idpersona FROM Aficiones
) auxilio;

-- Opción 2 (Usando NOT IN)
SELECT persona FROM Personas
WHERE idpersona NOT IN (SELECT idpersona FROM Aficiones);

-- ¿Personas a quiénes les gustan todos los hobbies?

-- Contar hobbies de cada persona

SELECT idpersona, COUNT(*) FROM Aficiones
GROUP BY idpersona
HAVING COUNT(*) = 5; -- cuando agrupamos debemos de usar el having

-- Seleccionamos la persona que tiene una cuenta de 5 hobbies
SELECT persona FROM Personas WHERE idpersona =
(SELECT idpersona FROM Aficiones
GROUP BY idpersona
HAVING COUNT(*) = 5);

-- Aquí hacemos lo mismo, pero esta vez, lo hacemos consultando directamente el número de elementos en la tabla Hobbies
SELECT persona FROM Personas WHERE idpersona =
(SELECT idpersona FROM Aficiones
GROUP BY idpersona
HAVING COUNT(*) = (SELECT COUNT(*) FROM Hobbies));

-- Ahora con la forma del operador de division
SELECT persona FROM personas P
WHERE NOT EXISTS (SELECT * FROM Hobbies H
						WHERE NOT EXISTS (SELECT * FROM Aficiones A
						WHERE A.idpersona = P.idpersona
						AND A.hobby = H.hobby));

-- ¿Cuenta de Aficiones?
SELECT COUNT(*) FROM Aficiones;

-- ¿Cuenta de Aficiones distintas?
SELECT COUNT(DISTINCT hobby) FROM Aficiones;

-- ¿Cuenta de Aficiones de cada Persona?
SELECT persona, cuenta_aficiones FROM Personas
NATURAL JOIN
(SELECT idpersona, COUNT(*) AS cuenta_aficiones FROM Aficiones
GROUP BY idpersona) rompemuros;

-- otra forma:

SELECT persona,count(*) as na
FROM (Personas NATURAL JOIN Aficiones)
GROUP BY persona
ORDER BY 2 DESC;

-- ¿Máximo número de aficiones que tiene una persona?
SELECT max(aficion) FROM (SELECT COUNT(*) AS aficion FROM Aficiones GROUP BY idpersona) X;

-- ¿Persona que tiene el máximo número de aficiones?

SELECT persona FROM (Personas NATURAL JOIN Aficiones)
GROUP BY idpersona,persona
HAVING COUNT(*) = ( SELECT COUNT(*) AS na FROM Aficiones GROUP BY idpersona ORDER
BY 1 DESC LIMIT 1);
