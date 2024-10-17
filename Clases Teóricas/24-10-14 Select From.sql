SELECT * FROM empleados;
SELECT * FROM departamentos;

SELECT * FROM empleados, departamentos;

SELECT * FROM empleados NATURAL JOIN departamentos;

SELECT nombre, nombredep FROM empleados NATURAL JOIN departamentos;

SELECT E1.nombre, E2.nombre FROM empleados E1, empleados E2
WHERE E1.jefe = E2.empleadoId;

SELECT * FROM empleados E LEFT JOIN departamentos D -- El left indica que quiero todos los empleados (por ser el que está a la izquierda)
ON E.departamentoId = D.departamentoId;

SELECT * FROM empleados E RIGHT JOIN departamentos D 
ON E.departamentoId = D.departamentoId;


SELECT * FROM empleados E LEFT JOIN departamentos D
ON E.departamentoId = D.departamentoId
UNION 
SELECT * FROM empleados E RIGHT JOIN departamentos D 
ON E.departamentoId = D.departamentoId;