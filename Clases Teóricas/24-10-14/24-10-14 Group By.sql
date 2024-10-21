SELECT * FROM empleados;
SELECT COUNT(*), SUM(salario), AVG(salario), MAX(salario) FROM empleados;


SELECT COUNT(*), SUM(salario)
FROM empleados GROUP BY departamentoId 
HAVING COUNT(*) > 1; -- Esta es una condicion para la agrupación