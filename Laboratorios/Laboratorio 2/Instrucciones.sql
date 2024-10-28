-- Laboratorio 3
-- INSERT INTO Degrees VALUES(NULL, 'Tecnologías Informáticas', 4);

INSERT INTO Degrees (name, years) VALUES
('Ingeniería del Software', 4),
('Ingeniería del Computadores', 4),
('Tecnologías Informáticas', 4);
INSERT INTO Subjects (name, acronym, credits, year, type, degreeId) VALUES
('Fundamentos de Programación', 'FP', 12, 1,'Formacion Básica', 3),
('Lógica Informática', 'LI', 6, 2,'Optativa', 3);
INSERT INTO Groups (name, activity, year, subjectId) VALUES
('T1', 'Teoría', 2019, 1),
('L1', 'Laboratorio', 2019, 1),
('L2', 'Laboratorio', 2019, 1);
INSERT INTO Students (accessMethod, dni, firstname, surname, birthdate, email) VALUES
('Selectividad', '12345678A', 'Daniel', 'Pérez','1991-01-01', 'daniel@alum.us.es'),
('Selectividad', '22345678A','Rafael','Ramírez','1992-01-01','rafael@alum.us.es'),
('Selectividad','32345678A','Gabriel','Hernández','1993-01-01','gabriel@alum.us.es');
INSERT INTO GroupsStudents (groupId, studentId) VALUES
(1, 1),
(3, 1);
INSERT INTO Grades (value, gradeCall, withHonours, studentId, groupId) VALUES
(4.50, 1, 0, 1, 1);


-- UPDATE
UPDATE Students
	SET birthdate = '1998-01-01', surname='Fernández'
	WHERE studentId=3; -- Busca al estudiante con id 3, y le cambia la fecha y el apellido
	
UPDATE Subjects
	SET credits = credits/2; -- Divide todos los creditos entre dos
	

-- DALETE
DELETE FROM Grades WHERE gradeId = 1; -- Borra las filas que tengan como id 1


-- SELECT
SELECT firstname, surname
	FROM Students
	WHERE accessMethod = 'Selectividad';
	
SELECT subjectId, name, credits >3
	FROM Subjects;
	
SELECT AVG(credits), SUM(credits), name
	FROM Subjects;
	
SELECT COUNT(*)
	FROM Subjects
	WHERE credits > 4;
	
SELECT COUNT(DISTINCT accessMethod) as palabra_random
	FROM Students;
	
CREATE OR REPLACE VIEW ViewGradesGroup18 AS
	SELECT * FROM Grades WHERE groupId = 18;
	
SELECT MAX(value) FROM ViewGradesGroup18;

CREATE OR REPLACE VIEW ViewGradesGroup18Call1 AS
	SELECT * FROM ViewGradesGroup18 WHERE gradeCall = 1;


-- Ejercicios
SELECT *
	FROM Subjects
	WHERE acronym = 'FP';
	
SELECT AVG(value)
	FROM Grades
	WHERE groupId = 18;
	
SELECT SUM(credits)
	FROM Subjects
	WHERE degreeId = 3;
	
SELECT *
	FROM Grades
	WHERE value < 4 OR value > 6;
	
SELECT DISTINCT name FROM Groups;

SELECT MAX(value)
	FROM Grades
	WHERE studentId = 1;
	
SELECT *
	FROM Students
	WHERE surname IN (SELECT acronym FROM Subjects);
	
SELECT studentId
	FROM GroupsStudents
	WHERE groupId IN (SELECT groupId FROM groups WHERE year=2019);

SELECT *
	FROM Students
	WHERE dni LIKE('%C') -- El porcentaje indica, cualquier cantidad de texto y al final una C
	
SELECT *
	FROM Students
	WHERE firstname LIKE ('___ael') -- 6 barras bajas indican cualquier palabra de 6 letras
	
SELECT * 
	FROM Students
	WHERE birthdate < '1995-01-01';
	
SELECT * 
	FROM Students
	WHERE MONTH(birthdate) BETWEEN 1 AND 2;