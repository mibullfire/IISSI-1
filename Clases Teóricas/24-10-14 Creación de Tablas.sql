DROP table if EXISTS empleados;
DROP table if EXISTS departamentos;

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