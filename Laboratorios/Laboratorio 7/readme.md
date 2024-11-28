# Laboratorio 7

En sql podemos ver y cambiar la variable de autocommit:
```sql
SELECT @@AUTOCOMMIT;
```
Si está a `1` hace autocommit, si está a `0` nosotros tenemos que hacer manualmente el commit.

```sql
SET AUTOCOMMIT=0;
START TRANSACTION;
INSERT INTO Grades (value, gradeCall, withHonours, studentId, groupId) VALUES
(4.50, 3, 0, 1, 1);

INSERT INTO Grades (value, gradeCall, withHonours, studentId, groupId) VALUES
(7.50, 1, 0, 1, 3);

INSERT INTO Grades (value, gradeCall, withHonours, studentId, groupId) VALUES
(-7.50, 1, 0, 2, 2);

COMMIT;
```
En la tercera transacción nos da un error, por lo que la transacción se queda abierta.
Podemos recuperar los cambios haciendo `ROLLBACK`:
```sql
ROLLBACK;
```
Lo suyo es tener el `AUTOCOMMIT` a 0, para reflejar los cambios de forma manual usando:
```sql
COMMIT;
```

