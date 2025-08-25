CREATE DATABASE IF NOT EXISTS centro_salud;

USE centro_salud;

CREATE TABLE medicos(
	id INT PRIMARY KEY AUTO_INCREMENT,
	nombre VARCHAR(50) NOT NULL,
	tipo ENUM ('titular', 'interino', 'sustituto') NOT NULL,
	horario_consulta TIME NOT NULL,
	periodo_sustitucion TIME NOT NULL
);

CREATE TABLE empleados(
	id INT PRIMARY KEY AUTO_INCREMENT,
	nombre VARCHAR(50) NOT NULL,
	tipo ENUM ('ATS', 'auxiliares de enfermeria', 'celadores', 'administrativos') NOT NULL
);

CREATE TABLE pacientes(
	id INT PRIMARY KEY AUTO_INCREMENT,
	nombre VARCHAR(50) NOT NULL,
	telefono VARCHAR(14),
	id_medico_asignado INT,
	FOREIGN KEY(id_medico_asignado) REFERENCES medicos(id)
);

CREATE TABLE vacaciones_medicos(
	id_medico INT,
	fecha_inicio DATE NOT NULL,
	fecha_fin DATE NOT NULL,
	FOREIGN KEY(id_medico) REFERENCES medicos(id)
);

CREATE TABLE vacaciones_empleados(
	id_empleados INT,
	fecha_inicio DATE NOT NULL,
	fecha_fin DATE NOT NULL,
	FOREIGN KEY(id_empleados) REFERENCES empleados(id)
);


INSERT INTO medicos(nombre, tipo, horario_consulta, periodo_sustitucion)
VALUES ('kevin', 'titular', '10:30', '18:30')

INSERT INTO empleados(nombre, tipo)
VALUES ('cristian', 'ATS')

INSERT INTO pacientes(nombre, telefono, id_medico_asignado)
VALUES ('arley', '3105688948', '1')

INSERT INTO vacaciones_medicos(id_medico, fecha_inicio, fecha_fin)
VALUES ('1', '2025-01-05', '2025-02-07')

INSERT INTO vacaciones_empleados(id_empleados, fecha_inicio, fecha_fin)
VALUES ('1', '2025-01-01', '2025-01-15')

-- Consulta number one 

select m.nombre as medico,
m.tipo as tipo_medico,
COUNT(p.id_medico_asignado=m.id) as numero
from medicos m 
join pacientes p
group by m.id

-- Consulta number two

select m.nombre as medico,
m.horario_consulta as inicio_horario,
m.periodo_sustitucion as fin_horario,
time(m.periodo_sustitucion-m.horario_consulta) as horas_trabajadas
from medicos m 
group by m.id

-- Consulta number three

select nombre as medico,
tipo as tipo
from medicos m 
where tipo='sustituto';

-- Consulta number four 

select 
m.id as id_medico,
m.nombre as medico, 
m.tipo as tipo_medico,
COUNT(p.id_medico_asignado=m.id) as cantidad 
from medicos m 
join pacientes p 
group by m.id 
limit 2
	
