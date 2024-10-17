CREATE OR REPLACE VIEW v1 AS (
SELECT * FROM empleados NATURAL JOIN departamentos); -- Estas lineas crean una vista de la tabla en la base de datos

SELECT * FROM v1 WHERE salario > 2000;