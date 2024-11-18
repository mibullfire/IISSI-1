-- Usuarios de Málaga y Sevilla

SELECT NAME FROM users
WHERE province = 'Sevilla' OR province = 'Málaga'

SELECT NAME FROM users
WHERE province = 'Sevilla'
UNION
SELECT NAME FROM users
WHERE province = 'Málaga'

-- Usuarios sin pedido

SELECT NAME FROM users
EXCEPT
SELECT NAME FROM users NATURAL JOIN orders;

-- Usuarios que han comprado todos los productos

SELECT NAME FROM users U
WHERE NOT EXISTS (SELECT * FROM products P 
						WHERE NOT EXISTS (SELECT * FROM orders O
						WHERE O.userId = U.userId AND O.productId = P.productId));
						
-- Hola

SELECT name FROM users NATURAL JOIN (
SELECT userId, COUNT(*) FROM orders
GROUP BY userId
HAVING COUNT(*) = (SELECT COUNT(*) FROM products)) X;

-- Pedido de mayor y menor cuantia

SELECT orderId, price, amount, price*amount total FROM orders NATURAL JOIN products; -- Selección y multiplicacion de precios

SELECT orderId, price*amount FROM orders
NATURAL JOIN products
WHERE price*amount = ( 
SELECT max(price*amount) total FROM orders NATURAL JOIN products
);

-- Gasto de cada usuario:

SELECT userId
FROM orders NATURAL JOIN products
GROUP BY userId
HAVING SUM(price*amount) =
(SELECT MAX(total) FROM (
SELECT SUM(price*amount) total
FROM orders NATURAL JOIN products
GROUP BY userId) X);

-- Con esto podemos mostrar el nombre (es una paranoia):
SELECT name
FROM orders NATURAL JOIN products NATURAL JOIN users
GROUP BY userId, name
HAVING SUM(price*amount) =
(SELECT MAX(total) FROM (
SELECT SUM(price*amount) total
FROM orders NATURAL JOIN products
GROUP BY userId) X);
