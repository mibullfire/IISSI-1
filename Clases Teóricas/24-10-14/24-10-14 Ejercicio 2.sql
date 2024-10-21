-- Empleados con salario mayor que el salario medio en todos los departamentos


SELECT AVG(salario) FROM empleados; -- Así calculamos el salario medio

SELECT nombre, salario FROM empleados WHERE salario >= (SELECT AVG(salario) FROM empleados); -- Esta consulta es por departamento

SELECT nombre, salario FROM empleados WHERE salario >= ALL (SELECT AVG(salario) FROM empleados GROUP BY departamentoId); -- Para todos los departamentos


-- Departamento con más empleados

SELECT nombredep FROM departamentos WHERE departamentoid IN (
SELECT departamentoid FROM empleados GROUP BY departamentoid
HAVING COUNT(*) =
(SELECT MAX(cuenta) FROM (
SELECT COUNT(*) cuenta FROM empleados GROUP BY departamentoid) X));  -- El valor x es importante pa que funcione