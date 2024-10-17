-- Script de creación de tablas
DROP TABLE if EXISTS grades; -- Esta línea es importante para asegurarnos de borrar la tabla antes de crear una con el mismo nombre.
DROP TABLE if EXISTS GroupsStudents;
DROP TABLE if EXISTS Students;
DROP TABLE if EXISTS Groups;
DROP TABLE if EXISTS Subjects;
DROP TABLE if EXISTS DEGREES;

CREATE TABLE Degrees(
	degreeId INT NOT NULL AUTO_INCREMENT, -- INT(32) guardariamos 32 bytes
	name VARCHAR(60) NOT NULL UNIQUE, -- memoria que reservamos en cada nombre con hasta 60 bytes máximos
	years INT DEFAULT(4) NOT NULL, -- años de tipo int con un valor por defecto de 4
	PRIMARY KEY (degreeId),
	CONSTRAINT invalidDegreeYear CHECK (years >= 3 AND years <= 5)
);

-- NOT NULL indica que no puede ser nulo
-- Unique indica que el nombre es unico y no puede repetirse

CREATE TABLE Subjects(
	subjectId INT NOT NULL AUTO_INCREMENT,
	degreeId INT NOT NULL,
	name VARCHAR(100) NOT NULL UNIQUE,
	acronym VARCHAR(8) NOT NULL UNIQUE,
	credits INT NOT NULL,
	year INT NOT NULL,
	type VARCHAR(20) NOT NULL, -- También se puede type ENUM('Formacion Básica','Optativa','Obligatoria')
	PRIMARY KEY(subjectId),
	FOREIGN KEY (degreeId) REFERENCES Degrees (degreeId),
	CONSTRAINT negativeSubjectCredits CHECK (credits > 0),
	CONSTRAINT invalidSubjectCourse CHECK (year BETWEEN 1 AND 4),
	CONSTRAINT invalidSubject CHECK (type IN (
		'Formacion Básica',
		'Optativa',
		'Obligatoria'
	))
);

CREATE TABLE Groups(
	groupId INT NOT NULL AUTO_INCREMENT,
	name VARCHAR(30) NOT NULL,
	activity ENUM('Teoía', 'Laboratorio') NOT NULL,
	year INT NOT NULL,
	subjectId INT NOT NULL,
	PRIMARY KEY (groupId),
	FOREIGN KEY (subjectId) REFERENCES Subjects (subjectId),
	UNIQUE (name, year, subjectId), -- la combinación name, year, subjectId no puede repetirse NOTA: NO METER NUNCA UNA CLAVE PRIMARIA EN EL UNIQUE
	CONSTRAINT negativeGroupYear CHECK (year > 0)
);

CREATE TABLE Students(
			studentsId INT NOT NULL AUTO_INCREMENT,
			accessMethod VARCHAR(30) NOT NULL,
			dni CHAR(9) NOT NULL UNIQUE, -- char es el numero de caracteres
			firstName VARCHAR(100) NOT NULL,
			surname VARCHAR(100) NOT NULL,
			birthDate DATE NOT NULL, -- para un dia y datetime para fecha y hora
			email VARCHAR(250) NOT NULL UNIQUE,
			PRIMARY KEY (studentsId)
);

-- Tabla intermedia que relaciona a los grupos con los estudiantes:
-- Esta tabla sirve de enlace entre las otras dos tablas
CREATE TABLE GroupsStudents(
		   groupStudentId INT AUTO_INCREMENT, -- id propio de cada uno
		   groupId INT, -- grupo al que hace referencia
		   studentsId INT, -- estudiante que esta en ese grupo
		   PRIMARY KEY (groupStudentId), 
		   FOREIGN KEY (groupId) REFERENCES Groups (groupId),
		   FOREIGN KEY (studentsId) REFERENCES Students (studentsId),
		   UNIQUE (groupId, studentsId)
);

CREATE TABLE Grades(
		   gradeId INT NOT NULL AUTO_INCREMENT,
		   value DECIMAL(4,2) NOT NULL, -- decimal se usa para numeros con el decimal exacto; para valores con decimales infinitos tenemos float
		   -- decimal 0000 | 0000 , 0000 | 0000 el 4 es el numero total de digitos que puede tener y el 2 cuantos de ellos son decimales
		   gradeCall INT NOT NULL,
		   withHonours BOOLEAN NOT NULL, -- boolean es lo mismo que escribir INT(1)
			studentsId INT NOT NULL,
		   groupId INT NOT NULL,
		   PRIMARY KEY (gradeId),
		   FOREIGN KEY (studentsId) REFERENCES Students (studentsId),
		   FOREIGN KEY (groupId) REFERENCES Groups (groupId),
		   CONSTRAINT invalidGradeValue CHECK (value BETWEEN 0 AND 10),
		   CONSTRAINT invalidGradeCall CHECK (gradeCall BETWEEN 1 AND 3),
		   CONSTRAINT RN_002_duplicateCallGrade UNIQUE (gradeCall, studentsId, groupId)
);