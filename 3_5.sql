-- DIVISION
-- Ejemplo: Encontrar proveedores que suministren todas las piezas
SELECT codpro FROM proveedor
           WHERE NOT EXISTS (
                (SELECT DISTINCT codpie FROM pieza)
                      MINUS
                (SELECT DISTINCT codpie FROM ventas WHERE proveedor.codpro=ventas.codpro)
            );

-- Ejercicio 3.24 Encontrar los códigos de las piezas suministradas a todos los proyectos localizados en Londres.
select codpie from pieza 
    where not exists (
        (select distinct codpj from proyecto where ciudad = 'Londres')
        minus
        (select distinct codpj from ventas where pieza.codpie = ventas.codpie)
    );
    
-- Ejercicio 3.25 Encontrar aquellos proveedores que envían piezas procedentes de todas las ciudades donde hay un proyecto.
select codpro from proveedor
    where not exists (
        (select distinct ciudad from proyecto)
        minus
        (select distinct ciudad from ventas natural join proyecto)
    );
    -- REVISAR