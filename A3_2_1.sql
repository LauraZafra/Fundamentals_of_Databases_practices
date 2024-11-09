select ciudad from proyecto;

-- para no repetir Londres
select distinct ciudad from proyecto;
-- la proyección muestra los atributos de las tuplas que se pidan

-- para ver todos los atributos = proyección de todos los atributos
select * from proveedor;

select codpro, nompro, status, ciudad from proveedor;

select codpro, codpie, codpj from ventas;
-- ya no es necesario usar distinct porque no hay tuplas que se repitan





