CREATE DATABASE UNIFRANZITOS;

USE UNIFRANZITOS;

CREATE TABLE campeonato 
(
    id_campeonato VARCHAR(12) PRIMARY KEY,
    nombre_campeonato VARCHAR(30) NOT NULL,
    sede VARCHAR(20) NOT NULL
);

DROP TABLE campeonato;

ALTER TABLE equipo
ADD direccion VARCHAR(50);

INSERT INTO campeonato (id_campeonato, nombre_campeonato, sede)
			VALUES ('camp-111', 'Campeonato Unifranz', 'El Alto');
INSERT INTO campeonato (id_campeonato, nombre_campeonato, sede)
			VALUES ('camp-222', 'Campeonato Unifranz', 'Cochabamba');

SELECT * FROM campeonato;

CREATE TABLE equipo
(
    id_equipo VARCHAR(12) PRIMARY KEY,
    nombre_equipo VARCHAR(30) NOT NULL,
    categoria VARCHAR(8) NOT NULL ,
    id_campeonato VARCHAR(12),
    FOREIGN KEY (id_campeonato) REFERENCES campeonato (id_campeonato)
);

INSERT INTO equipo (id_equipo, nombre_equipo, categoria, id_campeonato)
			VALUES ('equ-111', 'Google', 'VARONES', 'camp-111'),
				   ('equ-222', '404 Not found', 'VARONES', 'camp-111'),
				   ('equ-333', 'girls unifranz', 'MUJERES', 'camp-111');

SELECT*FROM equipo

CREATE TABLE jugador
(
    id_jugador VARCHAR(12) PRIMARY KEY,
    nombres VARCHAR(30) NOT NULL,
    apellidos VARCHAR(50) NOT NULL,
    ci VARCHAR(15) NOT NULL,
    edad INT NOT NULL,
    id_equipo VARCHAR(12),
    FOREIGN KEY (id_equipo) REFERENCES equipo (id_equipo)
);

INSERT INTO jugador (id_jugador, nombres, apellidos, ci, edad, id_equipo )
			VALUES ('jug-111', 'Carlos', 'Villa', '8997811LP', 19, 'equ-222'),
				   ('jug-222', 'Pedro', 'Salas', '8997822LP', 20, 'equ-222'),
				   ('jug-333', 'Saul', 'Araj', '8997833LP', 21, 'equ-222'),
				   ('jug-444', 'Sandra', 'Solis', '8997844LP', 20, 'equ-333'),
				   ('jug-555', 'Ana', 'Mica', '8997855LP', 23, 'equ-333');

SELECT*FROM jugador




SELECT nombres, edad FROM jugador;



UPDATE jugador
SET edad = 17
WHERE id_jugador = 'jug-111';

SELECT* FROM jugador



DELETE FROM jugador
WHERE id_jugador = 'jug-555';

SELECT* FROM jugador


SELECT nombres, apellidos, edad
FROM jugador
WHERE edad > 20;



SELECT nombres, apellidos, edad
FROM jugador
WHERE id_equipo = 'equ-222';



SELECT j.nombres, j.apellidos, e.nombre_equipo
FROM jugador j
INNER JOIN equipo e ON j.id_equipo = e.id_equipo;



SELECT e.nombre_equipo, j.nombres, j.apellidos
FROM equipo e
LEFT JOIN jugador j ON e.id_equipo = j.id_equipo;


SELECT j.nombres, j.apellidos, e.nombre_equipo
FROM jugador j
RIGHT JOIN equipo e ON j.id_equipo = e.id_equipo;



SELECT j.nombres, j.apellidos
FROM jugador j
INNER JOIN equipo e ON j.id_equipo = e.id_equipo
WHERE e.id_equipo = 'equ-222';



SELECT j.nombres, j.apellidos
FROM jugador j
INNER JOIN equipo e ON j.id_equipo = e.id_equipo
INNER JOIN campeonato c ON e.id_campeonato = c.id_campeonato
WHERE c.sede = 'El Alto';



SELECT nombres, apellidos, edad
FROM jugador
INNER JOIN equipo ON jugador.id_equipo = equipo.id_equipo
WHERE edad >= 21 AND equipo.categoria = 'VARONES';



SELECT *
FROM jugador
WHERE apellidos LIKE 'S%';



SELECT e.nombre_equipo, e.categoria
FROM equipo e
INNER JOIN campeonato c ON e.id_campeonato = c.id_campeonato
WHERE c.id_campeonato = 'camp-111' AND e.categoria = 'MUJERES';

-- Mostrar el nombre del equipo del jugador con id_jugador igual a 'jug-333'

SELECT e.nombre_equipo
FROM equipo e
INNER JOIN jugador j ON e.id_equipo = j.id_equipo
WHERE j.id_jugador = 'jug-333';

-- Mostrar el nombre del campeonato del jugador con id_jugador igual a 'jug-333'

SELECT c.nombre_campeonato
FROM campeonato c
INNER JOIN equipo e ON c.id_campeonato = e.id_campeonato
INNER JOIN jugador j ON e.id_equipo = j.id_equipo
WHERE j.id_jugador = 'jug-333';

-- Consulta que involucra las tablas de campeonato, equipo y jugador

SELECT c.id_campeonato, c.nombre_campeonato, c.sede, e.id_equipo, e.nombre_equipo, e.categoria, j.id_jugador, j.nombres, j.apellidos, j.ci, j.edad
FROM campeonato c
INNER JOIN equipo e ON c.id_campeonato = e.id_campeonato
INNER JOIN jugador j ON e.id_equipo = j.id_equipo;

-- Determinar cuántos equipos están inscritos

SELECT COUNT(*) AS total_equipos
FROM equipo;

-- Determinar cuántos jugadores pertenecen a la categoría 'VARONES' o 'MUJERES' utilizando COUNT

SELECT e.categoria, COUNT(*) AS total_jugadores
FROM jugador j
INNER JOIN equipo e ON j.id_equipo = e.id_equipo
WHERE e.categoria IN ('VARONES', 'MUJERES')
GROUP BY e.categoria;