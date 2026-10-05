-- Pasos previos (ejecutar manualmente): crear la base y conectarse a ella.
--CREATE DATABASE retail_project;
--\c retail_project

-- Limpieza (orden inverso por las FK)
DROP TABLE IF EXISTS ventas;
DROP TABLE IF EXISTS productos;
DROP TABLE IF EXISTS clientes;

-- DDL
CREATE TABLE clientes (
    id     SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email  VARCHAR(150) NOT NULL UNIQUE,
    edad   INT CHECK (edad >= 18)
);

-- DML: carga inicial (clientes)
BEGIN;

INSERT INTO clientes (nombre, email, edad) VALUES
  ('Ana Perez',  'ana@mail.com',  28),
  ('Santiago Martinez',  'santi@mail.com',  21),
  ('Lucas Sanchez',  'lucas@mail.com',  25),
  ('Giovanni Enzo',  'enzo@mail.com',  18),
  ('Luis Gomez', 'luis@mail.com', 35);
  
COMMIT;

-- DDL
CREATE TABLE productos (
    id        SERIAL PRIMARY KEY,
    nombre    VARCHAR(100) NOT NULL,
    categoria VARCHAR(50)  NOT NULL,
    precio    DECIMAL(10,2) NOT NULL CHECK (precio > 0),
    stock     INT NOT NULL DEFAULT 0 CHECK (stock >= 0)
);

-- DML: carga inicial (productos)
BEGIN;

INSERT INTO productos (nombre, categoria, precio, stock) VALUES
  ('Teclado mecanico', 'Perifericos', 45000.00, 20),
  ('Mouse inalambrico', 'Perifericos', 18000.50, 35),
  ('Monitor 24"',       'Monitores',   250000.00, 10),
  ('Auriculares',       'Audio',       32000.00, 15),
  ('Webcam HD',         'Perifericos', 28000.00, 12);

COMMIT;

--INSERT INTO productos (nombre, categoria, precio, stock) VALUES
--  ('Teclado RGB', 'Perifericos', 0, -1);
--COMMIT;

-- DDL
CREATE TABLE ventas (
    id              SERIAL PRIMARY KEY,
    cliente_id      INT NOT NULL,
    producto_id     INT NOT NULL,
    cantidad        INT NOT NULL CHECK (cantidad > 0),
    precio_unitario DECIMAL(10,2) NOT NULL CHECK (precio_unitario > 0),
    fecha           TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_ventas_cliente  FOREIGN KEY (cliente_id)  REFERENCES clientes (id),
    CONSTRAINT fk_ventas_producto FOREIGN KEY (producto_id) REFERENCES productos (id)
);

-- DML: carga inicial (ventas)
BEGIN;

INSERT INTO ventas (cliente_id, producto_id, cantidad, precio_unitario, fecha) VALUES
  (1, 1, 2, 45000.00,  '2026-09-01 10:30:00'),
  (2, 3, 1, 250000.00, '2026-09-03 15:45:00'),
  (3, 2, 3, 18000.50,  '2026-09-05 11:10:00'),
  (4, 4, 1, 32000.00,  '2026-09-08 18:20:00'),
  (5, 5, 2, 28000.00,  '2026-09-10 09:05:00');

COMMIT;

-- Mantenimiento
SELECT * FROM productos WHERE categoria = 'Perifericos';
-- Aumento del 10% a Perifericos.
UPDATE productos SET precio = precio * 1.10 WHERE categoria = 'Perifericos';

SELECT * FROM ventas WHERE id = 5;
-- Registro de prueba: elimina la venta id 5.
DELETE FROM ventas WHERE id = 5;
