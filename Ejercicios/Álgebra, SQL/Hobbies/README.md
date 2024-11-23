# Hobbies

# Ejercicios
### q1 Lista de Hobbies
```sql
SELECT * FROM Hobbies;
```
### q2: ¿Lista de nombres de personas? 
```sql
SELECT persona FROM Personas;
```
### q3: ¿Nombres de personas y sus aficiones?
```sql
SELECT persona, hobbie FROM personas NATURAL JOIN aficiones;
```
### q4: ¿Personas a las que les gusta el Tenis?
```sql
SELECT persona FROM personas NATURAL JOIN aficiones WHERE hobby = 'Tenis';
```
### q5: ¿Personas que no tienen hobbies?
```sql 
SELECT persona FROM personas 
EXCEPT
SELECT persona FROM personas NATURAL JOIN aficiones;
```
### q6: ¿Personas a quienes les gustan todos los hobbies?
```SQL
SELECT P.persona FROM personas P WHERE NOT EXISTS  

	(SELECT * FROM hobbies H WHERE NOT EXISTS

		(SELECT * FROM aficiones A

				WHERE A.hobby = H.hobby AND A.idPersona = P.idPersona));
```
### q7: ¿Cuenta de aficiones?
```sql
SELECT COUNT(*) FROM aficiones;
```
### q8: ¿Aficiones distintas?
```sql
SELECT COUNT(DISTINCT hobby) hobbies_distintos FROM aficiones;
```
### q9: ¿Cuenta de aficiones de cada persona?
```sql
SELECT persona, COUNT(hobby) FROM personas NATURAL JOIN aficiones 
GROUP BY persona 
ORDER BY 2 DESC;
```
### q10: ¿Máximo número de aficiones que tiene una persona?
```sql
SELECT MAX(aguacate) FROM (SELECT COUNT(*) aguacate FROM aficiones GROUP BY idPersona) x;
``` 
### q11: ¿Persona que tiene el máximo número de aficiones?
```sql
SELECT persona FROM (Personas NATURAL JOIN Aficiones) -- para extraer el nombre
GROUP BY idpersona,persona -- query exterior con las cuentas de cada p
    HAVING COUNT(*) = (SELECT MAX(na) FROM -- El máximo de todas las p
        (SELECT COUNT(*) AS na FROM Aficiones -- Cuenta para cada p
        GROUP BY idpersona) X
);
-------------------------------------------------------------------
SELECT persona, COUNT(hobby) hola FROM personas NATURAL JOIN aficiones GROUP BY persona
HAVING hola = (
    SELECT MAX(aguacate) FROM (SELECT COUNT(*) aguacate FROM aficiones GROUP BY idPersona) x
);
```

