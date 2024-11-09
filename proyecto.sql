drop table ventas;
drop table proyecto;

CREATE TABLE proyecto(
             codpj VARCHAR2(3) CONSTRAINT codpj_clave_primaria PRIMARY KEY,
             nompj VARCHAR2(20) CONSTRAINT nompj_no_nulo NOT NULL,
             ciudad VARCHAR2(15));
             
insert into proyecto values ('J1', 'Proyecto 1', 'Londres');             
insert into proyecto values ('J2', 'Proyecto 2', 'Londres');
insert into proyecto values ('J3', 'Proyecto 3', 'Paris'); 
insert into proyecto values ('J4', 'Proyecto 4', 'Roma'); 