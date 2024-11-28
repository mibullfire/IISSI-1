# Arreglar

## tables.sql
Registro de cambios:

Los drops ahora están en el orden contrario al de creación de tablas:
```sql 
DROP TABLE IF EXISTS Grades;
DROP TABLE IF EXISTS GroupsStudents;
DROP TABLE IF EXISTS Students;
DROP TABLE IF EXISTS Groups;
DROP TABLE IF EXISTS Subjects;
DROP TABLE IF EXISTS Degrees;
```
CREATE TABLE Grades(
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

que falla
