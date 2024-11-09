drop table faltas;
drop table encuentros;
drop table jugadores;
drop table equipos;
--importante orden de los drop

--Instrucción para ver todas las tablas que tengo creadas
--select table_name from user_tables;

-- dos restricciones no pueden llamarse igual aunque estén en tablas diferentes: pongo el nombre de la tabla al nombre
-- no puedo poner nombres demasiado largos a las restricciones: da error
create table equipos(
    codE int constraint eq_codE_NN NOT NULL constraint eq_codE_CP PRIMARY KEY, 
    nombreE varchar(10) constraint eq_nombreE_NN NOT NULL,
    localidad varchar(10) constraint eq_localidad_NN NOT NULL,
    entrenador varchar(20) constraint eq_entrenador_NN NOT NULL,
    fecha_crea date constraint eq_fechacrea_NN NOT NULL
);

create table jugadores(
    codJ int constraint jug_codJ_CP primary key,
    codE references equipos(codE) constraint jug_codE_NN not null, -- references tiene que ir primero
    nombreJ varchar(10) constraint jug_nombre_NN not null
);

create table encuentros(
    
    ELocal references equipos(codE),
    EVisitante references equipos(codE),
    fecha date,
    PLocal int default 0 constraint en_PLocal_CK check (PLocal >= 0), --default tiene que ir primero
    PVisitante int default 0 constraint en_PVisitante_CK check (PVisitante >= 0),
    constraint en_CP primary key (ELocal, EVisitante) --clave primaria después de declarar los atributos
);

create table faltas(
    
    codJ references jugadores(codJ),
    ELocal,
    EVisitante,
    foreign key (ELocal, EVisitante) references encuentros(ELocal, EVisitante), --después de haber declarado los atributos
    num_f int default 0 constraint fal_num_f_CK check (num_f >= 0 and num_f <= 5),
    constraint fal_CP primary key (codJ, ELocal, EVisitante)
);

