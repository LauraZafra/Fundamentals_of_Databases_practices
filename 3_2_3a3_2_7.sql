-- consultar con más detalle algunas de las vistas del catálogo
SELECT table_name FROM USER_TABLES;

-- Ejemplo 3.7 Mostrar la información de todas las tablas denominadas ventas a las que tienes acceso
SELECT table_name FROM ALL_TABLES WHERE TABLE_NAME like '%ventas';
-- Cuando se emplea el carácter comodín %, éste se sustituye por cualquier cadena de 0 ó más caracteres

-- Ejercicio 3.6 Comprueba que no devuelve ninguna. Pero SI que hay!!!. Prueba a usar la función upper() 
-- comparando con ’VENTAS’ o la función lower() comparando con ’ventas’
SELECT table_name FROM ALL_TABLES WHERE table_name like upper('%ventas');
--SELECT table_name FROM ALL_TABLES WHERE table_name like lower('%ventas');
-- describe ALL_TABLES;

-- Ejemplo 3.8 Ciudades donde viven proveedores con status mayor de 2 en las que no se fabrica la pieza ’P1’
(select distinct ciudad from proveedor where status > 2) minus (select distinct ciudad from pieza where codpie = 'P1');

-- Ejercicio 3.7 Resolver la consulta del ejemplo 3.8 utilizando el operador ∩.
(select distinct ciudad from proveedor where status > 2) intersect (select distinct ciudad from pieza where codpie != 'P1');

-- Ejercicio 3.8 Encontrar los códigos de aquellos proyectos a los que sólo abastece ’S1'
(select distinct codpj from proyecto) minus (select  codpj from ventas where codpro != 'S1');

-- Ejercicio 3.9 Mostrar todas las ciudades de la base de datos. Utilizar UNION
(select distinct ciudad from pieza) union (select distinct ciudad from proveedor) union (select distinct ciudad from proyecto);
-- en la tabla ventas no existe el atributo ciudad
-- las ciudades no se repiten

-- Ejercicio 3.10 Mostrar todas las ciudades de la base de datos. Utilizar UNION ALL
(select distinct ciudad from pieza) union all (select distinct ciudad from proveedor) union all (select distinct ciudad from proyecto);
-- las ciudades se repiten aunque este el distinct, no se repiten en una misma tabla

-- Ejercicio 3.11 Comprueba cuántas tuplas resultan del producto cartesiano aplicado a ventas y proveedor
select * from ventas, proveedor;
-- 

-- Ejemplo 3.9 Muestra las posibles ternas (codpro,codpie,codpj) tal que, todos los implicados sean de la misma ciudad
SELECT codpro, codpie, codpj FROM proveedor, proyecto, pieza WHERE proveedor.ciudad=proyecto.ciudad AND proyecto.ciudad=pieza.ciudad;

-- Ejemplo 3.10 Mostrar las ternas (codpro,codpie,codpj) tal que todos los implicados son de Londres
SELECT codpro,codpie,codpj FROM (SELECT * FROM proveedor WHERE ciudad='Londres'),(SELECT * FROM pieza WHERE ciudad='Londres'), (SELECT * FROM proyecto WHERE ciudad='Londres');

-- Ejercicio 3.12 Mostrar las ternas que son de la misma ciudad pero que hayan realizado alguna venta.
(SELECT codpro,codpie,codpj FROM proveedor, proyecto, pieza WHERE proveedor.ciudad=proyecto.ciudad AND proyecto.ciudad=pieza.ciudad)
    intersect (SELECT codpro,codpie,codpj FROM ventas);

-- Ejemplo 3.11 Muestra las posibles ternas (codpro,codpie,codpj) tal que todos los implicados sean de la misma ciudad (mismo resultado ejemplo 3.9)
SELECT codpro, codpie, codpj FROM proveedor S, proyecto Y, pieza P WHERE S.ciudad=Y.ciudad and Y.ciudad=P.ciudad;

-- Ejercicio 3.13 Encontrar parejas de proveedores que no viven en la misma ciudad.
select * from proveedor X, proveedor Y where X.ciudad!=Y.ciudad;

-- Ejercicio 3.14 Encuentra las piezas con máximo peso.
-- Ej parecido Relax:  π ventas.cantidad (ventas) - π ventas.cantidad (σ ventas.cantidad>ven.cantidad (ventas ⨯ ρ ven (ventas))) <-- cantidad + peq
(select peso from pieza) minus (select MENOS_PESO.peso from pieza MAS_PESO, pieza MENOS_PESO where MENOS_PESO.peso<MAS_PESO.peso);

-- Ejemplo 3.12 Mostrar los nombres de proveedores y cantidad de aquellos que han realizado alguna venta en cantidad superior a 800 unidades.
SELECT nompro, cantidad FROM proveedor NATURAL JOIN (SELECT * FROM ventas WHERE cantidad>800);
-- expresión equivalente sin usar el operador natural join. Nótese que es preciso el uso de alias sobre la tabla y la subconsulta involucradas en
-- el producto cartesiano
SELECT nompro, cantidad FROM proveedor s, (SELECT * FROM ventas WHERE cantidad>800) v WHERE s.codpro= v.codpro;
SELECT nompro, cantidad FROM proveedor s JOIN (SELECT * FROM ventas WHERE cantidad>800) v ON (s.codpro=v.codpro); <-- equireunión

-- Ejercicio 3.15 Mostrar las piezas vendidas por los proveedores de Madrid.
-- ventas del proveedor de Madrid
-- select * from ventas natural join (select codpro from proveedor where ciudad = 'Madrid');
select nompie from pieza natural join (select * from ventas natural join (select codpro from proveedor where ciudad = 'Madrid'));

-- Ejercicio 3.16 Encuentra la ciudad y los códigos de las piezas suministradas a cualquier proyecto por un proveedor que está en la misma ciudad donde está el proyecto.
-- ciudad y los códigos de las piezas suministradas
-- select ciudad, codpie from pieza natural join (select codpro, codpie, codpj from ventas);
-- parejas de proyecto y proveedor en la misma ciudad entre las que hay suministro
-- select codpj, codpro, ciudad from proyecto natural join (select codpro, codpj from ventas) natural join (select codpro, ciudad from proveedor);  
-- select ciudad, codpie from proyecto A, (select * from proveedor) B  where A.ciudad=B.ciudad;
-- Ejercicio entero
select ciudad, codpie from pieza natural join (select codpro, codpie, codpj from ventas) natural join 
(select codpj, codpro, ciudad from proyecto natural join (select codpro, ciudad from proveedor));

-- Ejercicio Relax:
-- e) Encontrar todas las parejas de ciudades tales que la primera sea la de un proveedor y la 
-- segunda la de un proyecto entre los cuales haya algún suministro.
select proveedor.ciudad, proyecto.ciudad from proveedor, ventas, proyecto where proveedor.codpro = ventas.codpro and proyecto.codpj = ventas.codpj;

