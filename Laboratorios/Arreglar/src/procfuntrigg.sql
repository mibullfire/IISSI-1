-- Procedures, functions, and triggers

DELIMITER//
CREATE OR REPLACE PROCEDURE procDeleteGrades(studentDni)
BEGIN
	DECLARE id = NULL;
	SET id = (SELECT studentId FROM students WHERE dni=studentDni);
	DELETE FROM grades WHERE studentId=id;
END //
DELIMITER ;

CALL procDeleteGrades('1234568A');

DELIMITER //
CREATE OR REPLACE FUNCTION avgGrade(studentId INT) RETURN DOUBLE
BEGIN
	DECLARE avgStudentGrade DOUBLE
	SET avgStudentGrade = (SELECT AVG(VALUE) FROM Grades
		WHERE grades.studentId = studentId);
	RETURN avgStudentGrade;
END //
DELIMITER ;

SELECT avgGrade(2);

SELECT studentId, avgGrade(studentId) FROM students;

DELIMITER //
CREATE OR REPLACE TRIGGER RN001_triggerWithHonours
BEFORE INSERT ON Grades
BEGIN
	IF(new.withHonours = 1 AND NEW.value < 9.0) THEN
		SIGNAL SQLSTATE '45000' message_text = 'You cannot insert a grade with honours whose value is less than 9';
	END IF;
END //
DELIMITER ;

INSERT INTO Grades (value, gradeCall, withHonours, studentId, groupId) VALUES
	(9.50, 1, 1, 1, 12);
	
DELIMITER //
CREATE OR REPLACE TRIGGER RN003_triggerGradeStudentGroup
BEFORE INSERT ON Grades
FOR EACH ROW
BEGIN
	DECLARE isInGroup INT;
	SELECT COUNT(*) INTO isInGroup
		FROM GroupsStudents
		WHERE studentId = new.studentId AND groupId = new.groupId;
	IF(isInGroup <1)
		SIGNAL SQLSTATE '45000' SET message_text =
		'A student cannot have grades for groups in which they are not registered';
	END IF;
END//
DELIMITER ;

INSERT INTO Grades (value, gradeCall, withHonours, studentId, groupId) VALUES
	(2.50, 2, 0, 1, 12);
	
INSERT INTO Grades (value, gradeCall, withHonours, studentId, groupId) VALUES
	(2.50, 2, 0, 1, 18);
	
DELIMITER //
CREATE OR REPLACE TRIGGER RN004_triggerGradesChangeDifference()
BEFORE UPDATE ON Grades
FOR EACH ROW
BEGIN
	DECLARE difference DECIMAL(4,2);
	SET difference = new.value - old.value;
	IF(difference > 4) THEN
		SET new.value  = old.value + 4;
	END IF;
END//
DELIMITER ;

UPDATE Grades SET value = 1.50 WHERE gradeId = 12;