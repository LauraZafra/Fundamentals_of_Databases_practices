-- DATE
-- Ejemplo 3.25 Lista las fechas de las ventas en un formato día, mes y año con 4 dígitos
SELECT TO_CHAR(fecha,'DD-MM-YYYY') FROM ventas;

-- Ejemplo 3.26 Encontrar las ventas realizadas entre el 1 de enero de 2002 y el 31 de diciembre de 2004.
SELECT *  FROM ventas WHERE fecha BETWEEN TO_DATE('01/01/2002','DD/MM/YYYY') AND TO_DATE('31/12/2004','DD/MM/YYYY');

-- Ejercicio3.37 Comprueba que no funciona correctamente si las comparaciones de fechas se hacen con cadenas.
SELECT *  FROM ventas WHERE fecha BETWEEN '01/01/2002' AND '31/12/2004';

-- Ejemplo 3.27 Mostrar las piezas que nunca fueron suministradas despues del año 2001.
(SELECT DISTINCT codpie FROM pieza)
        MINUS
     (SELECT DISTINCT codpie FROM ventas
      WHERE TO_NUMBER(TO_CHAR(fecha,'YYYY')) > 2001);
      
SELECT p.codpie FROM pieza p WHERE NOT EXISTS
(SELECT * FROM ventas v WHERE TO_NUMBER(TO_CHAR(v.fecha,'YYYY')) > 2001
   AND v.codpie=p.codpie);      
   
-- Ejemplo 3.28 Agrupar los suministros de la tabla de ventas por años y sumar las cantidades totales anuales.
SELECT TO_CHAR(fecha,'YYYY'), SUM(cantidad) FROM ventas GROUP BY TO_CHAR(fecha,'YYYY');

-- Ejercicio 3.38 Encontrar la cantidad media de piezas suministradas cada mes.
select to_char(fecha, 'MON'), avg(cantidad) from ventas group by to_char(fecha, 'MON');


-- OTRAS CONSULTAS
-- Ejemplo 3.29 Mostrar la información de todos los usuarios del sistema; la vista que nos interesa es ALL_USERS.
SELECT * FROM ALL_USERS;

-- ver el esquema de la vista all_users
DESCRIBE ALL_USERS;

-- Ejemplo 3.30 Queremos saber qué índices tenemos definidos sobre nuestras tablas, pero en esta 
-- ocasión vamos a consultar al propio catálogo para que nos muestre algunas de las vistas que 
-- contiene (así ya no necesitamos chuleta). 
DESCRIBE DICTIONARY;
SELECT * FROM DICTIONARY WHERE table_name LIKE '%INDEX%';

-- Ejercicio 3.39 ¿ Cuál es el nombre de la vista que tienes que consultar y qué campos te pueden interesar?
-- El nombre de la vista es dictionary

-- Ejercicio 3.40 Muestra las tablas ventas a las que tienes acceso de consulta junto con el nombre 
-- del propietario y su número de identificación en el sistema.
SELECT USERNAME FROM user_tables WHERE table_name LIKE '%VENTAS%';

-- Ejercicio 3.41 Muestra todos tus objetos creados en el sistema. ¿Hay algo más que tablas?





