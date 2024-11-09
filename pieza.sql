drop table ventas;
drop table pieza;

CREATE TABLE pieza (
             codpie VARCHAR2(3) CONSTRAINT codpie_clave_primaria PRIMARY KEY,
             nompie VARCHAR2(10) CONSTRAINT nompie_no_nulo NOT NULL,
             color VARCHAR2(10),
             peso NUMBER(5,2)
               CONSTRAINT peso_entre_0_y_100 CHECK (peso>0 and peso<=100),
             ciudad VARCHAR2(15));
             
insert into pieza (codpie, nompie, color, peso, ciudad) values 
    ('P1', 'Tuerca', 'Gris', 2.5, 'Madrid');             
    
insert into pieza (codpie, nompie, color, peso, ciudad) values 
    ('P2', 'Tornillo', 'Rojo', 1.25, 'Paris');  
    
insert into pieza (codpie, nompie, color, peso, ciudad) values 
    ('P3', 'Arandela', 'Blanco', 3, 'Londres'); 
    
insert into pieza (codpie, nompie, color, peso, ciudad) values 
    ('P4', 'Clavo', 'Gris', 5.5, 'Lisboa');  
    
insert into pieza (codpie, nompie, color, peso, ciudad) values 
    ('P5', 'Alcayata', 'Blanco', 10, 'Roma');     