drop table ventas;
drop table proveedor;

CREATE TABLE proveedor(
             codpro VARCHAR2(3) CONSTRAINT codpro_no_nulo NOT NULL
               CONSTRAINT codpro_clave_primaria PRIMARY KEY,
             nompro VARCHAR2(30) CONSTRAINT nompro_no_nulo NOT NULL,
             status NUMBER CONSTRAINT status_entre_1_y_10
               CHECK (status>=1 and status<=10),
             ciudad VARCHAR2(15));
            
select * from proveedor;
describe proveedor;
             
insert into proveedor (codpro, nompro, status, ciudad) values 
    ('S1', 'Jose Fernandez', 2, 'Madrid');   --las comillas son simples, con dobles no funciona
    
insert into proveedor (codpro, nompro, status, ciudad) values 
    ('S2', 'Manuel Vidal', 1, 'Londres');   
    
insert into proveedor (codpro, nompro, status, ciudad) values 
    ('S3', 'Luisa Gomez', 3, 'Lisboa');
    
insert into proveedor (codpro, nompro, status, ciudad) values 
    ('S4', 'Pedro Sanchez', 4, 'Paris');   
    
insert into proveedor (codpro, nompro, status, ciudad) values 
    ('S5', 'Maria Reyes', 5, 'Roma');     

--Mostrar lo que tengo
select * from proveedor;