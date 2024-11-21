# Procedimientos,Funciones y Disparadores
## Práctica de Laboratorio 6:

## Procedimiento
Un procedimiento toma argumentos, no devuelve nada, y puede modificar la base de datos
```sql
DELIMITER //
CREATE OR REPLACE PROCEDURE procDeleteGrades(studentDni CHAR(9))
BEGIN
    DECLARE id INT;
    SET id = (SELECT studentId FROM Students WHERE dni = studentDni);
    DELETE FROM Grades WHERE studentId=Id;
END //
DELIMITER ;
```

Para llamarlo, como ejemplo:
```sql
CALL procDeleteGrades('12345678A');
```

## Funciones
No puede modificar la base de datos, pero devuelve datos:
```sql 
DELIMITER //
CREATE OR REPLACE FUNCTION avgGrade(studentId INT) RETURNS DOUBLE
BEGIN
    DECLARE avgStudentGrade DOUBLE;
    SET avgStudentGrade = (SELECT AVG(value) FROM Grades WHERE Grades.studentId = studentId);
    RETURN avgStudentGrade;
END //
DELIMITER ;

-- Y para llamarlo:
SELECT avgGrade(2); -- El '2' hace referencia al id del estudiante
```

## Disparadores (Triggers)
Hace algo frente a un evento en la base de datos, para crearlo:
```sql 
DELIMITER //
CREATE OR REPLACE TRIGGER RN001_triggerWithHonours
BEFORE INSERT ON Grades -- Especificamos cuando queremos que se active el trigger   
FOR EACH ROW
BEGIN
    IF (new.withHonours = 1 AND new.value <9.0) THEN
        SIGNAL SQLSTATE '45000' SET message_text = 'You cannot insert a grade with honours whose value is less than 9';
    END IF;
END //
DELIMITER ;
```
Tipos de triggers:
- BEFORE: antes de modificar un dato.
- AFTER: después de que haya sido modificado el dato.

Una vez creado, al intentar modificar algo en una tabla, vamos a ver que se activa cuando se de la condición.

Por ejemplo, al ejecutar la siguiente consulta:
```sql
INSERT INTO Grades (gradeId, value, gradeCall, withHonours, studentId, groupId) VALUES
	(1, 4.50, 1, 1, 1, 1);
```
Da error porque el valor es de 4.5, que es menor que 9, y le hemos concedido una matrícula.

Más ejemplos de Triggers:
### 1. implementa la regla de negocio por la que no se puede poner a un alumno una nota en un grupo en el que no pertenece:
```sql
DELIMITER //
CREATE OR REPLACE TRIGGER RN003_triggerGradeStudentGroup
BEFORE INSERT ON Grades
FOR EACH ROW
BEGIN

    DECLARE isInGroup INT;
    SET isInGroup = (SELECT COUNT(*) FROM GroupsStudents WHERE studentId = new.studentId AND groupId = new.groupId);
    
    IF(isInGroup < 1) THEN
    SIGNAL SQLSTATE '45000' SET message_text = 'A student cannot have grades for groups in which they are not registered';
    END IF;
END//
DELIMITER ;
```
Para probarlo:
```sql
INSERT INTO Grades (value, gradeCall, withHonours, studentId, groupId) VALUES
	(9.5, 3, 1, 1, 115);
```
Da error porque el estudiante no está en el grupo 115.

### 2. implementa la siguiente regla de negocio: cada vez que se actualice una nota, comprueba si ésta se ha subido en más de 4 puntos.En ese caso, se muestra un error con el nombre del estudiante y la diferencia de la nota nueva con respecto a la antigua

```sql
DELIMITER //
CREATE OR REPLACE TRIGGER RN004_triggerGradesChangeDifference
BEFORE UPDATE ON Grades
FOR EACH ROW
BEGIN
    DECLARE difference DECIMAL(4,2);
    DECLARE student ROW TYPE OF Students; -- aquí guardamos a un estudiante entero, para luego poder acceder a sus campos.
    SET difference = new.value - old.value;

    IF(difference > 4) THEN
        SELECT * INTO student FROM Students WHERE studentId = new studentId; -- Usamos INTO cuando está dentro de fila
        
        SET @error_message = CONCAT('You cannot add ', difference,
        ' points to a grade for the student', student.firstName,' ', student.surname);
        
        SIGNAL SQLSTATE'45000' SET MESSAGE_TEXT = @error_message;
    END IF;
END//
DELIMITER ;
```

Si escribimos:
```sql
UPDATE Grades SET value = 10 WHERE gradeId = 6;
````
El trigger se enciende y salta el error.

# Nota: falta la ulima funcion.
### 3. hola