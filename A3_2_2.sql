-- Muestra las piezas de Madrid que son grises o rojas
select * from pieza where ciudad = 'Madrid' and (color = 'Gris' or color = 'Rojo');

-- Encontrar todos los suministros cuya cantidad está entre 200 y 300, ambos inclusive
select * from ventas where cantidad >= 200 and cantidad <= 300;

-- Mostrar las piezas que contengan la palabra tornillo con la t en mayúscula o en minúscula.
select * from pieza where nompie like '_ornillo';
-- El operador like se emplea para comparar cadenas de caracteres mediante el uso de patrones
-- El carácter comodín _ sustituye un sólo carácter

