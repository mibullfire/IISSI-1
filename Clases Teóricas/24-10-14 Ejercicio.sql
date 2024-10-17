-- Calcular para cada departamento con más de un empleado el salario medio de los mismos,
-- el salario con mas comisiones, y el gasto total en salarios.

SELECT departamentoId, AVG(salario), SUM(salario * (1 + comision)), SUM(salario) FROM empleados
GROUP BY departamentoId
HAVING COUNT(*) > 1;