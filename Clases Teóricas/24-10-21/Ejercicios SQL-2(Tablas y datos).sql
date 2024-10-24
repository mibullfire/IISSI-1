/* Scripts de apoyo para ejercicios SQL 
Autores: 	Inma Hernández, David Ruiz, Daniel Ayala y Carlos Arévalo
				Fecha creación: Noviembre de 2019 
				Fecha modificación: Noviembre 2020 (Carlos Arévalo)
*/
--
-- Script para creación de tablas y triggers
--

--
-- Creación y activación de la Base de Datos
--
DROP DATABASE IF EXISTS t11;
CREATE DATABASE t11;
USE t11;

--
-- Creación de tablas
--
/* Relación: Usuarios */
CREATE OR REPLACE TABLE Users(
	userId 			INT NOT NULL AUTO_INCREMENT,
	`name` 			VARCHAR(63) NOT NULL, /*RN-1a*/
	province 		VARCHAR(63), 
	startDate 		DATE NOT NULL, /*RN-1a*/
	PRIMARY KEY(userId),
	CONSTRAINT RN_1b_nameUnique UNIQUE(NAME) /*RN-1b*/
);

/* Relación: Productos */
CREATE OR REPLACE TABLE Products(
	productId 		INT NOT NULL AUTO_INCREMENT,
	description		VARCHAR(128) NOT NULL,
	price 			DECIMAL(6,2) NOT NULL, /*RN-2a*/
	stock 			INT,
	PRIMARY KEY(productId),
	CONSTRAINT RN_2b_price_range CHECK (price >= 0), /*RN-2b*/
	CONSTRAINT RN_2c_positive_stock CHECK (stock >= 0 ) /*RN-2c*/
);
/* Relación: Pedidos */
CREATE OR REPLACE TABLE Orders(
	orderId 		INT NOT NULL AUTO_INCREMENT,
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

/* RN-4: Admitir pedido sólo si hay stock
	IF ( Order.amount > Product.stock ) ** Actualizar stock 
		Product.stock = Product.stock- Order.amount
	ELSE **Cancelar Nuevo pedido
*/
DELIMITER //
CREATE OR REPLACE TRIGGER 
	RN_4_tCheckEnoughStock BEFORE INSERT ON Orders FOR EACH ROW
BEGIN
	DECLARE currentStock INT;
	SET currentStock = ( SELECT stock FROM Products WHERE productId = new.productId);
	IF(new.amount > currentStock) THEN
		SIGNAL SQLSTATE '45000' SET message_text = 
			'RN-4: No se puede hacer un pedido de más unidades de las disponibles';
	ELSE 
		UPDATE Products SET stock=stock-new.amount 
		WHERE productId=new.productId;
	END IF;
END //
DELIMITER ;

/* RN-5: Un usuario puede hacer como máximo tres pedidos diarios
*/
DELIMITER //
CREATE OR REPLACE TRIGGER 
	RN_5_tMaxOrdersDay BEFORE INSERT ON Orders FOR EACH ROW
BEGIN
	DECLARE ordersToday INT;
	SET ordersToday = (
		SELECT COUNT(*) FROM Orders 
		WHERE (userId=new.userId AND purchaseDate=new.purchaseDate)
	);
	IF(ordersToday >= 3) THEN
		SIGNAL SQLSTATE '45000' SET message_text = 
			'RN-5: No se pueden hacer más de 3 pedidos por dia';
	END IF;
END //
DELIMITER;

--
-- RF-1: Procedimiento que realiza la carga inicial de datos en las tablas
--
DELIMITER //
CREATE OR REPLACE PROCEDURE 
	pInsertData()
BEGIN
	-- Limpia tablas y reinicia contadores de claves primarias (Auto_Increment)
	SET FOREIGN_KEY_CHECKS = 0; -- Desactiva la verificación de integridad referencial 
	TRUNCATE Orders;
	TRUNCATE Products;
	TRUNCATE Users;
	SET FOREIGN_KEY_CHECKS = 1; -- Activa la verificación de integridad referencial 
	
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
END //
DELIMITER ;

--
-- Ejecución de la inicialización de tablas con datos de prueba.
--
CALL pInsertData();
