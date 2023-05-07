DROP TABLE IF EXISTS proveedor_producto;
DROP TABLE IF EXISTS producto;
DROP TABLE IF EXISTS cliente;
DROP TABLE IF EXISTS contactoProveedor;
DROP TABLE IF EXISTS proveedor;
DROP TABLE IF EXISTS categoria_producto;
DROP TABLE IF EXISTS color;


-- Crea tabla categoria_producto
CREATE TABLE categoria_producto(
  id_categoria INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  nombre_categoria VARCHAR(45)
);

-- Crea tabla proveedor
CREATE TABLE proveedor(
  id_proveedor INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  representante_legal VARCHAR(45),
  nombre_corporativo VARCHAR(45),
  id_categoria INT,
  correo VARCHAR(45),
  CONSTRAINT fk_categoria_proveedor FOREIGN KEY (id_categoria) REFERENCES categoria_producto(id_categoria)
);

-- Crea tabla de contactoProveedor
CREATE TABLE contactoProveedor(
  id_proveedor INT,
  telefono VARCHAR(12),
  CONSTRAINT fk_id_proveedor FOREIGN KEY (id_proveedor) REFERENCES proveedor(id_proveedor)
);

-- Crea tabla cliente
CREATE TABLE cliente(
  id_cliente INT PRIMARY KEY NOT NULL AUTO_INCREMENT, 
  nombre VARCHAR(45), 
  apellido VARCHAR(45), 
  direccion VARCHAR(55)
);

-- Crea tabla color
CREATE TABLE color(
  id_color INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  nombre_color VARCHAR(45)
);

-- Crea tabla producto
CREATE TABLE producto(
  id_producto INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  modelo VARCHAR(45),
  precio INT,
  id_categoria INT,
  id_color INT,
  CONSTRAINT fk_id_color FOREIGN KEY (id_color) REFERENCES color(id_color),
  CONSTRAINT fk_id_categoria FOREIGN KEY (id_categoria) REFERENCES categoria_producto(id_categoria)
);

-- Crea tabla de proveedor producto
CREATE TABLE proveedor_producto(
  id_proveedor INT,
  id_producto INT,
  stock INT,
  CONSTRAINT fk_id_proveedor_ FOREIGN KEY (id_proveedor) REFERENCES proveedor(id_proveedor),
  CONSTRAINT fk_id_producto FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
);

-- Inserta datos en la tabla de categoría producto
INSERT INTO categoria_producto (nombre_categoria) VALUES
("Televisores"),
("Celulares"),
("Electrodomesticos"),
("Instrumentos Musicales"),
("Audio");

-- Inserta datos en la tabla de color
INSERT INTO color (nombre_color) VALUES
("Negro"),
("Gris"),
("Blanco"),
("Azul"),
("Rojo");

-- Inserta datos en la tabla producto
INSERT INTO producto (modelo, precio, id_categoria, id_color) VALUES
("Smart TV 55",350000,1,1),
("Smart TV 50",300000,1,2),
("Iphone 14",990000,2,3),
("Lavadora 8KG",195000,3,2),
("True Buds",25000,5,4),
("Air Pods",150000,5,3),
("Samsung S23",1200000,2,4),
("Equipo de música",80000,5,1),
("Refrigerador",520000,3,3),
("Bajo Precision Bass",1300000,4,5);

-- Añade tres nuevas columnas a la tabla 'proveedor'
ALTER TABLE proveedor ADD telefono1 varchar(20), ADD telefono2 varchar(20), ADD persona_contacto varchar(45);

-- Inserta cinco filas en la tabla 'proveedor'
-- Cada fila representa un proveedor con sus respectivos datos
INSERT INTO proveedor (representante_legal, nombre_corporativo, id_categoria, correo, telefono1, telefono2, persona_contacto) 
VALUES 
('Diego Pérez', 'ElectroMax', 1, 'Diego.perez@electromax.com', '962147815', '952747816', 'Pedro Sánchez'),
('Christopher Gómez', 'TecnoNet', 2, 'Christopher.gomez@tecnonet.com', '982047814', '972347817', 'María Torres'),
('Alejandro Rodríguez', 'ProElectro', 3, 'Alejandro.rodriguez@proelectro.com', '912647804', '902947812', 'Carlos Méndez'),
('Joshua López', 'Electromusic', 4, 'Joshua.lopez@electromusic.com', '992147871', '922847813', 'Juan González'),
('Enrique Hernández', 'AudioShop', 5, 'Enrique.hernandez@audioshop.com', '962447814', '942047810', 'Ana Ramírez');

-- Inserta cinco filas en la tabla 'cliente'
-- Cada fila representa un cliente con sus respectivos datos
INSERT INTO cliente (nombre, apellido, direccion)
VALUES
('María', 'García', 'Calle 123, Santiago'),
('Juan', 'Martínez', 'Avenida 456, Punta Arenas'),
('Ana', 'Fernández', 'Calle Principal, Villarrica'),
('Luis', 'González', 'Callejón 789, Santiago'),
('Pedro', 'Sánchez', 'Boulevard 1010, Puerto Montt');


-- Inserta el stock de cada producto, id proveedor y id producto de origen
INSERT INTO proveedor_producto (id_proveedor, id_producto, stock)
VALUES (5, 1, 52),
       (1, 1, 36),
       (3, 2, 5),
       (2, 3, 12),
       (4, 5, 356),
       (3, 5, 23),
       (1, 2, 18),
       (3, 5, 4),
       (5, 3, 6),
       (1, 4, 2);
       
 -- Para obtener la categoría de productos que más se repite en la tabla producto, se puede utilizar la siguiente consulta SQL  
SELECT id_categoria, COUNT(*) AS veces_repite
FROM producto
GROUP BY id_categoria
ORDER BY veces_repite DESC
LIMIT 1; 


 -- Los productos con mayor stock son los siguientes 3:
SELECT id_producto, SUM(stock) AS total_stock
FROM proveedor_producto
GROUP BY id_producto
ORDER BY total_stock DESC
Limit 3;

-- Qué color de producto es más común en nuestra tienda.
SELECT nombre_color, COUNT(*) AS total FROM color c
INNER JOIN producto p ON c.id_color = p.id_color
GROUP BY nombre_color
ORDER BY total DESC
LIMIT 1;


-- Cual o cuales son los proveedores con menor stock de productos.
SELECT p.nombre_corporativo, SUM(pp.stock) AS total_stock
FROM proveedor p 
INNER JOIN proveedor_producto pp ON p.id_proveedor = pp.id_proveedor
GROUP BY p.id_proveedor
ORDER BY total_stock ASC
LIMIT 3;


-- Cambien la categoría de productos más popular por ‘Electrónica y computación’.
ALTER TABLE categoria_producto RENAME COLUMN nombre_categoria TO electronica_y_computacion;
