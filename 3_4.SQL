-- SUBCONSULTAS
-- Ejemplo 3.14 Encontrar las piezas suministradas por proveedores de Londres. (Sin usar el operador de reunión.) 
SELECT codpie FROM ventas WHERE codpro IN (SELECT codpro FROM proveedor WHERE ciudad = 'Londres');

-- Ejercicio 3.19 Mostrar las piezas vendidas por los proveedores de Madrid. 
-- (Fragmentando la consulta con ayuda del operador IN.) Compara la solución con la del ejercicio 3.15. 
select distinct codpie from ventas where codpro in (select codpro from proveedor where ciudad = 'Madrid');

-- Ejercicio 3.20 Encuentra los proyectos que están en una ciudad donde se fabrica alguna pieza. 
select codpj from proyecto where ciudad in (select ciudad from pieza);

-- Ejercicio 3.21 Encuentra los códigos de aquellos proyectos que no utilizan ninguna pieza roja que esté suministrada por un proveedor de Londres.
select distinct codpj from ventas where codpie not in (select codpie from pieza where color = 'Rojo') and codpro not in (select codpro from proveedor where ciudad = 'Londres');


-- EXISTS
-- Ejemplo 3.15 Encontrar los proveedores que suministran la pieza ’P1’. 
SELECT codpro FROM proveedor WHERE EXISTS (SELECT * FROM ventas WHERE ventas.codpro = proveedor.codpro AND ventas.codpie='P1');


-- COMPARADORES
-- Ejemplo 3.16 Muestra el código de los proveedores cuyo estatus sea igual al del proveedor ’S3’. 
SELECT codpro FROM proveedor WHERE status = (SELECT status FROM proveedor WHERE codpro='S3');

-- Ejemplo 3.17 Muestra el código de las piezas cuyo peso es mayor que el peso de alguna pieza ’tornillo’. 
SELECT codpie FROM pieza WHERE peso > ANY (SELECT peso FROM pieza WHERE nompie LIKE 'Tornillo%');

-- Ejercicio3.22 Muestra el código de las piezas cuyo peso es mayor que el peso de cualquier ’tornillo’. 
select codpie from pieza where peso > any (SELECT peso FROM pieza WHERE nompie LIKE 'Tornillo%');

-- Ejercicio3.23 Encuentra las piezas con peso máximo. Compara esta solución con la obtenida en el ejercicio 3.14
select peso from pieza where peso >= all (select peso from pieza); -- misma sol
