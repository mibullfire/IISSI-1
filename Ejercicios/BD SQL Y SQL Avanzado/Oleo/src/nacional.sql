CREATE OR REPLACE TABLE propietarios(
	propId INT AUTO_INCREMENT KEY,
	nombre VARCHAR(30),
	tipo INT,
	dni VARCHAR(9),
	pais VARCHAR(20),
	CONSTRAINT nacional CHECK(NOT tipo=1 or pais IS NULL),
	CONSTRAINT internacional CHECK(NOT tipo=2 or dni IS NULL)
);