-- Disparadores

-- Nota: mientras se puede hacer un check se hace el check, el trigger es solo para condiciones que no se puedan hacer de otra manera.

DELIMITER //
-- Comprueba que un empleado no es su propio jefe
CREATE OR REPLACE TRIGGER
	tEmpleadoPropioJefe
BEFORE UPDATE ON Empleados FOR EACH ROW
BEGIN
	IF (new.empleadoId = new.jefe) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT=
		'Un empleado no puede ser su propio jefe';
	END IF;
END //
DELIMITER ;
-- En caso de que sea su propio jefe el Disparador salta dándonos un mensaje de error.

-- UPDATE Empleados SET jefe=1 WHERE empleadoId = 1; -- Si hago un update me salta el error, debido a que ese empleado no puede ser su propio jefe.

DELIMITER //
-- Comprueba que no se le sube el salario a una persona más de un 50%
CREATE OR REPLACE TRIGGER
	tSubidaSalario
BEFORE UPDATE ON Empleados FOR EACH ROW
BEGIN
	IF (new.salario > old.salario * 1.50) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT=
		'No se puede subir el salario más de un 50%';
	END IF;
END //
DELIMITER ;

-- Los departamentos no tienen 5 o másdepartamentos empleados.
DELIMITER //
-- Comprueba que un departamento no tiene más de 5 empleados
CREATE OR REPLACE TRIGGER tDemasiadosEmpleados
BEFORE UPDATE ON Empleados FOR EACH ROW
BEGIN

	-- Guardamos en una variable "wCuenta" la cuenta de empleados de cada departamento:
	DECLARE wCuenta INT;
	SELECT COUNT(*) INTO wCuenta
	FROM empleados
	WHERE departamentoId = new.departamentoId; -- Con el new calculamos la cuenta del departamento que estoy insertando

	-- Hacemos un IF para que el programa se queje
	IF (wCuenta > 4) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT=
		'No puede haber más de 5 empleados por departamentos';
	END IF;
	
END //
DELIMITER ;

-- SI usamos AFTER > 5 porque el valor que entra lo cuenta
-- SI usamos BEFORE > 4 


--Llevarnos a una tabla aquello que borremos

DROP TABLE IF EXISTS empleadosBorrados;
CREATE TABLE empleadosBorrados (
	nombre VARCHAR(50),
	departId INT,
	fecha DATE,
	usuario VARCHAR(50)
);
DELIMITER //
CREATE OR REPLACE TRIGGER nuevoEmpleados
AFTER DELETE ON Empleados FOR EACH ROW
BEGIN

INSERT INTO empleadosBorrados
VALUE (old.nombre, old.departamentoId, SYSDATE(), USER());
	
END //
DELIMITER ;