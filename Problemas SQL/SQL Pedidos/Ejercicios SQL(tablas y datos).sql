/* Scripts de apoyo para ejercicios SQL 
Autores: Inma Hernández, David Ruiz, y Daniel Ayala
Fecha creación: Noviembre de 2019 
Fecha modificación: Noviembre 2020 (Carlos Arévalo)
*/

DROP DATABASE IF EXISTS T10;
CREATE DATABASE T10;
USE T10;
-- Script que realice la creación de tablas 
-- del modelo relacional.

/* Eliminación de tablas */
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Users;

/* Relación: Usuarios */
CREATE TABLE Users(
	userId 			INT NOT NULL AUTO_INCREMENT,
	`name` 			VARCHAR(63) NOT NULL, /*RN-1a*/
	province 		VARCHAR(63), 
	startDate 		DATE NOT NULL, /*RN-1a*/
	PRIMARY KEY(userId),
	CONSTRAINT RN_1b_nameUnique UNIQUE(NAME) /*RN-1b*/
);

/* Relación: Productos */
CREATE TABLE Products(
	productId 		INT NOT NULL AUTO_INCREMENT,
	description		VARCHAR(128),
	price 			DECIMAL(6,2) NOT NULL, /*RN-2a*/
	stock 			INT,
	PRIMARY KEY(productId),
	CONSTRAINT RN_2b_price_range CHECK (price >= 0), /*RN-2b*/
	CONSTRAINT RN_2c_positive_stock CHECK (stock >= 0 ) /*RN-2c*/
);
/* Relación: Pedidos */
CREATE TABLE Orders(
	orderId 		INT 	NOT NULL AUTO_INCREMENT,
	userId 			INT 	NOT NULL,
	productId 		INT 	NOT NULL,
	amount 			INT 	DEFAULT(1), /*RN-3a*/
	purchaseDate 	DATE	DEFAULT(NOW()), /*RN-3a*/
	PRIMARY KEY(orderId),
	FOREIGN KEY(userId) REFERENCES Users(userId),
	FOREIGN KEY(productId) REFERENCES Products(productId), 
	CONSTRAINT RN_3b_amount_range CHECK (amount BETWEEN 0 AND 10), 		/*RN-3b*/
	CONSTRAINT RN_3c_month_Not_August CHECK ( MONTH(purchaseDate)<>8 ) 	/*RN-3c*/
);

/* Datos de Usuarios */
INSERT INTO Users(name, province, startDate) VALUES 
	('David Ruiz', 'Sevilla', '2018-05-18'),
	('Marta López', 'Málaga', '2018-06-12'),
	('Raquel Lobato', 'Granada', '2018-12-01'),
	('Antonio Gómez', 'Sevilla', '2018-03-11'),
	('Inma Hernández', 'Málaga', '2018-04-12'),
	('Jimena Martín', 'Granada', '2018-05-13'),
	('Carlos Rivero', 'Huelva', '2018-09-07'),
	('Carlos Arévalo', 'Málaga', '2018-09-07')
	;

/* Datos de Productos */
INSERT INTO Products(description, price, stock) VALUES
	('Mi Band 3', 19.90, 50),
	('Mi Band 4', 29.90, 20),
	('Pulsera compatible con Mi Band 3 y 4', 9.90, 150),
	('Mi Scooter', 349.90, 25),
	('Rueda trasera de respuesto Mi Scooter', 19.90, 50),
	('Rueda delantera de respuesto Mi Scooter', 59.90, 50);
	
/* Datos de Pedidos */
INSERT INTO Orders(userId, productId, amount, purchaseDate) VALUES 
	(1,1,2,'2019-05-13'),
	(1,3,2,'2019-05-13'),
	(2,2,3,'2019-06-11'),
	(2,3,1,'2019-06-11'),
	(3,4,2,'2019-06-15'),
	(4,5,1,'2019-06-18'),
	(4,6,1,'2019-06-18'),	
	(5,4,2,'2019-12-15'),
	(7,1,1,'2019-12-15'),
	(7,2,1,'2019-12-16'),
	(7,3,1,'2019-12-17'),
	(7,4,1,'2019-12-18'),
	(7,5,1,'2019-12-19'),
	(7,6,1,'2019-12-20'),
	(8,1,1,'2019-12-15');
