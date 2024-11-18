# SQL PEDIDOS
Clase 18/11/2024

## Ejercicio 2
Dar los usuarios que sean de Málaga o de Sevilla:
```sql
SELECT NAME FROM users
WHERE province = 'Sevilla' OR province = 'Málaga'
```
También lo podemos hacer con el `Álgebra Relacional`:

```sql
SELECT name FROM users
WHERE province = 'Sevilla'
UNION
SELECT name FROM users
WHERE province = 'Málaga'
```

En Álgebra:
$$
\left( \sigma_{\text{province} = \text{'Sevilla'}} \text{Users} \right) \cup \left( \sigma_{\text{province} = \text{'Málaga'}} \text{Users} \right)
$$

## Ejercicio 5
Dar los usuarios que no tienen pedidos:
```sql
SELECT name FROM users
EXCEPT
SELECT name FROM users NATURAL JOIN orders;
```
Con el `EXCEPT`restamos un resultado del otro, obteniendo el resultado.

En Álgebra:
$$
\prod_{\text{userId,name}} \text{Users} - \prod_{\text{userId,name}} \left( \text{Users} \bowtie \text{Orders} \right)
$$

## Ejercicio 6
Dar los usuarios que han comprado todos los productos:
```sql
SELECT NAME FROM users U
WHERE NOT EXISTS (SELECT * FROM products P 
						WHERE NOT EXISTS (SELECT * FROM orders O
						WHERE O.userId = U.userId 
                        AND O.productId = P.productId));
```
Nota: llamamos a cada tabla con un valor (U, P, P), para luego poder poner condiciones.

En Álgebra:
$$
\prod_{\text{name}} \left( \frac{\prod_{\text{userId}, \text{productId}} \text{Orders}}{\prod_{\text{productId}} \text{Products}} \right) \bowtie \text{Users}
$$

## Ejercicio 9c
Usuario que ha gastado más.
```sql 
SELECT userId
FROM orders NATURAL JOIN products
GROUP BY userId
HAVING SUM(price*amount) =
(SELECT MAX(total) FROM (
SELECT SUM(price*amount) total
FROM orders NATURAL JOIN products
GROUP BY userId) X);
```
Si quiero ver el nombre:
```sql 
SELECT name
FROM orders NATURAL JOIN products NATURAL JOIN users
GROUP BY userId, name
HAVING SUM(price*amount) =
(SELECT MAX(total) FROM (
SELECT SUM(price*amount) total
FROM orders NATURAL JOIN products
GROUP BY userId) X);
```

### a) Gasto de cada usuario
```sql
ayuda
```

## Ejercicio 9e
Dar pedido de mayor cuantía:
```sql
SELECT orderId, price, amount, price*amount total FROM orders NATURAL JOIN products; -- Selección y multiplicacion de precios

SELECT orderId FROM orders
NATURAL JOIN products
WHERE price*amount = ( 
SELECT max(price*amount) total FROM orders NATURAL JOIN products
);
```

En Álgebra:
```sql
ayuda
```

![Texto alternativo](./IMG_5873.JPG)