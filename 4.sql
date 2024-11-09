-- CAPITULO 4: VISTAS
-- Ejemplo 4.1 Extraer el conjunto de suministros realizados sólo con integrantes procedentes de Paris.
  CREATE VIEW VentasParis (codpro,codpie,codpj,cantidad,fecha) AS
          SELECT codpro,codpie,codpj,cantidad,fecha
          FROM ventas
          WHERE (codpro,codpie,codpj) IN
              (SELECT codpro,codpie,codpj
               FROM proveedor,pieza,proyecto
               WHERE proveedor.ciudad='Paris' AND
                     pieza.ciudad='Paris' AND
                     proyecto.ciudad='Paris');
                     
-- Ejemplo 4.2 Extraer el conjunto de piezas procedentes de Londres, prescindiendo del atributo ciudad de la tabla original. 
CREATE VIEW PiezasLondres AS
     SELECT codpie, nompie, color, peso FROM Pieza
     WHERE  pieza.ciudad='Londres';
     -- Sobre la vista anterior hacemos una inserción del tipo:
INSERT INTO PiezasLondres
        VALUES('P9','Pieza 9','rojo',90);
        
-- Ejercicio 4.1 Crear una vista con los proveedores de Londres. ¿Qué sucede si insertamos 
-- en dicha vista la tupla(’S7’,’Jose Suarez’,3,’Granada’)?.(Buscaren[13]lacláusula WITH CHECK OPTION ). 
create view ProveedoresLondres (codpro, nompro, status) as
    select codpro, nompro, status
    from proveedor
    where (proveedor.ciudad = 'Londres');
    
insert into ProveedoresLondres values ('S7','Jose Suarez',3,'Granada'); -- da error: too many values   

-- Ejercicio 4.2 Crear una vista con los nombres de los proveedores y sus ciudades. 
-- Inserta sobre ella una fila y explica cuál es el problema que se plantea. ¿Habría problemas de actualización?
create view ProveedoresCiudad (nompro, ciudad) as
    select nompro, ciudad
    from proveedor;
-- el problema es que no tiene clave primaria:
insert into ProveedoresCiudad ('Juan', 'Barcelona');

-- Ejercicio 4.3 Crear una vista donde aparezcan el código de proveedor, el nombre de proveedor 
-- y el código del proyecto tales que la pieza sumistrada sea gris. Sobre esta vista realiza 
-- alguna consulta y enumera todos los motivos por los que sería imposible realizar una inserción. 

     