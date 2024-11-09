-- ORDENACIÓN

-- Ejemplo 3.13 Encontrar los nombres de proveedores ordenados alfabéticamente.
SELECT nompro FROM proveedor ORDER BY nompro;

-- Ejercicio 3.17 Comprobar la salida de la consulta anterior sin la cláusula ORDER BY.
SELECT nompro FROM proveedor; -- no salen ordenados

-- Ejercicio 3.18 Listar las ventas ordenadas por cantidad, si algunas ventas coinciden en la cantidad se ordenan en función de la fecha de manera descendente. 
select * from ventas order by cantidad, fecha desc;