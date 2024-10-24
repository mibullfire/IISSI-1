DROP TABLE if EXISTS grades; -- Esta línea es importante para asegurarnos de borrar la tabla antes de crear una con el mismo nombre.
DROP TABLE if EXISTS GroupsStudents;
DROP TABLE if EXISTS Students;
DROP TABLE if EXISTS Groups;
DROP TABLE if EXISTS Subjects;
DROP TABLE if EXISTS DEGREES;

CREATE TABLE DEGREES(
			degreeId INT AUTO_INCREMENT,
			NAME VARCHAR(60),
			years INT DEFAULT(4),
			PRIMARY KEY (degreeId)
);

CREATE TABLE Subjects(
			subjectId INT AUTO_INCREMENT,
			degreeId INT,
			NAME VARCHAR(100),
			acronym VARCHAR(8),
			credits INT,
			YEAR INT,
			TYPE VARCHAR(20),
			PRIMARY KEY (subjectId),
			FOREIGN KEY (degreeId) REFERENCES degrees (degreeId)
);
  
CREATE TABLE Groups(
		   groupId INT AUTO_INCREMENT,
		   name VARCHAR(30),
		   activity VARCHAR(20),
		   year INT,
		   subjectId INT,
   		PRIMARY KEY (groupId),
   		FOREIGN KEY (subjectId) REFERENCES Subjects (subjectId)
);

CREATE TABLE Students(
			studentId INT AUTO_INCREMENT,
			accessMethod VARCHAR(30),
			dni CHAR(9),
			firstName VARCHAR(100),
			surname VARCHAR(100),
			birthDate DATE,
			email VARCHAR(250),
			PRIMARY KEY (studentId)
);

CREATE TABLE GroupsStudents(
		   groupStudentId INT AUTO_INCREMENT,
		   groupId INT,
		   studentId INT,
		   PRIMARY KEY (groupStudentId), 
		   FOREIGN KEY (groupId) REFERENCES GROUPS (groupId),
		   FOREIGN KEY (studentId) REFERENCES Students (studentId)
);

CREATE TABLE Grades(
		   gradeId INT AUTO_INCREMENT,
		   value DECIMAL(4,2),
		   gradeCall INT,
		   withHonours BOOLEAN,
			studentId INT,
		   groupId INT,
		   PRIMARY KEY (gradeId),
		   FOREIGN KEY (studentId) REFERENCES Students (studentId),
		   FOREIGN KEY (groupId) REFERENCES Groups (groupId)
);