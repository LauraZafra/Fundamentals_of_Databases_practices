drop table ventas;


CREATE TABLE ventas(
             codpro CONSTRAINT codpro_clave_externa_proveedor
               REFERENCES  proveedor(codpro),
             codpie CONSTRAINT codpie_clave_externa_pieza
               REFERENCES  pieza(codpie),
             codpj CONSTRAINT codpj_clave_externa_proyecto
               REFERENCES proyecto(codpj),
             cantidad NUMBER(4),
             CONSTRAINT clave_primaria PRIMARY KEY (codpro,codpie,codpj));
             
alter table ventas add (fecha date);             
             
             
-- por asegurar se borran los datos
delete from ventas;

-- se insertan los datos
INSERT INTO ventas VALUES ('S1', 'P1', 'J1', 150, TO_DATE('18/09/1997','dd/mm/yyyy')); 
INSERT INTO ventas VALUES ('S1', 'P1', 'J2', 100, TO_DATE('06/05/1996','dd/mm/yyyy')); 
INSERT INTO ventas VALUES ('S1', 'P1', 'J3', 500, TO_DATE('06/05/1996','dd/mm/yyyy')); 
INSERT INTO ventas VALUES ('S1', 'P2', 'J1', 200, TO_DATE('22/07/1995','dd/mm/yyyy')); 
INSERT INTO ventas VALUES ('S2', 'P2', 'J2', 15, TO_DATE('23/11/2004','dd/mm/yyyy')); 
INSERT INTO ventas VALUES ('S4', 'P2', 'J3', 1700, TO_DATE('28/11/2000','dd/mm/yyyy')); 
INSERT INTO ventas VALUES ('S1', 'P3', 'J1', 800, TO_DATE('22/07/1995','dd/mm/yyyy')); 
INSERT INTO ventas VALUES ('S5', 'P3', 'J2', 30, TO_DATE('01/04/2014','dd/mm/yyyy')); 
INSERT INTO ventas VALUES ('S1', 'P4', 'J1', 10, TO_DATE('22/07/1995','dd/mm/yyyy')); 
INSERT INTO ventas VALUES ('S1', 'P4', 'J3', 250, TO_DATE('09/03/1994','dd/mm/yyyy')); 
INSERT INTO ventas VALUES ('S2', 'P5', 'J2', 300, TO_DATE('23/11/2004','dd/mm/yyyy')); 
INSERT INTO ventas VALUES ('S2', 'P2', 'J1', 4500, TO_DATE('15/08/2004','dd/mm/yyyy')); 
INSERT INTO ventas VALUES ('S3', 'P1', 'J1', 90, TO_DATE('09/06/2004','dd/mm/yyyy')); 
INSERT INTO ventas VALUES ('S3', 'P2', 'J1', 190, TO_DATE('12/04/2002','dd/mm/yyyy')); 
INSERT INTO ventas VALUES ('S3', 'P5', 'J3', 20, TO_DATE('28/11/2000','dd/mm/yyyy')); 
INSERT INTO ventas VALUES ('S4', 'P5', 'J1', 15, TO_DATE('12/04/2002','dd/mm/yyyy')); 
INSERT INTO ventas VALUES ('S4', 'P3', 'J1', 100, TO_DATE('12/04/2002','dd/mm/yyyy')); 
INSERT INTO ventas VALUES ('S4', 'P1', 'J3', 1500, TO_DATE('26/01/2003','dd/mm/yyyy')); 
INSERT INTO ventas VALUES ('S1', 'P4', 'J4', 290, TO_DATE('09/03/1994','dd/mm/yyyy')); 
INSERT INTO ventas VALUES ('S1', 'P2', 'J4', 175, TO_DATE('09/03/1994','dd/mm/yyyy')); 
INSERT INTO ventas VALUES ('S5', 'P1', 'J4', 400, TO_DATE('01/04/2014','dd/mm/yyyy')); 
INSERT INTO ventas VALUES ('S5', 'P3', 'J3', 400, TO_DATE('01/04/2014','dd/mm/yyyy'));
INSERT INTO ventas VALUES ('S1', 'P5', 'J1', 340, TO_DATE('06/02/2010','dd/mm/yyyy'));

-- Ejercicio 2.4
insert into ventas values ('S3', 'P1', 'J1', 150, '24/12/05'); --- viola la clave primaria linea 33 (+ formato fecha?)
insert into ventas (codpro, codpj) values ('S4', 'J2'); -- falta añadir codpie, es null y no se puede
insert into ventas values ('S5', 'P3', 'J6', 400, to_date('24/12/05')); -- clave externa proyecto violada: no existe J6
insert into ventas values ('S5', 'P3', 'J1', 400, to_date('24/12/05')); -- esto si funciona
delete from ventas where (ventas.codpro='S5' and ventas.codpj='J1' and ventas.codpie='P3');

-- Ejercicio 2.5
update ventas set fecha = to_date(2005, 'YYYY') where codpro='S5'; -- no se actualiza ninguna fila

-- Ejercicio 2.6
select codpro, codpie, to_char(fecha, '"Dia" day,dd/mm/yy') from ventas;

--a partir de esta entrada no se crean porque o hay proveedores con la clave S6 y S7
INSERT INTO ventas VALUES ('S6', 'P1', 'J1', 340, TO_DATE('10/02/2006','dd/mm/yyyy'));
INSERT INTO ventas VALUES ('S6', 'P1', 'J2', 340, TO_DATE('10/02/2006','dd/mm/yyyy'));
INSERT INTO ventas VALUES ('S6', 'P1', 'J3', 340, TO_DATE('10/02/2006','dd/mm/yyyy'));
INSERT INTO ventas VALUES ('S6', 'P1', 'J4', 340, TO_DATE('10/02/2006','dd/mm/yyyy'));
INSERT INTO ventas VALUES ('S7', 'P1', 'J1', 340, TO_DATE('10/02/2006','dd/mm/yyyy'));
INSERT INTO ventas VALUES ('S7', 'P1', 'J2', 340, TO_DATE('10/02/2006','dd/mm/yyyy'));
INSERT INTO ventas VALUES ('S7', 'P1', 'J3', 340, TO_DATE('10/02/2006','dd/mm/yyyy'));
INSERT INTO ventas VALUES ('S7', 'P1', 'J4', 340, TO_DATE('10/02/2006','dd/mm/yyyy'));

-- se comprueba el resultado
select * from ventas;             