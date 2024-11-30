-- tables.sql

-- Es importante que al borrar las tablas se hagan en el orden contrario al que han sido creadas:
DROP TABLE IF EXISTS Grades;
DROP TABLE IF EXISTS GroupsStudents;
DROP TABLE IF EXISTS Students;
DROP TABLE IF EXISTS Groups;
DROP TABLE IF EXISTS Subjects;
DROP TABLE IF EXISTS Degrees;

-- Procedemos a crear las tablas
CREATE TABLE IF NOT EXISTS Degrees(
	degreeId INT NOT NULL AUTO_INCREMENT,
	name VARCHAR(60) NOT NULL UNIQUE,
	years INT NOT NULL DEFAULT(4),
	PRIMARY KEY (degreeId),
	CONSTRAINT invalidDegreeYear CHECK (years >=3 AND years <=5)
);

CREATE TABLE IF NOT EXISTS Subjects(
	subjectId INT NOT NULL AUTO_INCREMENT,
	degreeId INT NOT NULL,
	name VARCHAR(100) NOT NULL UNIQUE,
	acronym VARCHAR(8) NOT NULL UNIQUE,
	credits INT NOT NULL,
	year INT NOT NULL,
	type VARCHAR(20) NOT NULL,
	PRIMARY KEY (subjectId),
	FOREIGN KEY (degreeId) REFERENCES DEGREES (degreeId) ON DELETE CASCADE,
	CONSTRAINT negativeSubjectCredits CHECK (credits > 0),
	CONSTRAINT invalidSubjectCourse CHECK (year >= 1 AND year <=5),
	CONSTRAINT invalidSubjectType CHECK (type IN 
		('Formacion Basica',
		'Optativa',
		'Obligatoria')
	)
);

CREATE TABLE IF NOT EXISTS Groups(
	groupId INT NOT NULL AUTO_INCREMENT,
	name VARCHAR(30) NOT NULL,
	activity ENUM('Teoria', 'Laboratorio') NOT NULL,
	year INT NOT NULL,
	subjectId INT NOT NULL,
	PRIMARY KEY (groupId),
	FOREIGN KEY (subjectId) REFERENCES Subjects (subjectId),
	UNIQUE(name, year, subjectId),
	CONSTRAINT negativeGroupYear CHECK (year > 0)
);

CREATE TABLE IF NOT EXISTS Students(
	studentId INT NOT NULL AUTO_INCREMENT,
	accessMethod ENUM('Selectividad', 'Ciclo', 'Mayor', 'Titulado Extranjero') NOT NULL,
	dni CHAR(9) NOT NULL UNIQUE,
	firstName VARCHAR(100) NOT NULL,
	surname VARCHAR(100) NOT NULL,
	birthDate DATE NOT NULL,
	email VARCHAR(250) NOT NULL UNIQUE,
	PRIMARY KEY (studentId)
);

CREATE TABLE IF NOT EXISTS GroupsStudents(
	groupStudentId INT NOT NULL AUTO_INCREMENT,
	groupId INT NOT NULL,
	studentId INT NOT NULL,
	PRIMARY KEY (groupStudentId),
	FOREIGN KEY (groupId) REFERENCES Groups (groupId),
	FOREIGN KEY (studentId) REFERENCES Students (studentId),
	UNIQUE(groupId, studentId)
);

CREATE TABLE IF NOT EXISTS Grades(
	gradeId INT NOT NULL AUTO_INCREMENT,
	value DECIMAL(4,2) NOT NULL,
	gradeCall INT NOT NULL,
	withHonours BOOLEAN NOT NULL,
	studentId INT NOT NULL,
	groupId INT NOT NULL,
	PRIMARY KEY (gradeId),
	FOREIGN KEY (studentId) REFERENCES Students (studentId),
	FOREIGN KEY (groupId) REFERENCES Groups (groupId),
	CONSTRAINT invalidGradeValue CHECK (value >= 0 && value <= 10),
	CONSTRAINT invalidGradeCall CHECK (gradeCall >= 1 && gradeCall <= 3),
	CONSTRAINT RN_002_duplicatedCallGrade UNIQUE(studentId, gradeCall, groupId)
);

-- Queda corregido y sin errores el archivo tables.sql :)