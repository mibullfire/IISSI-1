-- queries


-- La estructura de los Update ha de ser:
/*
UPDATE <nombre de la tabla>
	SET <nombre columna>=<informacion nueva>
	WHERE <condicion> nota: si no ponemos condicion se cambian todos los datos de la tabla.
*/
UPDATE students
	SET birthdate='1998-01-01', surname='Fernández'
	WHERE studentId=3;
	
UPDATE subjects
	SET credits = credits/2;
	
-- La estructura de los Delete ha de ser:
/*
DELETE FROM <nombre de la tabla>
	WHERE <condicion> buscamos cual queremos cambiar, lo suyo es hacerlo por la clave primaria, y asi borramos esa fila entera.
*/
DELETE FROM Grades
	WHERE gradeId = 1;
	
	
-- Datos con SELECT
SELECT firstname, surname FROM Students
	WHERE accessMethod = 'Selectividad';
	
SELECT subjectId, credits, credits+2
	FROM Subjects
	WHERE credits>3;
	
SELECT AVG(credits), SUM(credits), COUNT(*) -- el comodin solo se puede usar dentro del count, en avg y sum he de especificar el nombre de la columna
	FROM Subjects;
	
SELECT COUNT(*)
	FROM Subjects
	WHERE credits > 4;
	
SELECT COUNT(DISTINCT accessMethod)
	FROM Students;
	
CREATE OR REPLACE VIEW ViewGradesGroup18 AS
	(SELECT * FROM Grades WHERE groupId = 18);
	
SELECT * FROM ViewGradesGroup18;

SELECT * FROM Subjects WHERE acronym='FP';

SELECT name, acronym FROM Subjects;

SELECT *
	FROM Students
	WHERE (MONTH(birthdate) >= 1 AND MONTH(birthdate) <= 2);

SELECT * FROM
	GroupsStudents JOIN Groups ON (GroupsStudents.groupId = Groups.groupId)
	JOIN Students ON (GroupsStudents.studentId = Students.studentId);
	
SELECT *
	FROM Subjects JOIN Degrees ON (Subjects.degreeId = Degrees.degreeId);

-- ---------------------------------------------------------------------------
SELECT * 
	FROM Degrees NATURAL JOIN Subjects;  -- No entiendo porque no funciona el natural join, pero si el join con condicion:
	
SELECT * 
FROM Degrees
JOIN Subjects ON Degrees.degreeId = Subjects.degreeId;



	

SELECT firstName, surname, AVG(value)
	FROM Grades JOIN Students ON (Grades.studentId = Students.studentId)
	GROUP BY Grades.studentId;
	
SELECT gradeCall, Subjects.name, AVG(value)
	FROM Grades JOIN Groups ON (Grades.groupId = Groups.groupId)
	JOIN Subjects ON (Groups.subjectId = Subjects.subjectId)
	WHERE (Grades.value >= 5 AND Groups.year = 2018) -- Nota: el where SIEMPRE ha de ir antes del group by
	GROUP BY gradeCall, Groups.subjectId;
	
CREATE OR REPLACE VIEW ViewSubjectGrades AS
	SELECT Students.studentId, Students.firstName, Students.surname,
	Subjects.subjectId, Subjects.name,
	Grades.value, Grades.gradeCall,
	Groups.year
	FROM Students
	JOIN Grades ON (Students.studentId = Grades.studentId)
	JOIN Groups ON (Grades.groupId = Groups.groupId)
	JOIN Subjects ON (Groups.subjectId = Subjects.subjectId);
	
SELECT * FROM ViewSubjectGrades;

SELECT name, AVG(value)
	FROM ViewSubjectGrades
	GROUP BY subjectId
	HAVING COUNT(*) > 2; -- Con esto nos aseguramos que al menos halla 3 apariencias o mas 