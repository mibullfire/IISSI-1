# SQL PEDIDOS
Clase 18/11/2024

## Ejercicio 1
Usuarios de Sevilla
```sql
SELECT name FROM users
WHERE province = 'Sevilla';
```
Escrito en Álgebra:
$$
\underset{province = 'Sevilla'}{\sigma} (\text{Users})
$$

## Ejercicio 3
Dar los usuarios que sean de Málaga o de Sevilla:
```sql
SELECT NAME FROM users
WHERE province = 'Sevilla' OR province = 'Málaga';
```
También lo podemos hacer con el `Álgebra Relacional`:

```sql
SELECT name FROM users
WHERE province = 'Sevilla'
UNION
SELECT name FROM users
WHERE province = 'Málaga';
```

Escrito en Álgebra:
$$
\left( \underset{province = 'Sevilla'}{\sigma} \text{Users} \right) \cup \left( \underset{province = 'Málaga'}{\sigma} \text{Users} \right)
$$

## Ejercicio 4
Dar los usuarios, la descripción del producto, la canitdad solicitada y el total del producto.

```sql
SELECT name, description, amount, amount*price total FROM users NATURAL JOIN products NATURAL JOIN orders;
```

Escrito en Álgebra:
$$ 
\prod_{\text{name,description,amount,amount*price}} \left(\text{Users} \bowtie \text{Products} \bowtie \text{Orders} \right)
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

## Ejercicio 9a
Resumen de pedidos agrupados por provincias (totales, medias, maximos, minimos, etc. De cantidades e importes)
```sql
SELECT COUNT(*), SUM(amount), MIN(amount), MAX(amount), AVG(amount), STD(amount) FROM users NATURAL JOIN products NATURAL JOIN orders
GROUP BY province; 
```

Escrito en Álgebra:
$$
\underset{province}{\gamma} \left(\text{Users} \bowtie \text{Products} \bowtie \text{Orders} \right)
$$

## Ejercicio 9b
Resumen de pedidos agrupados por productos (totales, medias, maximos, minimos, etc. De cantidades e importes).
```sql
SELECT productId, COUNT(*), SUM(amount), MIN(amount), MAX(amount), AVG(amount), STD(amount) FROM products NATURAL JOIN orders
GROUP BY productId;
```

Escrito en Álgebra:
$$
\underset{productId}{\gamma} \left(\text{Products} \bowtie \text{Orders} \right)
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