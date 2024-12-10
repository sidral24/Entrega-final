create database dulceria;



create table proveedores(
	id_proveedor integer not null primary key,
	nombre varchar(30) not null,
	rfc varchar(20) not null,
	direccion varchar(100) not null,
	telefono varchar (15)
)


create table materias_primas(
	id_mp integer not null primary key,
	nombre varchar(30) not null,
	tipo varchar (30),
	lote varchar (30) not null,
	existencia varchar (15),
	fecha_cad date not null,
	precio integer not null
)


create table compras(
	id_compra serial primary key,
	id_proveedor integer not null,
	id_mp integer not null,
	fecha_compra date,
	lote varchar (30) not null,
	cantidad varchar (15) not null,
	precio integer not null,
	descuento numeric,
	foreign key (id_proveedor) references proveedores(id_proveedor),
	foreign key (id_mp) references materias_primas(id_mp)
)


create table fabricas(
	id_fabrica integer not null primary key,
	telefono varchar (15),
	nom_responsable varchar (30),
	estado varchar (50) not null,
	municipio varchar (50) not null,
	colonia varchar (30) not null,
	domicilio varchar (50) not null,
	cp integer 
)


create table elaboracion(
	id_elaboracion serial primary key,
	id_fabrica integer not null,
	id_trabajador integer not null,
	id_mp integer not null,
	id_dulce integer not null,
	cantidad integer ,
	foreign key (id_fabrica) references fabricas(id_fabrica),
	foreign key (id_mp) references materias_primas(id_mp),
	foreign key (id_trabajador) references trabajadores (id_trabajador),
	foreign key (id_dulce) references dulces (id_dulce)
)


create table sucursales(
	id_sucursal integer not null primary key,
	nom_responsable varchar (30),
	telefono varchar (15) not null,
	estado varchar (30) not null,
	municipio varchar (50) not null,
	colonia varchar (30) not null,
	domicilio varchar (80) not null,
	cp integer
)


create table trabajadores (
	id_trabajador integer not null primary key,
	id_sucursal integer not null,
	apellido_paterno varchar(30) not null,
	apellido_materno varchar(30) not null,
	nombres varchar (30) not null,
	fecha_nacimiento date not null,
	fecha_ingreso date not null,
	rfc varchar (20) not null,
	tipo varchar (20),
	telefono varchar(15),
	foreign key (id_sucursal) references sucursales (id_sucursal)
)


create table repartos(
	id_repartos serial primary key,
	id_fabrica integer not null,
	id_sucursal integer not null,
	id_trabajador integer not null,
	id_dulce integer not null,
	cantidad integer,
	fecha_reparto date,
	foreign key (id_fabrica) references fabricas (id_fabrica),
	foreign key (id_sucursal) references sucursales (id_sucursal),
	foreign key (id_trabajador) references trabajadores (id_trabajador),
	foreign key (id_dulce) references dulces(id_dulce)
)


create table usuarios(
	id_usuario integer not null primary key,
	apellido_paterno varchar(30) not null,
	apellido_materno varchar(30) not null,
	nombres varchar (30) not null,
	email varchar (80) not null unique,
	telefono varchar (15) not null
)


create table pedidos(
	id_pedido SERIAL primary key,
	id_usuario integer not null,
	id_sucursal integer not null,
	id_dulce integer not null,
	cantidad integer,
	fecha_pedido date,
	foreign key (id_sucursal) references sucursales (id_sucursal),
	foreign key (id_usuario) references usuarios (id_usuario),
	foreign key (id_dulce) references dulces (id_dulce)
)
 

create table dulces(
	id_dulce integer not null primary key,
	nombre varchar (30) not null,
	precio_uni money not null,
	stock integer ,
	lote varchar (30) not null,
	fecha_cad date not null,
	reorden integer check(reorden>=0),
	tipo varchar (20) check(tipo='CON AZUCAR' or tipo='SIN AZUCAR') 
)


create table ventas(
	id_venta SERIAL primary key,
	id_usuario integer not null,
	id_sucursal integer not null,
	id_dulce integer not null,
	cantidad integer,
	fecha date,
	precio_uni money not null,
	descuento integer ,
	foreign key (id_sucursal) references sucursales (id_sucursal),
	foreign key (id_usuario) references usuarios (id_usuario),
	foreign key (id_dulce) references dulces (id_dulce)
)


create table registros(
	id_registro SERIAL primary key,
	id_sucursal integer not null,
	id_dulce integer not null,
	cantidad integer,
	fecha_recepcion date not null,
	precio_uni money not null,
	foreign key (id_sucursal) references sucursales (id_sucursal),
	foreign key (id_dulce) references dulces (id_dulce)
)


-- inserciones 
INSERT INTO proveedores (id_proveedor, nombre, rfc, direccion, telefono)
VALUES
(1, 'Azúcares del Valle', 'AVR123456789', 'Calle Caramelo 123, Ciudad Dulce', '555-123-4567'),
(2, 'Esencias y Sabores S.A.', 'ESS234567890', 'Av. Vainilla 234, Colonia Sabrosa', '555-234-5678'),
(3, 'Chocolates Finos', 'CHF345678901', 'Calle Cacao 345, Ciudad Chocolate', '555-345-6789'),
(4, 'Colorantes Naturales', 'CNL456789012', 'Calle Arcoíris 456, Colonia Brillante', '555-456-7890'),
(5, 'Packaging Dulce', 'PKD567890123', 'Av. Empaque 567, Ciudad Envuelta', '555-567-8901'),
(6, 'Maquinaria Azucarera', 'MAZ678901234', 'Calle Miel 678, Zona Industrial', '555-678-9012'),
(7, 'Distribuciones Frutales', 'DFR789012345', 'Av. Manzana 789, Colonia Tropical', '555-789-0123');

INSERT INTO materias_primas (id_mp, nombre, tipo, lote, existencia, fecha_cad, precio)
VALUES
(1, 'Azúcar Refinada', 'Edulcorante', 'L1234', '1000 kg', '2025-12-31', 20),
(2, 'Cacao en Polvo', 'Saborizante', 'L5678', '500 kg', '2024-11-15', 45),
(3, 'Glucosa Líquida', 'Edulcorante', 'L2345', '800 L', '2025-06-01', 30),
(4, 'Gelatina sin Sabor', 'Texturizante', 'L3456', '600 kg', '2024-09-10', 25),
(5, 'Colorante Rojo', 'Colorante', 'L4567', '200 L', '2026-03-22', 15),
(6, 'Esencia de Vainilla', 'Saborizante', 'L6789', '100 L', '2024-12-05', 50),
(7, 'Sorbitol', 'Edulcorante', 'L7890', '300 kg', '2025-02-14', 35);

INSERT INTO compras (id_proveedor, id_mp, fecha_compra, lote, cantidad, precio, descuento)
VALUES
(1, 1, '2024-01-15', 'L1234', '500 kg', 10000, 5.0),  
(2, 2, '2024-02-01', 'L5678', '200 kg', 9000, 0.0),   
(3, 3, '2024-02-10', 'L2345', '300 L', 7500, 2.5),    
(4, 4, '2024-03-05', 'L3456', '400 kg', 10000, 3.0),  
(5, 5, '2024-03-20', 'L4567', '100 L', 3000, 1.5),    
(6, 6, '2024-04-12', 'L6789', '50 L', 2500, 0.0),    
(7, 7, '2024-04-25', 'L7890', '150 kg', 5250, 4.0),   -- Compra de Sorbitol a Emulsificantes y Conservantes S.A.
(1, 1, '2024-05-10', 'L1235', '700 kg', 14000, 6.0),  -- Otra compra de Azúcar Refinada a Azúcar Fina S.A.
(2, 2, '2024-05-20', 'L5679', '250 kg', 11250, 1.0),  -- Otra compra de Cacao en Polvo a Cacao Natural S.R.L.
(3, 3, '2024-06-01', 'L2346', '400 L', 10000, 2.0),   -- Otra compra de Glucosa Líquida a Frutas Tropicales S.A.
(4, 4, '2024-06-15', 'L3457', '300 kg', 7500, 3.5),   -- Otra compra de Gelatina sin Sabor a Colorantes y Sabores S.A.
(5, 5, '2024-07-05', 'L4568', '120 L', 3600, 2.0),    -- Otra compra de Colorante Rojo a Gelatina y Maíz S.R.L.
(6, 6, '2024-07-20', 'L6790', '60 L', 3000, 0.0),     -- Otra compra de Esencia de Vainilla a Esencias y Aromas Ltda.
(7, 7, '2024-08-10', 'L7891', '200 kg', 7000, 5.0),   -- Otra compra de Sorbitol a Emulsificantes y Conservantes S.A.
(1, 1, '2024-09-01', 'L1236', '800 kg', 16000, 7.0),  -- Más Azúcar Refinada a Azúcar Fina S.A.
(2, 2, '2024-09-15', 'L5680', '300 kg', 13500, 2.0),  -- Más Cacao en Polvo a Cacao Natural S.R.L.
(3, 3, '2024-10-01', 'L2347', '450 L', 11250, 2.5),   -- Más Glucosa Líquida a Frutas Tropicales S.A.
(4, 4, '2024-10-20', 'L3458', '350 kg', 8750, 4.0),   -- Más Gelatina sin Sabor a Colorantes y Sabores S.A.
(5, 5, '2024-11-05', 'L4569', '150 L', 4500, 3.0),    -- Más Colorante Rojo a Gelatina y Maíz S.R.L.
(6, 6, '2024-11-20', 'L6791', '80 L', 4000, 0.0);     -- Más Esencia de Vainilla a Esencias y Aromas Ltda.

INSERT INTO fabricas (id_fabrica, telefono, nom_responsable, estado, municipio, colonia, domicilio, cp)
VALUES
(1, '5551234567', 'Juan Pérez', 'Ciudad de México', 'Iztapalapa', 'Col. Dulce', 'Calle Caramelo 123', 09876),
(2, '5557654321', 'María Gómez', 'Jalisco', 'Guadalajara', 'Col. Golosina', 'Avenida Azúcar 456', 44100),
(3, '5558765432', 'Carlos Ramírez', 'Estado de México', 'Toluca', 'Col. Caramelo', 'Boulevard Chocolate 789', 50000),
(4, '5551357913', 'Ana Torres', 'Nuevo León', 'Monterrey', 'Col. Galleta', 'Calle Bombón 321', 64000),
(5, '5552468135', 'Laura Martínez', 'Puebla', 'Puebla', 'Col. Menta', 'Plaza Dulzura 654', 72000),
(6, '5553692587', 'Luis Sánchez', 'Veracruz', 'Veracruz', 'Col. Nube', 'Calle Goma 987', 91700),
(7, '5551478523', 'José Hernández', 'Yucatán', 'Mérida', 'Col. Regaliz', 'Parque Confite 852', 97000);

INSERT INTO elaboracion (id_fabrica, id_trabajador, id_mp, id_dulce, cantidad)
VALUES
(1, 1, 1, 1, 200),  -- Fábrica 1, Trabajador 1, Materia Prima 1, Dulce 1
(1, 2, 2, 2, 150),  -- Fábrica 1, Trabajador 2, Materia Prima 2, Dulce 2
(2, 3, 3, 3, 300),  -- Fábrica 2, Trabajador 3, Materia Prima 3, Dulce 3
(2, 1, 1, 4, 250),  -- Fábrica 2, Trabajador 1, Materia Prima 1, Dulce 4
(3, 2, 2, 5, 400),  -- Fábrica 3, Trabajador 2, Materia Prima 2, Dulce 5
(3, 3, 4, 6, 350),  -- Fábrica 3, Trabajador 3, Materia Prima 4, Dulce 6
(4, 1, 5, 7, 500),  -- Fábrica 4, Trabajador 1, Materia Prima 5, Dulce 7
(4, 2, 6, 6, 450),  -- Fábrica 4, Trabajador 2, Materia Prima 6, Dulce 8
(5, 3, 1, 1, 600),  -- Fábrica 5, Trabajador 3, Materia Prima 1, Dulce 1
(5, 1, 2, 2, 550),  -- Fábrica 5, Trabajador 1, Materia Prima 2, Dulce 2
(6, 2, 3, 3, 700),  -- Fábrica 6, Trabajador 2, Materia Prima 3, Dulce 3
(6, 3, 4, 4, 650),  -- Fábrica 6, Trabajador 3, Materia Prima 4, Dulce 4
(7, 1, 5, 5, 800),  -- Fábrica 7, Trabajador 1, Materia Prima 5, Dulce 5
(7, 2, 6, 6, 750),  -- Fábrica 7, Trabajador 2, Materia Prima 6, Dulce 6
(1, 3, 7, 7, 900),  -- Fábrica 1, Trabajador 3, Materia Prima 7, Dulce 7
(2, 1, 1, 4, 850),  -- Fábrica 2, Trabajador 1, Materia Prima 1, Dulce 8
(3, 2, 2, 1, 950),  -- Fábrica 3, Trabajador 2, Materia Prima 2, Dulce 1
(4, 3, 3, 2, 1000), -- Fábrica 4, Trabajador 3, Materia Prima 3, Dulce 2
(5, 1, 4, 3, 1100), -- Fábrica 5, Trabajador 1, Materia Prima 4, Dulce 3
(6, 2, 5, 4, 1200); -- Fábrica 6, Trabajador 2, Materia Prima 5, Dulce 4

INSERT INTO sucursales (id_sucursal, nom_responsable, telefono, estado, municipio, colonia, domicilio, cp)
VALUES
(1, 'Pedro Sánchez', '5551234567', 'Ciudad de México', 'Coyoacán', 'Col. Alegre', 'Avenida Azucarera 101', 04360),
(2, 'María López', '5552345678', 'Jalisco', 'Guadalajara', 'Col. Dulce', 'Calle de la Chocolatería 202', 44100),
(3, 'José Fernández', '5553456789', 'Nuevo León', 'Monterrey', 'Col. Sabrosa', 'Boulevard de los Caramelos 303', 64000),
(4, 'Laura Torres', '5554567890', 'Puebla', 'Puebla', 'Col. Fresa', 'Calle de los Bombones 404', 72000),
(5, 'Carlos Ramírez', '5555678901', 'Veracruz', 'Veracruz', 'Col. Miel', 'Calle de la Galleta 505', 91700),
(6, 'Ana Martínez', '5556789012', 'Yucatán', 'Mérida', 'Col. Regaliz', 'Avenida Dulzura 606', 97000),
(7, 'Luis García', '5557890123', 'Quintana Roo', 'Cancún', 'Col. Man', 'Calle de los Chicles 707', 77500);

INSERT INTO trabajadores (id_trabajador, id_sucursal, apellido_paterno, apellido_materno, nombres, fecha_nacimiento, fecha_ingreso, rfc, tipo, telefono)
VALUES
(1, 1, 'Sánchez', 'Gómez', 'Pedro', '1990-05-15', '2022-01-10', 'SAGP900515HDFMPR01', 'Permanente', '5551234567'),
(2, 1, 'López', 'Martínez', 'María', '1985-08-22', '2021-03-15', 'LOMM850822HDFMTR02', 'Permanente', '5552345678'),
(3, 2, 'Fernández', 'Hernández', 'José', '1992-11-30', '2023-02-20', 'FEHJ920113HDFMNR03', 'Temporal', '5553456789'),
(4, 2, 'Ramírez', 'Torres', 'Ana', '1988-03-12', '2020-06-25', 'RATA880312HDFMRA04', 'Permanente', '5554567890'),
(5, 3, 'Martínez', 'Sánchez', 'Carlos', '1995-07-05', '2021-09-01', 'MASC950705HDFMCR05', 'Temporal', '5555678901'),
(6, 4, 'García', 'Mendoza', 'Laura', '1990-12-18', '2022-11-15', 'GAML901218HDFMDA06', 'Permanente', '5556789012'),
(7, 5, 'Hernández', 'Luna', 'Luis', '1987-04-25', '2020-05-30', 'HELU870425HDFMLU07', 'Temporal', '5557890123');

INSERT INTO repartos (id_fabrica, id_sucursal, id_trabajador, id_dulce, cantidad, fecha_reparto)
VALUES
(1, 1, 1, 1, 100, '2024-10-01'),  -- Fábrica 1, Sucursal 1, Trabajador 1, Dulce 1
(1, 2, 2, 2, 150, '2024-10-02'),  -- Fábrica 1, Sucursal 2, Trabajador 2, Dulce 2
(2, 1, 3, 3, 200, '2024-10-03'),  -- Fábrica 2, Sucursal 1, Trabajador 3, Dulce 3
(2, 2, 1, 4, 250, '2024-10-04'),  -- Fábrica 2, Sucursal 2, Trabajador 1, Dulce 4
(3, 3, 2, 5, 300, '2024-10-05'),  -- Fábrica 3, Sucursal 3, Trabajador 2, Dulce 5
(3, 1, 3, 6, 350, '2024-10-06'),  -- Fábrica 3, Sucursal 1, Trabajador 3, Dulce 6
(4, 4, 1, 7, 400, '2024-10-07'),  -- Fábrica 4, Sucursal 4, Trabajador 1, Dulce 7
(4, 5, 2, 4, 450, '2024-10-08'),  -- Fábrica 4, Sucursal 5, Trabajador 2, Dulce 8
(5, 6, 3, 1, 500, '2024-10-09'),  -- Fábrica 5, Sucursal 6, Trabajador 3, Dulce 1
(5, 7, 1, 2, 550, '2024-10-10'),  -- Fábrica 5, Sucursal 7, Trabajador 1, Dulce 2
(1, 3, 2, 3, 600, '2024-10-11'),  -- Fábrica 1, Sucursal 3, Trabajador 2, Dulce 3
(2, 4, 3, 4, 650, '2024-10-12'),  -- Fábrica 2, Sucursal 4, Trabajador 3, Dulce 4
(3, 5, 1, 5, 700, '2024-10-13'),  -- Fábrica 3, Sucursal 5, Trabajador 1, Dulce 5
(4, 6, 2, 6, 750, '2024-10-14'),  -- Fábrica 4, Sucursal 6, Trabajador 2, Dulce 6
(5, 7, 3, 7, 800, '2024-10-15'),  -- Fábrica 5, Sucursal 7, Trabajador 3, Dulce 7
(1, 2, 1, 2, 850, '2024-10-16'),  -- Fábrica 1, Sucursal 2, Trabajador 1, Dulce 8
(2, 3, 2, 1, 900, '2024-10-17'),  -- Fábrica 2, Sucursal 3, Trabajador 2, Dulce 1
(3, 4, 3, 2, 950, '2024-10-18'),  -- Fábrica 3, Sucursal 4, Trabajador 3, Dulce 2
(4, 5, 1, 3, 1000, '2024-10-19'), -- Fábrica 4, Sucursal 5, Trabajador 1, Dulce 3
(5, 6, 2, 4, 1050, '2024-10-20'); -- Fábrica 5, Sucursal 6, Trabajador 2, Dulce 4

INSERT INTO usuarios (id_usuario, apellido_paterno, apellido_materno, nombres, email, telefono)
VALUES
(1, 'Sánchez', 'Gómez', 'Pedro', 'pedro.sanchez@example.com', '5551234567'),
(2, 'López', 'Martínez', 'María', 'maria.lopez@example.com', '5552345678'),
(3, 'Fernández', 'Hernández', 'José', 'jose.fernandez@example.com', '5553456789'),
(4, 'Ramírez', 'Torres', 'Ana', 'ana.ramirez@example.com', '5554567890'),
(5, 'Martínez', 'Sánchez', 'Carlos', 'carlos.martinez@example.com', '5555678901'),
(6, 'García', 'Mendoza', 'Laura', 'laura.garcia@example.com', '5556789012'),
(7, 'Hernández', 'Luna', 'Luis', 'luis.hernandez@example.com', '5557890123');

INSERT INTO pedidos (id_usuario, id_sucursal, id_dulce, cantidad, fecha_pedido)
VALUES
(1, 1, 1, 5, '2024-10-01'),   -- Usuario 1, Sucursal 1, Dulce 1, Cantidad 5
(2, 1, 2, 10, '2024-10-02'),  -- Usuario 2, Sucursal 1, Dulce 2, Cantidad 10
(3, 2, 3, 3, '2024-10-03'),   -- Usuario 3, Sucursal 2, Dulce 3, Cantidad 3
(4, 2, 4, 20, '2024-10-04'),  -- Usuario 4, Sucursal 2, Dulce 4, Cantidad 20
(5, 3, 5, 15, '2024-10-05'),  -- Usuario 5, Sucursal 3, Dulce 5, Cantidad 15
(6, 3, 1, 12, '2024-10-06'),  -- Usuario 6, Sucursal 3, Dulce 1, Cantidad 12
(7, 4, 2, 8, '2024-10-07'),   -- Usuario 7, Sucursal 4, Dulce 2, Cantidad 8
(1, 4, 3, 9, '2024-10-08'),   -- Usuario 1, Sucursal 4, Dulce 3, Cantidad 9
(2, 5, 4, 11, '2024-10-09'),  -- Usuario 2, Sucursal 5, Dulce 4, Cantidad 11
(3, 5, 5, 14, '2024-10-10'),  -- Usuario 3, Sucursal 5, Dulce 5, Cantidad 14
(4, 6, 1, 18, '2024-10-11'),  -- Usuario 4, Sucursal 6, Dulce 1, Cantidad 18
(5, 6, 2, 6, '2024-10-12'),   -- Usuario 5, Sucursal 6, Dulce 2, Cantidad 6
(6, 7, 3, 7, '2024-10-13'),   -- Usuario 6, Sucursal 7, Dulce 3, Cantidad 7
(7, 7, 4, 25, '2024-10-14'),  -- Usuario 7, Sucursal 7, Dulce 4, Cantidad 25
(1, 1, 5, 30, '2024-10-15'),   -- Usuario 1, Sucursal 1, Dulce 5, Cantidad 30
(2, 2, 1, 4, '2024-10-16'),   -- Usuario 2, Sucursal 2, Dulce 1, Cantidad 4
(3, 3, 2, 5, '2024-10-17'),   -- Usuario 3, Sucursal 3, Dulce 2, Cantidad 5
(4, 4, 3, 16, '2024-10-18'),  -- Usuario 4, Sucursal 4, Dulce 3, Cantidad 16
(5, 5, 4, 7, '2024-10-19'),   -- Usuario 5, Sucursal 5, Dulce 4, Cantidad 7
(6, 6, 5, 9, '2024-10-20');   -- Usuario 6, Sucursal 6, Dulce 5, Cantidad 9

INSERT INTO dulces (id_dulce, nombre, precio_uni, stock, lote, fecha_cad, reorden, tipo)
VALUES
(1, 'Ate de Membrillo', 50.00, 100, 'Lote001', '2025-12-31', 20, 'CON AZUCAR'),
(2, 'Cajeta de Cabra', 60.00, 80, 'Lote002', '2025-11-30', 15, 'CON AZUCAR'),
(3, 'Dulce de Calabaza', 30.00, 150, 'Lote003', '2025-10-15', 25, 'CON AZUCAR'),
(4, 'Tamarindo', 20.00, 200, 'Lote004', '2025-09-01', 30, 'SIN AZUCAR'),
(5, 'Nueces Garapiñadas', 70.00, 90, 'Lote005', '2025-12-01', 10, 'CON AZUCAR'),
(6, 'Dulce de Leche', 40.00, 120, 'Lote006', '2025-12-15', 20, 'CON AZUCAR'),
(7, 'Jamón de Frutas', 45.00, 110, 'Lote007', '2025-11-15', 15, 'SIN AZUCAR');

INSERT INTO ventas (id_usuario, id_sucursal, id_dulce, cantidad, fecha, precio_uni, descuento)
VALUES
(1, 1, 1, 2, '2024-10-01', 50.00, 5),    -- Usuario 1, Sucursal 1, Dulce 1, Cantidad 2
(2, 1, 2, 5, '2024-10-02', 60.00, 10),   -- Usuario 2, Sucursal 1, Dulce 2, Cantidad 5
(3, 2, 3, 1, '2024-10-03', 30.00, 0),    -- Usuario 3, Sucursal 2, Dulce 3, Cantidad 1
(4, 2, 4, 3, '2024-10-04', 20.00, 2),    -- Usuario 4, Sucursal 2, Dulce 4, Cantidad 3
(5, 3, 5, 10, '2024-10-05', 40.00, 5),   -- Usuario 5, Sucursal 3, Dulce 5, Cantidad 10
(6, 3, 1, 4, '2024-10-06', 50.00, 0),    -- Usuario 6, Sucursal 3, Dulce 1, Cantidad 4
(7, 4, 2, 6, '2024-10-07', 60.00, 5),    -- Usuario 7, Sucursal 4, Dulce 2, Cantidad 6
(1, 4, 3, 7, '2024-10-08', 20.00, 0),    -- Usuario 1, Sucursal 4, Dulce 3, Cantidad 7
(2, 5, 4, 8, '2024-10-09', 20.00, 3),    -- Usuario 2, Sucursal 5, Dulce 4, Cantidad 8
(3, 5, 5, 5, '2024-10-10', 40.00, 0),    -- Usuario 3, Sucursal 5, Dulce 5, Cantidad 5
(4, 6, 1, 9, '2024-10-11', 50.00, 2),    -- Usuario 4, Sucursal 6, Dulce 1, Cantidad 9
(5, 6, 2, 1, '2024-10-12', 60.00, 0),    -- Usuario 5, Sucursal 6, Dulce 2, Cantidad 1
(6, 7, 3, 2, '2024-10-13', 20.00, 1),    -- Usuario 6, Sucursal 7, Dulce 3, Cantidad 2
(7, 7, 4, 15, '2024-10-14', 20.00, 0),   -- Usuario 7, Sucursal 7, Dulce 4, Cantidad 15
(1, 1, 5, 8, '2024-10-15', 40.00, 2),    -- Usuario 1, Sucursal 1, Dulce 5, Cantidad 8
(2, 2, 1, 3, '2024-10-16', 50.00, 0),    -- Usuario 2, Sucursal 2, Dulce 1, Cantidad 3
(3, 3, 2, 4, '2024-10-17', 60.00, 3),    -- Usuario 3, Sucursal 3, Dulce 2, Cantidad 4
(4, 4, 3, 12, '2024-10-18', 20.00, 5),   -- Usuario 4, Sucursal 4, Dulce 3, Cantidad 12
(5, 5, 4, 7, '2024-10-19', 20.00, 0),    -- Usuario 5, Sucursal 5, Dulce 4, Cantidad 7
(6, 6, 5, 3, '2024-10-20', 40.00, 0);    -- Usuario 6, Sucursal 6, Dulce 5, Cantidad 3

INSERT INTO registros (id_sucursal, id_dulce, cantidad, fecha_recepcion, precio_uni)
VALUES
(1, 1, 50, '2024-10-01', 45.00),   -- Sucursal 1, Dulce 1, Cantidad 50
(1, 2, 30, '2024-10-02', 55.00),   -- Sucursal 1, Dulce 2, Cantidad 30
(2, 3, 40, '2024-10-03', 25.00),   -- Sucursal 2, Dulce 3, Cantidad 40
(2, 4, 60, '2024-10-04', 20.00),   -- Sucursal 2, Dulce 4, Cantidad 60
(3, 5, 20, '2024-10-05', 60.00),   -- Sucursal 3, Dulce 5, Cantidad 20
(3, 1, 100, '2024-10-06', 45.00),  -- Sucursal 3, Dulce 1, Cantidad 100
(4, 2, 70, '2024-10-07', 55.00),   -- Sucursal 4, Dulce 2, Cantidad 70
(4, 3, 80, '2024-10-08', 25.00),   -- Sucursal 4, Dulce 3, Cantidad 80
(5, 4, 90, '2024-10-09', 20.00),   -- Sucursal 5, Dulce 4, Cantidad 90
(5, 5, 10, '2024-10-10', 60.00),   -- Sucursal 5, Dulce 5, Cantidad 10
(6, 1, 50, '2024-10-11', 45.00),   -- Sucursal 6, Dulce 1, Cantidad 50
(6, 2, 40, '2024-10-12', 55.00),   -- Sucursal 6, Dulce 2, Cantidad 40
(7, 3, 30, '2024-10-13', 25.00),   -- Sucursal 7, Dulce 3, Cantidad 30
(7, 4, 60, '2024-10-14', 20.00),   -- Sucursal 7, Dulce 4, Cantidad 60
(1, 5, 20, '2024-10-15', 60.00),   -- Sucursal 1, Dulce 5, Cantidad 20
(2, 1, 75, '2024-10-16', 45.00),   -- Sucursal 2, Dulce 1, Cantidad 75
(3, 2, 55, '2024-10-17', 55.00),   -- Sucursal 3, Dulce 2, Cantidad 55
(4, 3, 90, '2024-10-18', 25.00),   -- Sucursal 4, Dulce 3, Cantidad 90
(5, 4, 15, '2024-10-19', 20.00),   -- Sucursal 5, Dulce 4, Cantidad 15
(6, 5, 50, '2024-10-20', 60.00);   -- Sucursal 6, Dulce 5, Cantidad 50


--PEDIDOS Y VENTAS A USUARIOS(CLIENTES); ISIDRO ARREDONDO CAMARENA
--1. Mostrar pedidos y ventas dirigido a la interfaz de usuario
	--MOSTRAR TODOS LOS PEDIDIOS
	SELECT * FROM pedidos 
	-- MOSTRAR TODAS LAS VENTAS
	SELECT * FROM ventas
	
--2. cuantos pedidos por usuario tienen
	-- VER SI EL USUARIO EXISTE
		SELECT 1 FROM usuarios
		WHERE id_usuario= 2

	--CONSULTAR LOS PEDIDOS DE ESE USUARIO
		SELECT * FROM pedidos
		WHERE id_usuario =2
		
--3. que pedidos se hicieron entre las fechas de 05/10/2024 y 09/10/2024
	SELECT * FROM pedidos P 
	WHERE fecha_pedido BETWEEN '2024-10-05' AND '2024-10-09'
	
--4. ventas por semana de los dulces
	--PRIMERO VER SI HAY VENTAS
		SELECT * FROM ventas
	--LUEGO VER EN QUE SEMANA QUIEREN Y SI SE ENCUENTRA EN EL SISTEMA\
		SELECT 1 FROM ventas
		WHERE fecha BETWEEN '2024-10-05' AND '2024-10-09'
	--AHORA SI VER LAS VENTAS COMPLETAS
		SELECT * FROM ventas
		WHERE fecha BETWEEN '2024-10-05' AND '2024-10-09'
	--SI SE REQUIERE SABER EL NOMBRE DEL DULCE Y LA CANTIDAD QUE SE VENDIO EN UNA VENTA
		SELECT V.id_venta, D.nombre, V.cantidad FROM ventas V
		LEFT JOIN dulces D ON D.id_dulce=V.id_dulce
		
--5. cual dulce tiene mas stock
	SELECT  * FROM dulces
	ORDER BY stock DESC
	limit 1 

--6. el dulce que esta mas pronto a acabarse
	SELECT  * FROM dulces
	ORDER BY stock
	limit 1 
	
--7. los dulces que se encuentren en punto de reorden 
	SELECT * FROM dulces
	WHERE stock<=reorden
	
--8. el dulce que mas hay en cada sucursal
	SELECT  * FROM registros
	ORDER BY cantidad
	limit 1 
	--SE QUIERE SABER TAMBIEN QUIEN SE ENCARGA DE ESA SUCURSAL
		SELECT R.id_sucursal, S.nom_responsable FROM registros R
		JOIN sucursales S ON R.id_sucursal= S.id_sucursal
		ORDER BY cantidad
		limit 1 
	-- Y TAMBIEN EL NOMBRE DEL DULCE 
		SELECT R.id_sucursal, S.nom_responsable,D.nombre FROM registros R
		JOIN sucursales S ON R.id_sucursal= S.id_sucursal
		JOIN dulces D ON R.id_dulce=D.id_dulce
		ORDER BY cantidad
		limit 1 
		
--9. cuantos usuarios hacen pedidos a una sucursal
	--VER SI LA SUCURSAL EXISTE
		SELECT 1 FROM sucursales
		WHERE id_sucursal = 3
	--YA VIENDO QUE EXISTE AHORA SI HACEMOS LA CONSULTA
		SELECT S.id_sucursal, COUNT(*) 
		FROM sucursales S
		JOIN pedidos P ON S.id_sucursal = P.id_sucursal
		GROUP BY S.id_sucursal

--10. cuantos usuarios hacen compras a las sucursales
		SELECT S.id_sucursal, COUNT(*) 
		FROM sucursales S
		JOIN ventas V ON S.id_sucursal = V.id_sucursal
		GROUP BY S.id_sucursal
	--SI SE REQUIERE SABER QUE USUARIOS A UNA SUCURSAL EN CONCRETO
		SELECT S.id_sucursal, U.id_usuario, U.nombres,U.apellido_paterno
		FROM sucursales S
		JOIN pedidos P ON S.id_sucursal = P.id_sucursal
		JOIN usuarios U ON U.id_usuario=P.id_usuario
		WHERE S.id_sucursal= 2
		
--11. que sucursal recibe mas pedidos
		SELECT S.id_sucursal, COUNT(*) AS "CANTIDAD DE PEDIDOS"
		FROM sucursales S
		JOIN pedidos P ON P.id_sucursal=S.id_sucursal
		GROUP BY S.id_sucursal
		ORDER BY COUNT(*) DESC
		limit 1 
		
--13. cual es el usuario que mas compra
	--SIN APLICARLE EL DESCUENTO
		SELECT id_usuario, SUM(cantidad*precio_uni) as total,
		SUM(cantidad*precio_uni*descuento/100) AS "DESCUENTO DE LA COMPRA"
		FROM ventas
		GROUP BY id_usuario
		ORDER BY SUM(cantidad*precio_uni) DESC
		limit 1 
	--APLICANDOLE DESCUENTO
		SELECT id_usuario, SUM(cantidad*precio_uni) as total,
		SUM(cantidad*precio_uni*descuento/100) AS "DESCUENTO DE LA COMPRA",
		SUM((cantidad*precio_uni)-(cantidad*precio_uni*descuento/100))
		FROM ventas
		GROUP BY id_usuario
		ORDER BY SUM(cantidad*precio_uni) DESC
		limit 1 
		
--14. cual es el ususario que mas hace pedidos
	SELECT  id_usuario, COUNT(*) AS "TOTAL DE PEDIDOS"
	FROM pedidos
	GROUP BY id_usuario
	limit 1 


