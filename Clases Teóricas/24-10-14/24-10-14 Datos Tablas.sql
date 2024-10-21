INSERT INTO Departamentos (nombreDep, localidad)
VALUES ('Historia', NULL);



INSERT INTO Departamentos (nombreDep, localidad)
VALUES ('Informática', 'Sevilla');
INSERT INTO Departamentos (nombreDep, localidad)
VALUES ('Arte', 'Cádiz');

/* Pedro de Historia */
INSERT INTO Empleados(departamentoId, jefe, nombre, salario, fechaInicial,
fechaFinal, comision)
VALUES (1, NULL, 'Pedro', 2300.00, '2017-09-15', NULL, 0.2);
/* José de Historia*/
INSERT INTO Empleados(departamentoId, jefe, nombre, salario, fechaInicial,
fechaFinal, comision)
VALUES (1, NULL, 'José', 2500.00, '2018-08-15', NULL, 0.5);
/* Lola de Informática */
INSERT INTO Empleados(departamentoId, jefe, nombre, salario, fechaInicial,
fechaFinal, comision)
VALUES (2, NULL, 'Lola', 2300.00, '2018-08-15', NULL, 0.3);
/* Luis trabajó para Pedro 3 meses */
INSERT INTO Empleados(departamentoId, jefe, nombre, salario, fechaInicial,
fechaFinal, comision)
VALUES (1, 1, 'Luis', 1300.00, '2018-08-15', '2018-11-15', 0);
/* Ana trabajó para Pedro 3 meses */
INSERT INTO Empleados(departamentoId, jefe, nombre, salario, fechaInicial,
fechaFinal, comision)
VALUES (1, 1, 'Ana', 1300.00, '2018-08-15', '2018-11-15', 0);