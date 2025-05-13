CREATE DATABASE IF NOT EXISTS TorneoDebate;
use TorneoDebate;
 create table Fase(
 idFase int auto_increment primary key, 
nombreFase varchar (20) not null 
);

create table prueba (
 idPrueba int auto_increment primary key, 
nombrePrueba VARCHAR(30) NOT NULL, 
numEquipos int not null check (numEquipos %2 = 0),
 numJueces int not null,
 mejorOrador boolean not null,
 idFase int not null,
 foreign key (idFase) references Fase (idFase), 
UNIQUE (idFase,nombrePrueba) 
);

create table Sala(
 idSala int auto_increment primary Key,
 nombreSala varchar (30) not null
 );

create table PruebaSala (
 idPrueba int, idSala int,
 primary key (idPrueba, idSala), 
foreign key (idPrueba) references prueba(idPrueba),
 foreign key (idSala) references Sala(idSala)
 );

create table Cruce (
 idCruce int auto_increment primary key, 
idFase int not null, idSala int not null,
 foreign key (idFase) references Fase(idFase),
 foreign key (idSala) references Sala(idSala)
 );

create table Equipo( 
idEquipo int auto_increment primary key, 
nombreEquipo varchar (20),
 anioCreacion int
 );

create table CruceEquipo( 
idCruce int,
 idEquipo int,
 primary key (idCruce,idEquipo),
 foreign key (idCruce) references Cruce(idCruce),
 foreign key (idEquipo) references Equipo(idEquipo) 
);

INSERT INTO Sala (nombreSala) VALUES ('Biblioteca'); 
INSERT INTO Sala (nombreSala) VALUES ('Salon de actos');
 INSERT INTO Sala (nombreSala) VALUES ('Salon de idiomas');

INSERT INTO Equipo (nombreEquipo, anioCreacion) VALUES ('Equipo 1', 2025);
 INSERT INTO Equipo (nombreEquipo, anioCreacion) VALUES ('Equipo 2', 2025);
 INSERT INTO Equipo (nombreEquipo, anioCreacion) VALUES ('Equipo 3', 2025); 
INSERT INTO Equipo (nombreEquipo, anioCreacion) VALUES ('Equipo 4', 2025);
 INSERT INTO Equipo (nombreEquipo, anioCreacion) VALUES ('Equipo 5', 2025);
 INSERT INTO Equipo (nombreEquipo, anioCreacion) VALUES ('Equipo 6', 2025);
 INSERT INTO Equipo (nombreEquipo, anioCreacion) VALUES ('Equipo 7', 2025); 
INSERT INTO Equipo (nombreEquipo, anioCreacion) VALUES ('Equipo 8', 2025);
 INSERT INTO Equipo (nombreEquipo, anioCreacion) VALUES ('Equipo 9', 2025); 
INSERT INTO Equipo (nombreEquipo, anioCreacion) VALUES ('Equipo 10', 2025);
 INSERT INTO Equipo (nombreEquipo, anioCreacion) VALUES ('Equipo 11', 2025);
 INSERT INTO Equipo (nombreEquipo, anioCreacion) VALUES ('Equipo 12', 2025);
 INSERT INTO Equipo (nombreEquipo, anioCreacion) VALUES ('Equipo 13', 2025);
 INSERT INTO Equipo (nombreEquipo, anioCreacion) VALUES ('Equipo 14', 2025);
 INSERT INTO Equipo (nombreEquipo, anioCreacion) VALUES ('Equipo 15', 2025); 
INSERT INTO Equipo (nombreEquipo, anioCreacion) VALUES ('Equipo 16', 2025);

INSERT INTO Fase (nombreFase) VALUES ('Primera Fase');
 INSERT INTO Fase (nombreFase) VALUES ('Segunda Fase');
 INSERT INTO Fase (nombreFase) VALUES ('Semifinal'); 
INSERT INTO Fase (nombreFase) VALUES ('Final');

INSERT INTO Cruce (idFase, idSala) VALUES (1, 1); 
INSERT INTO Cruce (idFase, idSala) VALUES (2, 2); 
INSERT INTO Cruce (idFase, idSala) VALUES (3, 3); 
INSERT INTO Cruce (idFase, idSala) VALUES (4, 2);

INSERT INTO prueba (nombrePrueba, numEquipos, numJueces, mejorOrador, idFase) VALUES ('Mejor Introduccion', 16, 6, TRUE, 1); 
INSERT INTO prueba (nombrePrueba, numEquipos, numJueces, mejorOrador, idFase) VALUES ('Debate inicial', 16, 5, TRUE, 1); 
INSERT INTO prueba (nombrePrueba, numEquipos, numJueces, mejorOrador, idFase) VALUES ('Mejor Refutación', 16, 4, FALSE, 1); 
INSERT INTO prueba (nombrePrueba, numEquipos, numJueces, mejorOrador, idFase) VALUES('Mejor Argumentación', 8, 4, TRUE, 2); 
INSERT INTO prueba (nombrePrueba, numEquipos, numJueces, mejorOrador, idFase) VALUES('Contra-Argumentación', 8, 3, TRUE, 2);
 INSERT INTO prueba (nombrePrueba, numEquipos, numJueces, mejorOrador, idFase) VALUES('Mejor Estrategia', 4, 2, FALSE, 3); 
INSERT INTO prueba (nombrePrueba, numEquipos, numJueces, mejorOrador, idFase) VALUES('Defensa Final', 2, 2, TRUE, 4);

INSERT INTO PruebaSala (idPrueba, idSala) VALUES (1, 1);
 INSERT INTO PruebaSala (idPrueba, idSala) VALUES (2, 2); 
INSERT INTO PruebaSala (idPrueba, idSala) VALUES (3, 3); 
INSERT INTO PruebaSala (idPrueba, idSala) VALUES (4, 1); 
INSERT INTO PruebaSala (idPrueba, idSala) VALUES (5, 2);
 INSERT INTO PruebaSala (idPrueba, idSala) VALUES (6, 3); 
INSERT INTO PruebaSala (idPrueba, idSala) VALUES (7, 1);

SELECT * FROM Equipo; 
SELECT * FROM PruebaSala; 
SELECT * FROM CruceEquipo;

INSERT INTO CruceEquipo
 (idEquipo, idCruce) 
SELECT e.idEquipo, c.idCruce 
FROM Equipo e, Cruce c 
WHERE c.idFase = 1;

UPDATE Cruce c
 JOIN CruceEquipo ce ON
 c.idCruce = ce.idCruce 
SET c.idFase = 1 
WHERE ce.idEquipo IN (SELECT 
idEquipo FROM Equipo);

SELECT e.idEquipo,
 e.nombreEquipo, c.idFase 
FROM Equipo e 
JOIN CruceEquipo ce ON
 e.idEquipo = ce.idEquipo
 JOIN Cruce c 
ON ce.idCruce = c.idCruce;

INSERT INTO CruceEquipo
 (idEquipo, idCruce)
 SELECT e.idEquipo, c.idCruce 
FROM ( 
SELECT idEquipo FROM Equipo 
ORDER BY idEquipo LIMIT 8
 ) AS e JOIN Cruce c ON c.idFase = 2;

INSERT INTO CruceEquipo 
(idEquipo, idCruce)
 SELECT e.idEquipo, c.idCruce
 FROM ( 
SELECT idEquipo FROM Equipo
 ORDER BY idEquipo LIMIT 4
 ) AS e 
JOIN Cruce c ON c.idFase = 3;

INSERT INTO CruceEquipo
 (idEquipo, idCruce)
 SELECT e.idEquipo, c.idCruce
 FROM ( 
SELECT idEquipo FROM Equipo 
ORDER BY idEquipo LIMIT 2 
) AS e 
JOIN Cruce c ON c.idFase = 4;

SELECT * FROM torneodebate.cruceequipo;

SELECT c.idFase, 
COUNT(ce.idEquipo) AS total_equipos 
FROM Cruce c 
JOIN CruceEquipo ce ON c.idCruce = ce.idCruce 
GROUP BY c.idFase;
