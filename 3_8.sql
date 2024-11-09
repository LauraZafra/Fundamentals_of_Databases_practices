----------------------------------------
-- Laura Zafra Alarcos - GIIADE
----------------------------------------

----------------------------------------
-- CONSULTAS SIN OPERADORES DE AGREGACIÓN
----------------------------------------

-- Ejercicio 3.60 Muestra la información disponible acerca de los encuentros de liga.
select * from encuentros;

-- Ejercicio 3.61 Muestra los nombres de los equipos y de los jugadores ordenados alfabéticamente.
select nombreE from equipos order by nombreE;
select nombreJ from jugadores order by nombreJ;

-- Ejercicio 3.62 Muestra los jugadores que no tienen ninguna falta.
select codJ from jugadores minus (select codJ from faltas where num_f>0);

-- Ejercicio 3.63 Muestra los compañeros de equipo del jugador que tiene por código x (codJ=’x’) y donde x es uno elegido por ti.
select * from jugadores natural join (select codE from jugadores where codJ=1);

-- Ejercicio 3.64 Muestra los jugadores y la localidad donde juegan (la de sus equipos). 
select * from jugadores natural join (select codE, localidad from equipos);

-- Ejercicio 3.65 Muestra todos los encuentros posibles de la liga.
select F.nombreE, G.nombreE from equipos F, equipos G where F.nombreE != G.nombreE;
 
-- Ejercicio 3.66 Muestra los equipos que han ganado algún encuentro jugando como local.
select distinct codE, nombreE from equipos, encuentros where (codE=encuentros.ELocal and PLocal > PVisitante); 

--Ejercicio 3.67 Muestra los equipos que han ganado algún encuentro.
select distinct codE, nombreE from equipos, encuentros where (codE=encuentros.ELocal and PLocal > PVisitante) or (codE=encuentros.EVisitante and PLocal < PVisitante);

-- Ejercicio 3.68 Muestra los equipos que todos los encuentros que han ganado lo han hecho como equipo local. 
select distinct codE, nombreE from equipos, encuentros where (codE=encuentros.ELocal and PLocal > PVisitante) minus select distinct codE, nombreE from equipos, encuentros where (codE=encuentros.EVisitante and PLocal < PVisitante);

-- Ejercicio 3.69 Muestra los equipos que han ganado todos los encuentros jugando como equipo local.
select codE, nombreE from equipos where not exists(
    (select distinct ELocal from encuentros)
    minus
    (select distinct ELocal from encuentros where PLocal > PVisitante)
);

-- Ejercicio 3.70 Muestra los encuentros que faltan para terminar la liga. Suponiendo que en la tabla Encuentros sólo se almacenan los encuentros celebrados hasta la fecha.
(select F.codE, G.codE from equipos F, equipos G where F.codE != G.codE) minus (select ELocal, EVisitante from encuentros);

-- Ejercicio 3.71 Muestra los encuentros que tienen lugar en la misma localidad.
select a.codE, b.codE, a.localidad, b.localidad from equipos a, equipos b where(a.localidad = b.localidad and a.codE != b.codE);

----------------------------------------
-- CONSULTAS CON OPERADORES DE AGREGACIÓN
----------------------------------------

-- Ejercicio 3.72 Para cada equipo muestra cantidad de encuentros que ha disputado como local.
select count(*) from encuentros group by ELocal;

-- Ejercicio 3.73 Muestra los encuentros en los que se alcanzó mayor diferencia.
select ELocal, EVisitante, abs(PLocal - PVisitante) from encuentros where abs(PLocal - PVisitante) = (select max(abs(PLocal - PVisitante)) from encuentros);  
 
-- Ejercicio 3.74 Muestra los jugadores que no han superado 3 faltas acumuladas. 
select codJ, ELocal, EVisitante from faltas where num_f < 4;

-- Ejercicio 3.75 Muestra los equipos con mayores puntuaciones en los partidos jugados fuera de casa.
select max(PVisitante) from encuentros;

-- Ejercicio 3.76 Muestra la cantidad de victorias de cada equipo, jugando como local o como visitante.
-- numero de victorias locales de cada equipo
(select ELocal, count(*) from (select codE from equipos), (select ELocal from encuentros where PLocal>PVisitante) where codE=ELocal group by ELocal); 
-- numero de victorias visitantes de cada equipo
(select EVisitante, count(*) from (select codE from equipos), (select EVisitante from encuentros where PLocal<PVisitante) where codE=EVisitante group by EVisitante); 
-- union de las dos
select codE, count(*) from (select codE from equipos), encuentros 
    where ((codE = EVisitante and PLocal<PVisitante) or (codE = ELocal and PLocal>PVisitante)) group by codE;

-- Ejercicio 3.77 Muestra el equipo con mayor número de victorias.
select max(count(*)) as victorias from (select codE from equipos), encuentros 
    where ((codE = EVisitante and PLocal<PVisitante) or (codE = ELocal and PLocal>PVisitante)) 
    group by codE;        

-- Ejercicio 3.78 Muestra el promedio de puntos por equipo en los encuentros de ida.
select ELocal, avg(PLocal) as media_puntos from encuentros group by ELocal;

-- Ejercicio 3.79 Muestra el equipo con mayor número de puntos en total de los encuentros jugados.
select max(sum(p)) as puntos from (select codE from equipos), encuentros 
    where ((select sum(PVisitante) as p from encuentros where codE = EVisitante group by EVisitante) or 
          (select sum(PLocal) as p from encuentros where codE = PLocal group by ELocal)) 
    group by codE;    
