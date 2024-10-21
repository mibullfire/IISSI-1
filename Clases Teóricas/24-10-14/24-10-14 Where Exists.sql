-- Departamento con algun empleado

SELECT * FROM departamentos D
WHERE EXISTS (SELECT * FROM empleados E
WHERE D.departamentoId = e.departamentoId);

-- Departamentos sin empleados

SELECT * FROM departamentos D
WHERE NOT EXISTS (SELECT * FROM empleados E
WHERE D.departamentoId = E.departamentoId);
