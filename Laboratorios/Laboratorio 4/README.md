# Laboratorio 4: API REST y Silence
###### 07/11/2024
En este documento se explica de forma resumida todo el Laboratorio 4
## Silence
### Creación del Entorno
Para crear el entorno en donde vamos a trabajar, tenemos que usar el siguiente comando en `cmd`, pero primero nos situamos en la carpeta:
```cmd
cd desktop
```
Y luego ejecutamlos lo siguiente para crear el entorno:
```cmd
silence new nombre_proyecto --template blank
```
### Configuración del Entorno
Dentro del entorno creado, tenemos una carpeta importante llamada `sql`, en ella tenemos que importar los archivos de creación de base de datos (nos lo tienen que dar).

En el archivo de settings, tenemos que reflejar los archivos sql en el siguiente apartado:
```py
SQL_SCRIPTS = [
    "tables.sql",
    "populate.sql"
]
```
Y en `DB_CONN`, en el apartado `database`escribimos el nombre de la base de datos que tengamos creada (en Heidi).

### Definición BD
Para ejecutar los scripts de sql, escribimos el siguiente comando en la terminal, es importante tenerlos definidos en settings, pues eso es lo que va a ejercutar silence.
```cmd
silence createdb
```
Y para definir los `ednpoints` del proyecto, ejecutamos:
```cmd
silence createapi
```
Para la `ejecución` del proyecto:
```cmd
silence run
```
Y ya empezará a funcionar y a correr todo lo que hemos preparado :)

## Consultas GET
Creamos una carpeta en la raíz madre del proyecto llamada `request`. En la cual tenemos que crear un archivo `peticiones.http`. En este archivo vamos a hacer las consultas del proyecto, con ayuda de la api `REST CLIENT`.

Para empezar el fichero, definimos la base:
```fix
@BASE = http://127.0.0.1/8080/api/v1
```
Y para probarla:
```JAVASCRIPT
GET {{BASE}}/degrees
```
El servidor devolverá un archivo json al pulsar en `send request`.

Podemos obtener muchísimas cosas, por ejemplo para obtener una id de grados:

```JAVASCRIPT
GET {{BASE}}/degrees/2
```
Con lo que obtendremos el grado con id = 2.

### Registro
### Creación, Actualización y Borrado
### Definición de EndPoints Personalizados