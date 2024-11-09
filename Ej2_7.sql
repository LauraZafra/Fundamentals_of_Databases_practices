delete from equipos;

insert into equipos values (1, 'Barça', 'Barcelona', 'Roger Grimau', to_date('18/09/1997','dd/mm/yyyy'));
insert into equipos values (2, 'Baskonia', 'Vitoria', 'Dusko Ivanovic', to_date('20/01/1987','dd/mm/yyyy'));
insert into equipos values (3, 'Girona', 'Girona', 'Fotis Katsikaris', to_date('08/06/1982','dd/mm/yyyy'));
insert into equipos values (4, 'Manresa', 'Manresa', 'Pedro Martínez', to_date('29/03/2000','dd/mm/yyyy'));

select * from equipos;


delete from jugadores;

insert into jugadores values (1, 1, 'John');
insert into jugadores values (2, 1, 'Mike');
insert into jugadores values (3, 1, 'David');
insert into jugadores values (4, 1, 'Chris');
insert into jugadores values (5, 1, 'Matt');

insert into jugadores values (6, 2, 'Alex');
insert into jugadores values (7, 2, 'Ryan');
insert into jugadores values (8, 2, 'Eric');
insert into jugadores values (9, 2, 'Steve');
insert into jugadores values (10, 2, 'Paul');

insert into jugadores values (11, 3, 'Jason');
insert into jugadores values (12, 3, 'Kevin');
insert into jugadores values (13, 3, 'Brian');
insert into jugadores values (14, 3, 'Daniel');
insert into jugadores values (15, 3, 'Justin');

insert into jugadores values (16, 4, 'Aaron');
insert into jugadores values (17, 4, 'Tyler');
insert into jugadores values (18, 4, 'Ethan');
insert into jugadores values (19, 4, 'Nathan');
insert into jugadores values (20, 4, 'Jacob');

select * from jugadores;


delete from encuentros;

insert into encuentros values (1, 2, to_date('18/09/2024','dd/mm/yyyy'), 108, 106);
insert into encuentros values (1, 3, to_date('19/10/2024','dd/mm/yyyy'), 98, 102);
insert into encuentros values (1, 4, to_date('20/11/2024','dd/mm/yyyy'), 105, 99);
insert into encuentros values (2, 1, to_date('21/09/2024','dd/mm/yyyy'), 90, 96);
insert into encuentros values (2, 3, to_date('5/10/2024','dd/mm/yyyy'), 95, 96);
insert into encuentros values (2, 4, to_date('22/09/2024','dd/mm/yyyy'), 110, 103);
insert into encuentros values (3, 1, to_date('13/09/2024','dd/mm/yyyy'), 100, 104);
insert into encuentros values (3, 2, to_date('24/10/2024','dd/mm/yyyy'), 80, 49);
insert into encuentros values (3, 4, to_date('23/11/2024','dd/mm/yyyy'), 100, 98);
insert into encuentros values (4, 1, to_date('3/12/2024','dd/mm/yyyy'), 100, 104);

select * from encuentros;


