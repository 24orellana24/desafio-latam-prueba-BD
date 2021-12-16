\! clear
\c template1
DROP DATABASE biblioteca;
CREATE DATABASE biblioteca;
\c biblioteca

\! echo ""
\! echo ""
\! echo "**********************************************************"
\! echo "DESARROLLO PARTE 2 - CREANDO EL MODELO EN LA BASE DE DATOS"
\! echo "**********************************************************"
\! echo ""
\! echo ""
\! echo "******************************************************************************************"
\! echo "R.1 y R.2 Creando modelo BD 'biblioteca', normalización de tablas e inserción de registros"
\! echo "******************************************************************************************"
\! echo ""

-- 1.1.a Normalización tabla "autores"
CREATE TABLE autores (
  codigo SERIAL,
  nombre VARCHAR(50),
  apellido VARCHAR(50),
  ano_nacimiento INT,
  ano_muerte INT,

  PRIMARY KEY (codigo)
);

-- 1.1.b Ingreso de registro a la tabla "autores" normalizada
INSERT INTO autores (nombre, apellido, ano_nacimiento, ano_muerte) VALUES ('Andrés', 'Ulloa', 1982, NULL);
INSERT INTO autores (nombre, apellido, ano_nacimiento, ano_muerte) VALUES ('Sergio', 'Mardones', 1950, 2012);
INSERT INTO autores (nombre, apellido, ano_nacimiento, ano_muerte) VALUES ('José', 'Salgado', 1968, 2020);
INSERT INTO autores (nombre, apellido, ano_nacimiento, ano_muerte) VALUES ('Ana', 'Salgado', 1972, NULL);
INSERT INTO autores (nombre, apellido, ano_nacimiento, ano_muerte) VALUES ('Martín', 'Porta', 1976, NULL);

-- 1.1.c Consulta a la tabla "autores" normalizada para mostrar sus registros
SELECT * FROM autores;

-- 1.2.a Normalización tabla "libros"
CREATE TABLE libros (
  isbn VARCHAR(15) UNIQUE,
  titulo VARCHAR(100),
  paginas INT,

  PRIMARY KEY (isbn)
);

-- 1.2.b Ingreso de registro a la tabla "libros" normalizada
INSERT INTO libros (isbn, titulo, paginas) VALUES ('111-1111111-111', 'CUENTOS DE TERROR', 344);
INSERT INTO libros (isbn, titulo, paginas) VALUES ('222-2222222-222', 'POESÍAS CONTEMPORANEAS', 167);
INSERT INTO libros (isbn, titulo, paginas) VALUES ('333-3333333-333', 'HISTORIA DE ASIA', 511);
INSERT INTO libros (isbn, titulo, paginas) VALUES ('444-4444444-444', 'MANUAL DE MECÁNICA', 298);

-- 1.2.c Consulta a la tabla "libros" normalizada para mostrar sus registros
SELECT * FROM libros;

-- 1.3.a Normalización tabla "tipo de autores"
CREATE TABLE tipo_autores (
  id SERIAL,
  tipo_autor VARCHAR(100),
  id_codigo_autor INT,
  id_isbn_libro VARCHAR(15),

  FOREIGN KEY (id_codigo_autor) REFERENCES autores (codigo),
  FOREIGN KEY (id_isbn_libro) REFERENCES libros (isbn)

);

-- 1.3.b Ingreso de registro a la tabla "tipo de autores"
INSERT INTO tipo_autores (tipo_autor, id_codigo_autor, id_isbn_libro) VALUES ('PRINCIPAL', 1, '222-2222222-222');
INSERT INTO tipo_autores (tipo_autor, id_codigo_autor, id_isbn_libro) VALUES ('PRINCIPAL', 2, '333-3333333-333');
INSERT INTO tipo_autores (tipo_autor, id_codigo_autor, id_isbn_libro) VALUES ('PRINCIPAL', 3, '111-1111111-111');
INSERT INTO tipo_autores (tipo_autor, id_codigo_autor, id_isbn_libro) VALUES ('CO-AUTOR', 4, '111-1111111-111');
INSERT INTO tipo_autores (tipo_autor, id_codigo_autor, id_isbn_libro) VALUES ('PRINCIPAL', 5, '444-4444444-444');

-- 1.3.c Consulta a la tabla "tipo de autores" normalizada para mostrar sus registros
SELECT * FROM tipo_autores;

-- 1.4.a Normalización tabla "comuna"
CREATE TABLE comunas (
  id INT NOT NULL UNIQUE,
  nombre VARCHAR(100),
  
  PRIMARY KEY (id)

);

-- 1.4.b Ingreso de registro a la tabla "comuna"
INSERT INTO comunas (id, nombre) VALUES (1, 'Santiago');

-- 1.4.c Consulta a la tabla "comuna" normalizada para mostrar sus registros
SELECT * FROM comunas;

-- 1.5.a Normalización tabla "socios"
CREATE TABLE socios (
  rut VARCHAR(10),
  nombre VARCHAR(50),
  apellido VARCHAR(50),
  direccion VARCHAR(100) UNIQUE,
  telefono INT UNIQUE,
  id_comuna INT,

  PRIMARY KEY (rut),

  FOREIGN KEY (id_comuna) REFERENCES comunas (id)
);

-- 1.5.b Ingreso de registro a la tabla "socios"
INSERT INTO socios (rut, nombre, apellido, direccion, telefono, id_comuna) VALUES ('1111111-1', 'JUAN', 'SOTO', 'AVENIDA 1', 911111111, 1);
INSERT INTO socios (rut, nombre, apellido, direccion, telefono, id_comuna) VALUES ('2222222-2', 'ANA', 'PÉREZ', 'PASAJE 2', 922222222, 1);
INSERT INTO socios (rut, nombre, apellido, direccion, telefono, id_comuna) VALUES ('3333333-3', 'SANDRA', 'AGUILAR', 'AVENIDA 2', 933333333, 1);
INSERT INTO socios (rut, nombre, apellido, direccion, telefono, id_comuna) VALUES ('4444444-4', 'ESTEBAN', 'JEREZ', 'AVENIDA 3', 944444444, 1);
INSERT INTO socios (rut, nombre, apellido, direccion, telefono, id_comuna) VALUES ('5555555-5', 'SILVANA', 'MUÑOZ', 'PASAJE 3', 955555555, 1);

-- 1.5.c Consulta a la tabla "socios" normalizada para mostrar sus registros
SELECT * FROM socios;

-- 1.6.a Normalización tabla "socios"
CREATE TABLE historial (
  id SERIAL,
  fecha_prestamo DATE,
  fecha_devolucion DATE,
  id_rut_socio VARCHAR(10),
  id_isbn_libro VARCHAR(15),

  FOREIGN KEY (id_rut_socio) REFERENCES socios (rut),
  FOREIGN KEY (id_isbn_libro) REFERENCES libros (isbn)
);

-- 1.6.b Ingreso de registro a la tabla "socios"
INSERT INTO historial (fecha_prestamo, fecha_devolucion, id_rut_socio, id_isbn_libro) VALUES ('2020-01-20', '2020-01-27', '1111111-1', '111-1111111-111');
INSERT INTO historial (fecha_prestamo, fecha_devolucion, id_rut_socio, id_isbn_libro) VALUES ('2020-01-20', '2020-01-30', '5555555-5', '222-2222222-222');
INSERT INTO historial (fecha_prestamo, fecha_devolucion, id_rut_socio, id_isbn_libro) VALUES ('2020-01-22', '2020-01-30', '3333333-3', '333-3333333-333');
INSERT INTO historial (fecha_prestamo, fecha_devolucion, id_rut_socio, id_isbn_libro) VALUES ('2020-01-23', '2020-01-30', '4444444-4', '444-4444444-444');
INSERT INTO historial (fecha_prestamo, fecha_devolucion, id_rut_socio, id_isbn_libro) VALUES ('2020-01-27', '2020-02-04', '2222222-2', '111-1111111-111');
INSERT INTO historial (fecha_prestamo, fecha_devolucion, id_rut_socio, id_isbn_libro) VALUES ('2020-01-31', '2020-02-12', '1111111-1', '444-4444444-444');
INSERT INTO historial (fecha_prestamo, fecha_devolucion, id_rut_socio, id_isbn_libro) VALUES ('2020-01-31', '2020-02-12', '3333333-3', '222-2222222-222');

-- 1.5.c Consulta a la tabla "socios" normalizada para mostrar sus registros
SELECT socios.nombre, socios.apellido, libros.titulo, historial.fecha_prestamo, historial.fecha_devolucion
FROM historial
INNER JOIN socios ON historial.id_rut_socio = socios.rut
INNER JOIN libros ON historial.id_isbn_libro = libros.isbn;

\! echo ""
\! echo ""
\! echo "***************************************************************************"
\! echo "R.3.a Mostrar todos los libros que posean menos de 300 páginas.(0.5 puntos)"
\! echo "***************************************************************************"
\! echo ""

SELECT *
FROM libros
WHERE paginas <= 300
ORDER BY paginas ASC;

\! echo ""
\! echo ""
\! echo "*************************************************************************************"
\! echo "R.3.b Mostrar todos los autores que hayan nacido después del 01-01-1970. (0.5 puntos)"
\! echo "*************************************************************************************"
\! echo ""

SELECT nombre, apellido, ano_nacimiento AS "año de nacimiento"
FROM autores
WHERE ano_nacimiento >= 1970
ORDER BY ano_nacimiento ASC;

\! echo ""
\! echo ""
\! echo "****************************************************"
\! echo "R.3.c ¿Cuál es el libro más solicitado?(0.5 puntos)."
\! echo "****************************************************"
\! echo ""

CREATE TEMP TABLE tmp_ranking AS
SELECT
  libros.titulo AS titulo,
  COUNT(libros.titulo) AS cantidad
FROM historial
INNER JOIN libros ON historial.id_isbn_libro = libros.isbn
GROUP BY titulo
ORDER BY cantidad DESC, titulo ASC;

SELECT titulo, cantidad
FROM tmp_ranking
WHERE cantidad = (SELECT MAX(cantidad) FROM tmp_ranking);

\! echo ""
\! echo ""
\! echo "*********************************************************"
\! echo "R.3.d Multas por cobrar de CLP 100 por cada día de atraso"
\! echo "*********************************************************"
\! echo ""

CREATE TEMP TABLE tmp_multa AS
SELECT
  nombre,
  apellido,
  fecha_prestamo, (fecha_prestamo + 7) AS fecha_vencimiento,
  fecha_devolucion, (fecha_devolucion - (fecha_prestamo + 7)) AS dias_atraso
FROM historial
INNER JOIN socios ON historial.id_rut_socio = socios.rut;

SELECT *, (dias_atraso * 100) AS multa FROM tmp_multa
WHERE dias_atraso > 0
ORDER BY dias_atraso DESC;

SELECT SUM(dias_atraso * 100) AS "total multas por cobrar"
FROM tmp_multa
WHERE dias_atraso > 0;