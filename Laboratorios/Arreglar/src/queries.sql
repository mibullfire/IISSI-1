-- queries

UPDATE * FROM students
	SET birthdate='1998-01-01', surname='Fernández'
	WHERE studentId=3;
	
UPDATE * FROM subjects
	SET credits = credit/2;
	

DELETE * FROM Grades
	WHERE gradeId = 1;
	

SELECT firstname, surname
	WHERE accessMethod = 'Selectividad';
	
SELECT subjectId, credits>3, credits, credits+2
	FROM Subjects;
	
SELECT AVG(*), SUM(*), COUNT(*)
	FROM Subjects;
	
SELECT COUNT()
	FROM Subjects
	WHERE credits > 4;
	
SELECT COUNT(DISTINCT accessMethod)
	FROM Students;
	
CREATE OR REPLACE VIEW ViewGradesGroup18 AS
	(SELECT * FROM Grades WHERE groupId = 18);
	
SELECT * FROM ViewGradesGroup18;

SELECT FROM Subjects WHERE acronym='FP';

SELECT name, acronym FROM Subjects;

SELECT *
	FROM Students
	WHERE (birthdate.MONTH >= 1 AND birthdate.MONTH <= 2);
	
SELECT * FROM
	GroupsStudents JOIN ON Groups (GroupsStudents.grouId == Groups.groupId)
	JOIN ON Students (GroupsStudents.studentId == Students.studentId);
	
SELECT *
	FROM Subjects JOIN Degrees ON (Subjects.degreeId = Degrees.degreeId);
	
SELECT * 
	FROM Subjects NATURAL JOIN Degrees;
	

SELECT firstName, surname, AVG(value)
	FROM Grades JOIN Students ON (Grades.studentId = Students.studentId)
	GROUPING BY Grades.studentId;
	
SELECT gradeCall, Subjects.name, AVG(value)
	FROM Grades JOIN Groups ON (Grades.groupId = Groups.groupId)
	JOIN Subjects ON (Groups.subjectId = Subjects.subjectId)
	GROUP BY gradeCall, Groups.subjectId
	WHERE value >= 5 AND Groups.year = 2018;
	
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
	WHERE COUNT(*) > 2;