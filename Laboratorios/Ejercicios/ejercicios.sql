-- En este archivo se recogen los ejercicios propuestos en el boletín del laboratorio

-- Ejercicios del Laboratorio 3:

-- Nombre de las asignaturas que son obligatorias:
SELECT name FROM Subjects WHERE type='Obligatoria';

-- Media de las notas del grupo con id 19:
SELECT AVG(value) media FROM Grades WHERE groupId=18; -- he usado 18 porque no tengo valores del grupo 19

-- Los mismo sin avg
SELECT SUM(value) / COUNT(*) media FROM Grades WHERE groupId=18;

-- Cantidad de nombres de grupos diferentes:
SELECT COUNT(DISTINCT name) nombresDistintos FROM Groups;

-- Notas entre 4 y 6, ambas inclusive:
SELECT value FROM Grades WHERE (value BETWEEN 4 and 6);

-- Notas con valor igual o superior a 9 sin matricula de honor en una vista:
CREATE OR REPLACE VIEW notasAltasSinMatricula AS
	SELECT * FROM Grades WHERE (value >= 9 and withHonours=0);
	
SELECT * FROM notasAltasSinMatricula;


-- Ejercicios del Laboratorio 4:

-- Número de suspensos de cada alumno dando nombre y apellidos:
SELECT firstname Nombre, surname Apellido, COUNT(*) Suspensos FROM Students NATURAL JOIN Grades
	WHERE value < 5
	GROUP BY firstname, surname;
	
-- La tercera página de 3 grupos, ordenados segun año en orden descendente:
SELECT * FROM Groups
	ORDER BY year DESC
	LIMIT 5 OFFSET 10; -- con esto creamos una paginacion
	
-- Un listado de los grupos, añadiendo el acrónimo de la asignatura a la que pertenecen y el nombre del grado.
SELECT G.name Grupo, S.acronym Acronimo, S.name NombreGrado FROM Groups G
	JOIN Subjects S ON (G.subjectId = S.subjectId);
	
-- Número de métodos de acceso diferentes de los alumnos de cada grupo, dando el id del grupo.
SELECT G.groupId ID, G.name Nombre, COUNT(DISTINCT S.accessMethod) Accesos FROM Groups G NATURAL JOIN Students S
	GROUP BY groupId;

-- Nota ponderada por créditos de cada alumno, dando nombre y apellidos, del curso 2019 en la primera convocatoria.
SELECT S.firstName, S.surname, SUM(G.value * A.credits) / SUM(A.credits) AS weightedGrade
FROM Grades G NATURAL JOIN  Students S NATURAL JOIN Groups X NATURAL JOIN Subjects A
WHERE G.gradeCall = 1 AND X.year = 2019
GROUP BY S.firstName, S.surname;

-- mucha paranoia lo de la nota ponderada.