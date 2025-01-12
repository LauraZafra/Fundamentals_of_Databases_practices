EJERCICIO 3.3. Piezas de Madrid que son grises o rojas.

select codpie
from pieza
where ciudad='Madrid' and (color='Gris' or color='Rojo')

EJERCICIO 3.4. Encontrar todos los suministros cuya cantidad está entre 200 y 300, ambos
inclusive.

select codpie,codpj,codpro
from ventas
where (cantidad >= 200 and cantidad <= 250);

EJERCICIO 3.5. Mostrar las piezas que contengan la palabra tornillo con la t en
mayúscula o en minúscula.

select codpie
from pieza
where nompie like '_ornillo';

EJERCICIO 3.7. Resolver la consulta del ejemplo 3.8 utilizando el operador intersección.

(select distinct ciudad FROM proveedor WHERE status>2)
intersect
(select distinct ciudad FROM pieza WHERE codpie!='P1');


EJERCICIO 3.8. Encontrar los códigos de aquellos proyectos a los que sólo abastece ’S1’.

select codpj
from ventas
MINUS
select codpj
from ventas
where codpro!='S1';

EJERCICIO 3.9. Mostrar todas las ciudades de la base de datos. Utilizar UNION.

select ciudad
from proveedor
UNION
select ciudad
from proyecto
UNION
select ciudad
from pieza;

EJERCICIO 3.1O. Mostrar todas las ciudades de la base de datos. Utilizar UNION ALL.

select ciudad
from proveedor
UNION ALL
select ciudad
from proyecto
UNION ALL
select ciudad
from pieza;

EJERCICIO 3.11. Comprueba cuántas tuplas resultan del producto cartesiano aplicado a ventas
y proveedor.

select * from ventas,proveedor;

Resultan 217 tuplas, ya que tenemos 31 ventas y 7 proveedores, luego 31x7=217

EJERCICIO 3.12. Mostrar las ternas que son de la misma ciudad pero que hayan realizado
alguna venta.

(select codpro, codpie, codpj
from proveedor, pieza, proyecto
where proveedor.ciudad=pieza.ciudad and pieza.ciudad=proyecto.ciudad)
INTERSECT
(select codpro, codpie, codpj
from ventas);

OTRA FORMA

select codpro, codpie, codpj
from proveedor, pieza, proyecto, ventas
where proveedor.ciudad=pieza.ciudad and pieza.ciudad=proyecto.ciudad
and proveedor.codpro=ventas.codpro and pieza.codpie=ventas.codpie and
proyecto.codpj=ventas.codpj;

EJERCICIO 3.13. Encontrar parejas de proveedores que no viven en la misma ciudad.

select P.codpro, S.codpro
from proveedor P, proveedor S
where P.ciudad>S.ciudad; (Para que no aparezca dos veces la misma pareja)

EJERCICIO 3.14. Encuentra las piezas con máximo peso.

(select codpie
from pieza)
MINUS
(select P.codpie
from pieza P, pieza S
where P.peso<S.peso);

EJERCICIO 3.15. Mostrar las piezas vendidas por los proveedores de Madrid.

select distinct codpie
from ventas NATURAL JOIN (select * from proveedor where ciudad='Madrid');

EJERCICIO 3.16. Encuentra la ciudad y los códigos de las piezas suministradas
a cualquier proyecto por un proveedor que está en la misma ciudad donde está 
el proyecto.

select DISTINCT codpie, nompie
from pieza NATURAL JOIN(
select codpie
from ventas NATURAL JOIN (
select * from proveedor NATURAL JOIN proyecto));

EJERCICIO 3.17. Comprobar la salida de la consulta anterior sin la cláusula ORDER BY.

La única diferencia es que al quitar el ORDER BY no salen ordenados alfabéticamente.

EJERCICIO 3.18. Listar las ventas ordenadas por cantidad, si algunas ventas coinciden
en la cantidad se ordenan en función de la fecha de manera descendente.

select *
from ventas
order by cantidad, fecha DESC;

EJERCICIO 3.19. Mostrar las piezas vendidas por los proveedores de Madrid. (Fragmentando
la consulta con ayuda del operador IN.) Compara la solución con la del ejercicio 3.15.

select codpie
from ventas
where codpro in (select codpro from proveedor where ciudad='Madrid');

EJERCICIO 3.20. Encuentra los proyectos que están en una ciudad donde se fabrica alguna pieza.

select codpj
from proyecto
where ciudad in (select ciudad from pieza);

Sin el operador IN, lo haría así:

select codpj
from proyecto NATURAL JOIN (select ciudad from pieza);

EJERCICIO 3.21. Encuentra los códigos de aquellos proyectos que no utilizan ninguna pieza
roja que esté suministrada por un proveedor de Londres.

(select codpj
from proyecto)
MINUS
(select codpj
from ventas
where codpie in (select codpie from pieza where color='Rojo') and 
codpro in (select codpro from proveedor where ciudad='Londres'));

EJERCICIO 3.22. Muestra el código de las piezas cuyo peso es mayor que el peso de cualquier 'tornillo'.

select codpie
from pieza
where peso > all(select peso from pieza where nompie like 'Tornillo%');

EJERCICIO 3.23. Encuentra las piezas con peso máximo. Compara esta solución con la obtenida en el ejercicio 3.14.

select codpie
from pieza
where peso >= all(select peso from pieza);

EJERCICIO 3.24. Encontrar los códigos de las piezas suministradas a todos los proyectos
localizados en Londres.

PRIMERA FORMA

(select codpie
from ventas)
MINUS
select codpie
from (select v.codpie, p.codpj 
      from (select distinct codpie from ventas) v, 
      (select codpj from proyecto where ciudad='Londres') p
      MINUS
      select codpie, codpj from ventas NATURAL JOIN (select codpj from proyecto where ciudad = 'Londres'));

SEGUNDA FORMA

select codpie
from pieza
where not exists(
    select *
    from proyecto where (ciudad='Londres'
    and not exists(select *
                     from ventas
                     where (ventas.codpj = proyecto.codpj
                     and ventas.codpie = pieza.codpie))));

TERCERA FORMA

select codpie
from pieza
where not exists(select codpj from proyecto where ciudad='Londres'
                 MINUS
                 select codpj from ventas where ventas.codpie=pieza.codpie);


EJERCICIO 3.25. Encontrar aquellos proveedores que envían piezas procedentes de todas las
ciudades donde hay un proyecto.

PRIMERA FORMA

select codpro
from ventas 
MINUS
select codpro
from ((select a.codpro, b.ciudad
      from (select distinct codpro from ventas) a,
           (select distinct ciudad from proyecto) b)
      MINUS
      (select codpro, ciudad from ventas NATURAL JOIN pieza));

SEGUNDA FORMA

select codpro
from proveedor
where not exists(select ciudad 
                 from proyecto
                 where not exists(select * 
                                  from ventas NATURAL JOIN pieza
                                  where ventas.codpro=proveedor.codpro
                                  and pieza.ciudad=proyecto.ciudad));

TERCERA FORMA

select codpro
from proveedor
where not exists(
                 (select distinct ciudad from proyecto)
                 MINUS
                 (select distinct ciudad 
                 from ventas NATURAL JOIN pieza
                 where ventas.codpro=proveedor.codpro));

EJERCICIO 3.26. Encontrar el número de envíos con más de 1000 unidades.

select count(cantidad)
from ventas
where cantidad > 1000;

EJERCICIO 3.27. Mostrar el máximo peso.

select max(peso)
from pieza;

EJERCICIO 3.28. Mostrar el código de la pieza de máximo peso. Compara esta solución
con las correspondientes de los ejercicios 3.14 y 3.23.

select codpie
from pieza
where peso = (select max(peso) from pieza);

EJERCICIO 3.29. Comprueba si la siguiente sentencia resuelve el ejercicio anterior.

SQL> SELECT codpie, MAX(peso)
     FROM pieza;

No la resuelve, ya que máximo podría devolver el máximo peso que se corresponde
con más de una pieza y no se sabría qué codpie dar.

EJERCICIO 3.30. Muestra los códigos de proveedores que han hecho más de 3 envíos diferentes.

select distinct codpro
from proveedor
where (select count(codpro) from ventas where ventas.codpro = proveedor.codpro) > 3;

EJERCICIO 3.31. Mostrar la media de las cantidades vendidas por cada código de pieza junto
con su nombre.

select codpie, nompie, avg(cantidad)
from ventas NATURAL JOIN pieza
group by codpie, nompie;

EJERCICIO 3.32. Encontrar la cantidad media de ventas de la pieza 'P1' realizadas
por cada proveedor.

select codpro, avg(cantidad)
from ventas
where codpie='P1 '
group by codpro;

EJERCICIO 3.33. Encontrar la cantidad total de cada pieza enviada a cada proyecto.

select codpie, codpj, sum(cantidad)
from ventas
group by codpie, codpj;

EJERCICIO 3.34. Comprueba si es correcta la solución anterior.

select v.codpro, v.codpj, j.nompj, avg(v.cantidad)
from ventas v, proyecto j
where v.codpj=j.codpj
group by v.codpj, j.nompj, v.codpro
order by j.nompj;

Sí que resuelve la consulta, aunque he ordenado los resultados
por nombre de proyecto para poder ver primero la media de piezas
que recibe un proyecto concreto de cada proveedor, luego el
siguiente proyecto, y así sucesivamente.

EJERCICIO 3.35. Mostrar los nombres de proveedores tales que el total de sus ventas
superen la cantidad de 1000 unidades.

select v.codpro, p.nompro
from ventas v, proveedor p
where v.codpro=p.codpro
group by v.codpro, p.nompro
having sum(cantidad) > 1000;

EJERCICIO 3.36. Mostrar la pieza que más se ha vendido en total.

select codpie
from ventas
group by codpie
having sum(cantidad) = (select max(sum(v.cantidad))
                        from ventas v
                        group by v.codpie);

OTRO FORMA

select codpie
from ventas
group by codpie
having sum(cantidad) >= all(select sum(cantidad) from ventas group by codpie);


EJERCICIO 3.37. Comprueba que no funciona correctamente si las comparaciones
de fechas se hacen con cadenas.

select * from ventas
where fecha between '01/01/2002' and '31/12/2004';

¿Funciona igual? DUDA

EJERCICIO 3.38. Encontrar la cantidad media de piezas suministradas cada mes.

select to_char(fecha,'MM'), avg(cantidad)
from ventas
group by to_char(fecha,'MM');

EJERCICIO 3.39. ¿Cuál es el nombre de la vista que tienes que consultar y qué
campos te pueden interesar?

EJERCICIO 3.40. Muestra las tablas ventas a las que tienes acceso de consulta
junto con el nombre del propietario y su número de identificación en el sistema.

EJERCICIO 3.41. Muestra todos tus objetos creados en el sistema. ¿Hay algo más
que tablas?

EJERCICIO 3.42. Mostrar los códigos de aquellos proveedores que hayan superado
las ventas totales realizadas por el proveedor 'S1'.

select codpro
from ventas
group by codpro
having sum(cantidad) > (select sum(cantidad)
                        from ventas
                        where codpro='S1 ');

EJERCICIO 3.43. Mostrar los mejores proveedores, entendiéndose como los que
tienen mayores cantidades totales.

select codpro
from ventas
group by codpro
having sum(cantidad) = (select max(sum(cantidad))
                        from ventas
                        group by codpro);

OTRA FORMA

select codpro
from ventas
group by codpro
having sum(cantidad) >= all(select sum(cantidad) from ventas group by codpro);

EJERCICIO 3.44. Mostrar los proveedores que venden piezas a todas las
ciudades de los proyectos a los que suministra 'S3', sin incluirlo.

PRIMERA FORMA

select codpro
from proveedor
where codpro!='S3 '
MINUS
select codpro
from          ((select v.codpro, p.ciudad
              from ventas v, proyecto p
              where v.codpro!='S3 ' and p.ciudad in (select ciudad
                                                     from ventas NATURAL JOIN proyecto
                                                     where codpro='S3 '))
              MINUS
              (select codpro, ciudad
               from ventas NATURAL JOIN proyecto
               where codpro!='S3 ' and ciudad in (select ciudad
                                                     from ventas NATURAL JOIN proyecto
                                                     where codpro='S3 ')));

SEGUNDA FORMA

select codpro
from proveedor
where codpro!='S3 ' and not exists(select ciudad
                                   from (select * from ventas NATURAL JOIN proyecto) a
                                   where a.codpro='S3 '
                                   and not exists(select *
                                                  from (select * from ventas NATURAL JOIN proyecto) b
                                                  where b.codpro=proveedor.codpro
                                                  and b.ciudad=a.ciudad));

TERCERA FORMA

select codpro
from proveedor
where codpro!= 'S3 ' and not exists(select distinct ciudad
                                     from ventas NATURAL JOIN proyecto
                                     where codpro='S3 '
                                     MINUS
                                     select distinct ciudad
                                     from ventas NATURAL JOIN proyecto
                                     where codpro=proveedor.codpro);


EJERCICIO 3.45. Encontrar aquellos proveedores que hayan hecho al menos diez pedidos.

select codpro
from ventas
group by codpro
having count(*) >= 10;

OTRA FORMA

select codpro
from proveedor
where (select count(*) from ventas where proveedor.codpro=ventas.codpro) >= 10;

EJERCICIO 3.46. Encontrar aquellos proveedores que venden todas las piezas suministradas
por S1.

PRIMERA FORMA

select codpro
from ventas
where codpro!='S1 '
MINUS
select codpro
from(select v1.codpro, v2.codpie
     from ventas v1, ventas v2
     where v1.codpro!='S1 ' and v2.codpro='S1 '
     MINUS
     select codpro,codpie
     from ventas NATURAL JOIN (select codpie from ventas where codpro='S1 ')
     where codpro!='S1 ');

SEGUNDA FORMA

select codpro
from proveedor
where codpro!='S1 ' and not exists(select codpie
                                   from ventas v
                                   where v.codpro='S1 '
                                   and not exists(select codpie
                                                  from ventas
                                                  where codpro=proveedor.codpro
                                                  and codpie=v.codpie));

TERCERA FORMA

select codpro
from proveedor
where codpro!='S1 ' and not exists(select codpie
                                   from ventas
                                   where codpro='S1 '
                                   MINUS
                                   select codpie
                                   from ventas
                                   where codpro=proveedor.codpro);


EJERCICIO 3.47. Encontrar la cantidad total de piezas que ha vendido cada proveedor que
cumple la condición de vender todas las piezas suministradas por S1.

select codpro, sum(cantidad)
from ventas
where codpro in (select codpro
                 from proveedor
                 where codpro!='S1 ' and not exists(select codpie
                                                    from ventas
                                                    where codpro='S1 '
                                                    MINUS
                                                    select codpie
                                                    from ventas
                                                    where codpro=proveedor.codpro))
group by codpro;

EJERCICIO 3.48. Encontrar qué proyectos están suministrados por todos lo proveedores que
suministran la pieza P3.

PRIMERA FORMA

select codpj
from ventas
MINUS
select codpj
from (select v1.codpj, v2.codpro
      from ventas v1, ventas v2
      where v2.codpro in (select codpro from ventas where codpie='P3 ')
      MINUS
      select codpj, codpro
      from ventas NATURAL JOIN (select codpro from ventas where codpie='P3 '));

SEGUNDA FORMA

select codpj
from proyecto
where not exists(select v1.codpro
                 from ventas v1
                 where v1.codpie='P3 ' 
                 and not exists(select *
                                from ventas
                                where codpro=v1.codpro
                                and codpj=proyecto.codpj));

TERCERA FORMA

select codpj
from proyecto
where not exists(select codpro
                 from ventas
                 where codpie='P3 '
                 MINUS
                 select codpro
                 from ventas
                 where codpj=proyecto.codpj);

EJERCICIO 3.49. Encontrar la cantidad media de piezas suministrada a aquellos proveedores
que venden la pieza P3.

select codpro, avg(cantidad)
from ventas
where codpro in (select codpro from ventas where codpie='P3 ')
group by codpro;

EJERCICIO 3.52.  Mostrar para cada proveedor la media de productos suministrados cada año.

select codpro, to_char(fecha,'YYYY'), avg(cantidad) 
from ventas
group by codpro, to_char(fecha,'YYYY')
order by codpro;

EJERCICIO 3.53. Encontrar todos los proveedores que venden una pieza roja.

select codpro
from (ventas NATURAL JOIN (select codpie from pieza where color='Rojo'));

EJERCICIO 3.54. Encontrar todos los proveedores que venden todas las piezas rojas.

PRIMERA FORMA

select codpro
from ventas
MINUS
select codpro
from(select v1.codpro,v2.codpie
     from ventas v1, ventas v2
     where v2.codpie in (select codpie from pieza where color='Rojo')
     MINUS
     select codpro,codpie
     from ventas NATURAL JOIN (select codpie from pieza where color='Rojo'));

o bien

select codpro
from ventas
MINUS
select codpro
from (select p.codpro, s.codpie
      from proveedor p, (select codpie from pieza where color='Rojo') s
      MINUS
      select codpro, codpie
      from ventas
      where codpie IN (select codpie from pieza where color='Rojo'));

SEGUNDA FORMA

select codpro
from proveedor
where not exists(select codpie
                 from pieza
                 where color='Rojo'
                 and not exists(select *
                                from ventas
                                where codpro=proveedor.codpro
                                and codpie=pieza.codpie));

TERCERA FORMA

select codpro
from proveedor
where not exists(select codpie
                 from pieza
                 where color='Rojo'
                 MINUS
                 select codpie
                 from ventas
                 where codpro=proveedor.codpro);

EJERCICIO 3.55. Encontrar todos los proveedores tales que todas las piezas que
venden son rojas.

select codpro
from ventas
MINUS
select codpro
from ventas NATURAL JOIN (select codpie from pieza where color!='Rojo');

EJERCICIO 3.56. Encontrar el nombre de aquellos proveedores que venden más de 
una pieza roja.

select codpro
from ventas
where codpie in (select codpie from pieza where color='Rojo')
group by codpro
having count(*) > 1;

Si lo que queremos es ver qué proveedores venden más de una pieza roja DISTINTA,
la solución sería esta:

select codpro
from
(select distinct codpro,codpie
from ventas
where codpie in (select codpie from pieza where color='Rojo'))
group by codpro
having count(*) > 1;

EJERCICIO 3.57. Encontrar todos los proveedores que vendiendo todas las piezas rojas
cumplen la condición de que todas sus ventas son de más de 10 unidades.

select codpro
from proveedor
where not exists(select codpie
                 from pieza
                 where color='Rojo'
                 MINUS
                 select codpie
                 from ventas
                 where codpro=proveedor.codpro)
and not exists(select *
               from ventas
               where codpro=proveedor.codpro and cantidad <= 10);

Otra forma de hacerlo es:

select codpro
from proveedor
where not exists(select codpie
                 from pieza
                 where color='Rojo'
                 MINUS
                 select codpie
                 from ventas
                 where codpro=proveedor.codpro)
INTERSECT
select codpro
from proveedor
where not exists(select *
                 from ventas
                 where codpro=proveedor.codpro and cantidad <= 10);


EJERCICIO 3.58. Coloca el status igual a 1 a aquellos proveedores que solo
suministran la pieza P1.

UPDATE proveedor
SET status=1
where codpro in(select codpro
                from ventas
                MINUS
                select codpro
                from ventas
                where codpie!='P1 ');

EJERCICIO 3.59. Encuentra, de entre las piezas que no se han vendido en septiembre de
2009, las ciudades de aquéllas que se han vendido en mayor cantidad durante Agosto de
ese mismo año. (DUDA, NO FUNCIONA)

select codpie, ciudad, sum(cantidad) 
from ventas natural join ((select codpie from pieza) 
       minus 
      (select codpie from ventas 
       where to_char(fecha,'MM/YYYY')='09/2009')) 
       natural join pieza 
where to_char(fecha,'MM/YYYY')='08/2009' 
group by codpie, ciudad 
having sum(cantidad) = (select max(sum(cantidad)) 
                        from ventas natural join  
                            ((select codpie from pieza) 
                               minus 
                              (select codpie from ventas 
                               where to_char(fecha,'MM/YYYY')='09/2009'))
                               natural join pieza
                        where to_char(fecha,'MM/YYYY')='08/2009' 
                        group by codpie, ciudad);

EJERCICIO 3.60. Muestra la información disponible acerca de los encuentros
de liga.

select * from encuentro;

EJERCICIO 3.61. Muestra los nombres de los equipos y de los jugadores
ordenados alfabéticamente.

select *
from equipo
order by nombree;

select *
from jugador
order by nombrej;

EJERCICIO 3.62. Muestra los jugadores que no tienen ninguna falta.

select codJ
from jugador
MINUS
select codJ
from faltas;

EJERCICIO 3.63. Muestra los compañeros de equipo del jugador que tiene
por código x (codJ='x') y donde x es uno elegido por ti.

select codJ
from jugador
where codE = (select codE from jugador where codJ='x') and codJ!='x';

EJERCICIO 3.64. Muestra los jugadores y la localidad donde juegan (la de
sus equipos).

select codJ, localidad
from jugador NATURAL JOIN equipo;

EJERCICIO 3.65. Muestra todos los encuentros posibles de la liga.

select a.codE, b.codE
from equipo a, equipo b
where a.codE!=b.codE;

EJERCICIO 3.66. Muestra los equipos que han ganado algún encuentro jugando
como local.

select distinct elocal
from encuentro
where plocal > pvisitante;

EJERCICIO 3.67. Muestra los equipos que han ganado algún encuentro.

select distinct elocal
from encuentro
where plocal > pvisitante
UNION
select distinct evisitante
from encuentro
where pvisitante > plocal;

EJERCICIO 3.68. Muestra los equipos que todos los encuentros que han
ganado lo han hecho como equipo local.

select elocal
from encuentro
where plocal > pvisitante
MINUS
select evisitante
from encuentro
where pvisitante > plocal;

EJERCICIO 3.69. Muestra los equipos que han ganado todos los encuentros
jugando como equipo local.

select code
from equipo 
where not exists(select * 
                 from encuentro
                 where elocal=equipo.code and plocal <= pvisitante)
and code in (select elocal from encuentro);

EJERCICIO 3.70. Muestra los encuentros que faltan para terminar la liga.
Suponiendo que en la tabla Encuentros solo se almacenan los encuentros
celebrados hasta la fecha.

select e1.code, e2.code
from equipo e1, equipo e2
where e1.code!=e2.code
MINUS
select elocal, evisitante
from encuentro;

EJERCICIO 3.71. Muestra los encuentros que tienen lugar en la misma
localidad.

select *
from encuentro
where ((select localidad from equipo where code=elocal)
        = (select localidad from equipo where code=evisitante));

OTRA FORMA

select elocal, evisitante
from encuentro
INTERSECT
select a.code, b.code
from equipo a, equipo b
where a.code!=b.code and a.localidad=b.localidad;

EJERCICIO 3.72. Para cada equipo muestra la cantidad de encuentros
que ha disputado como local.

select elocal, count(*)
from encuentro
group by elocal;

EJERCICIO 3.73. Muestra los encuentros en los que se alcanzó la
mayor diferencia.

select *
from encuentro
where abs(plocal-pvisitante) = (select max(abs(plocal-pvisitante))
                                    from encuentro);

EJERCICIO 3.74. Muestra los jugadores que no han superado 3 faltas
acumuladas.

select codj, count(*)
from faltas
group by codj
having count(*) < 4;

EJERCICIO 3.75. Muestra los equipos con mayores puntuaciones en los
partidos jugados fuera de casa.

select evisitante, pvisitante
from encuentro NATURAL JOIN (select elocal, evisitante
                             from encuentro
                             INTERSECT
                             select a.code, b.code
                             from equipo a, equipo b
                             where a.code!=b.code
                             and a.localidad=b.localidad)
where pvisitante = (select max(pvisitante)
                     from encuentro NATURAL JOIN (select elocal, evisitante
                                                  from encuentro
                                                  INTERSECT
                                                  select a.code, b.code
                                                  from equipo a, equipo b
                                                  where a.code!=b.code
                                                  and a.localidad=b.localidad));

EJERCICIO 3.76. Muestra la cantidad de victorias de cada equipo, jugando
como local o como visitante.

select p.code, count(*)
from encuentro e, equipo p
where (e.elocal=p.code and e.plocal > e.pvisitante)
or (e.evisitante=p.code and e.pvisitante > e.plocal)
group by p.code;

EJERCICIO 3.77. Muestra el equipo con mayor número de victorias.

select p2.code
from equipo p2
where
(select count(*)
from encuentro e
where (e.elocal=p2.code and e.plocal > e.pvisitante)
or (e.evisitante=p2.code and e.pvisitante > e.plocal)
group by p2.code)
>=
all (select count(*)
from encuentro e, equipo p
where (e.elocal=p.code and e.plocal > e.pvisitante)
or (e.evisitante=p.code and e.pvisitante > e.plocal)
group by p.code);

EJERCICIO 3.78. Muestra el promedio de puntos por equipo en los
encuentros de ida.

select evisitante, avg(pvisitante)
from encuentro
group by evisitante;

EJERCICIO 3.79. Muestra el equipo con mayor número de puntos en
total de los encuentros jugados.

select code, sum(p1)
from
(select code, sum(plocal) p1
from encuentro, equipo
where (elocal=code)
group by code
UNION
select code, sum(pvisitante)
from encuentro, equipo 
where (evisitante=code)
group by code)
group by code
having sum(p1) = (select max(sum(p2))
                  from
                (select code, sum(plocal) p2
                from encuentro, equipo
                where (elocal=code)
                group by code
                UNION
                select code, sum(pvisitante)
                from encuentro, equipo 
                where (evisitante=code)
                group by code)
                group by code);

EJERCICIO 4.1.

