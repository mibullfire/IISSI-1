DROP TABLE IF EXISTS Empleados;
DROP TABLE IF EXISTS Departamentos;

CREATE TABLE Departamentos(
	departamentoId INT NOT NULL AUTO_INCREMENT,
	nombreDep VARCHAR(32),
	localidad VARCHAR(64),
	PRIMARY KEY(departamentoId),
	UNIQUE(nombreDep, localidad)
);

CREATE TABLE Empleados(
	empleadoId INT NOT NULL AUTO_INCREMENT,
	departamentoId INT,
	jefe INT,
	nombre VARCHAR(64) NOT NULL,
	salario DECIMAL(6,2) DEFAULT 2000.00,
	fechaInicial DATE,
	fechaFinal DATE,
	comision DOUBLE,
	PRIMARY KEY(empleadoId),
	FOREIGN KEY(departamentoId)
	REFERENCES Departamentos(departamentoId)
	ON DELETE SET NULL,
	FOREIGN KEY(jefe)
	REFERENCES Empleados(empleadoId),
	UNIQUE(nombre),
	CHECK (comision >=0 AND comision <=1),
	CONSTRAINT fecha CHECK (fechaInicial < fechaFinal)
);

/* Tres valores correctos */
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
