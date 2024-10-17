# Laboratorio 1

En el arcihvo `Creación de Tablas.sql` se recogen los apartados del laboratorio `1` y `2`.

Se ve como `crear`y `eliminar` tablas, así como que `variables` usar y como expresar `restricciones`en las mismas.

## Creación y Eliminación de Tablas

Para `eliminar` una tabla escribiremos lo siguiente antes de crearlas. Así nos aseguramos que cuando creemos una, no existe (en caso de que no exista pasaría de largo)

```sql
DROP TABLE IF EXISTS nombre_tabla;
```

Es importante escribirlo en orden inverso a su creación, es decir, si creamos primero la tabla 1 y luego la tabla 2, escribiremos:

```sql
DROP TABLE IF EXISTS tabla_2;
DROP TABLE IF EXISTS tabla_1;
```

Para `crear`una tabla usamos el siguiente comando:

```sql
CREATE TABLE nombre_tabla(
    variables TYPE.
    PRIMARY KEY (variables),
    (...),
    CONSTRAINT (...)
);
```

## CLAVES

Tenemos diferentes tipos de claves:

- `PRIMARY KEY`: Clave primaria.
- `FOREIGN KEY`: Clave ajena.

Se escriben después de definir las variables en el CREATE TABLE:

```sql
    PRIMARY KEY (nombre),
    FOREIGN KEY (nombre) REFERENCES tabla_extranejera (nombre_extranjero);
```

## Tipos de Variables

Existen diferentes tipos de variables que podemos usar cuando las definimos al crear una tabla:

- `INT` / `FLOAT`: valor entero o valor númerico.
```sql
numero INT;
numero INT(10); -- Se le puede asignar hasta un máximo de 10 bytes
numero FLOAT;
numero FLOAT (10);
```
- `CHAR(x)`: número de x caracteres máximos. Ejemplo:
```sql
nombre CHAR(3); -- Máximo 3 caracteres
```
- `VARCHAR`: máximo de x bytes que se pueden destinar a esa variable. Ejemplo:
```sql
nombre VARCHAR(10); -- Máximo 10 bytes
```
- `DATE` o `DATETIME`: fecha o fechahora.
```sql
fecha DATE;
fechaHora DATETIME;
```
- `DECIMAL(x,y)`: indica que estamos usando un valor decimal de x dígitos con y dígitos en la parte decimal.
```sql
número DECIMAL(4,3); -- Número con 4 dígitos y 3 decimales, como por ejemplo 1.234
```

## Atributos de las Variables

Se les puede asignar algunas restricciones:

### NOT NULL
```sql
nombre CHAR(10) NOT NULL;
```
Indicamos que la variable nombre `nunca puede ser nula`.
### DEFAULT
```sql
numero INT DEFAULT(3);
```
Indicamos que por defecto, si no lo asignamos manualmente, la variable toma el valor de `3`.
### AUTO_INCREMENT
```sql
numero INT AUTO_INCREMENT;
```
Indicamos que el número se `incremente` en el trancsurso de la tabla de manera automática.
### ENUM
```sql
tipos ENUM('tipo1', 'tipo2');
```
Con ENUM indicamos que la variable tipos `tiene que ser si o si una de las asignaciones que le hemos dado`, en este caso o tipo1 o tipo2.
### UNIQUE
```sql
nombre CHAR(10) UNIQUE;
```
Decimos que el nombre debe de ser único y no se puede repetir, de igual manera podemos decir que un conjunto de elementos de la tabla sean únicos. Es decir, que la combinación de ellos no se pueda repetir.
```sql
UNIQUE (nombre1, nombre2, nombre3);
```
`NOTA`: jamás podemos meter un valor que represente una `clave primaria (PK)` cuando nos referimos a una combinación.

## Restricciones

Las restricciones son una manera de comprobar que un valor sea tal y como queremos, se escriben de la siguiente forma al final de la creación de tabla:

```sql
    CONSTRAINT nombreFalloAparecePorPantalla CHECK (condición);
```

Podemos comprobar una infinidad de cosas, algunos ejemplos son:

Con la siguiente restricción decimos que el `type`debe de ser si o si 'tipo1', 'tipo2' o 'tipo3'. Es lo mismo que obtendriamos si usamos un `ENUM`.

```sql
	CONSTRAINT invalidType CHECK (type IN (
		'tipo1',
		'tipo2',
		'tipo3'
	));
```

También podemos comprobar que un valor sea negativo, o que es mayor o menor a otro:

```sql
    CONSTRAINT negativeNumber CHECK (numero > 0);
```

En el caso de que estemos comprobando que tenemos un valor entre dos puntos, tenemos dos opciones para representarlo:

```sql
    CONSTRAINT invalidNumber CHECK (numero BETWEEN 1 AND 3);
    CONSTRAINT invalidNumber CHECK (numero >= 1 AND numero < 3);
```