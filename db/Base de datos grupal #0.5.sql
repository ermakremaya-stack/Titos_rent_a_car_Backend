CREATE DATABASE BD_rentacar_G3;
USE BD_rentacar_G3;

-- Tabla Cliente
CREATE TABLE Cliente (
    Id_Cliente INT PRIMARY KEY AUTO_INCREMENT,
    Cedula VARCHAR (16) NOT NULL,
    Nombre1 VARCHAR(50) NOT NULL,
    Nombre2 varchar(50) not null,
    Apellido1 varchar(50) not null,
    Apellido2 VARCHAR(50),
    Telefono VARCHAR(8) NOT NULL,
    Direccion TEXT NOT NULL,
    Email VARCHAR(100) UNIQUE,
    Licencia VARCHAR (8)
);

CREATE TABLE Empleado (
    Id_Empleado INT PRIMARY KEY AUTO_INCREMENT,
    Cedula VARCHAR (16) NOT NULL,
    Nombre1 VARCHAR(50) NOT NULL,
    Nombre2 varchar(50) not null,
    Apellido1 VARCHAR(50) NOT NULL,
    Apellido2 varchar(50),
    Direccion VARCHAR(150) NOT NULL,
    Email VARCHAR(150) UNIQUE
);

-- Tabla Coche
CREATE TABLE Coche (
    Id_Coche INT PRIMARY KEY AUTO_INCREMENT,
    Marca VARCHAR(50) NOT NULL,
    Modelo VARCHAR(20) NOT NULL,
    Anio INT NOT NULL,
    Placa VARCHAR (7),
    Color VARCHAR (50),
    Fecha_Registro DATE,
    Estado text
);

-- Tabla Alquiler
CREATE TABLE Alquiler (
    Id_Alquiler INT PRIMARY KEY AUTO_INCREMENT,
    Fecha_Inicio DATETime NOT NULL,
    Fecha_Fin DATETime NOT NULL
);

-- Tabla Detalle_Alquiler
CREATE TABLE Detalle_Alquiler (
    Id_Detalle_Alquiler INT PRIMARY KEY AUTO_INCREMENT,
    Id_Alquiler INT,
    Id_Coche INT,
    Id_Cliente INT,
    Precio_Total DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (Id_Alquiler) REFERENCES Alquiler(Id_Alquiler) ON DELETE CASCADE,
    FOREIGN KEY (Id_Coche) REFERENCES Coche(Id_Coche) ON DELETE CASCADE,
    FOREIGN KEY (Id_Cliente) REFERENCES Cliente(Id_Cliente) ON DELETE CASCADE
);

-- Tabla Mantenimiento de Coche
CREATE TABLE Mantenimiento (
    Id_Mantenimiento INT PRIMARY KEY AUTO_INCREMENT,
    Descripcion TEXT NOT NULL,
    Justificacion TEXT NOT NULL,
    Fecha_Inicio DATETIME NOT NULL,
    Fecha_Fin DATETIME NOT NULL,
    Costo DECIMAL(10,2) NOT NULL
);

CREATE TABLE Detalle_Mantenimiento (
	Id_Detalle_Mantenimiento INT PRIMARY KEY AUTO_INCREMENT,
    Id_Mantenimiento INT,
    Id_Empleado INT,
    Id_Coche INT,
    Observaciones TEXT,
    Recomendaciones TEXT,
    Partes_Cambiadas text,
    FOREIGN KEY (Id_Mantenimiento) REFERENCES Mantenimiento(Id_Mantenimiento),
    FOREIGN KEY (Id_Empleado) REFERENCES Empleado(Id_Empleado),
    FOREIGN KEY (Id_Coche) REFERENCES Coche(Id_Coche)
);

-- CREAR USUARIOS DE PRUEBA EN EL SERVIDOR

CREATE USER IF NOT EXISTS 'Yaleska'@'localhost' IDENTIFIED BY 'admin5678';
CREATE USER IF NOT EXISTS 'Cristal'@'localhost' IDENTIFIED BY 'editor3478';
CREATE USER IF NOT EXISTS 'Roberto'@'localhost' IDENTIFIED BY 'lector8878';

-- Eliminar usuario
DROP USER 'Yaleska'@'localhost';
DROP USER 'Cristal'@'localhost';
DROP USER 'Roberto'@'localhost';

-- ADMINISTRADOR 
-- Para agregar permisos
GRANT INSERT ON BD_rentacar_G3.Cliente TO 'Yaleska'@'localhost';

-- EDITOR
GRANT UPDATE, SELECT ON BD_rentacar_G3.Cliente TO 'Cristal'@'localhost';

-- Lector
GRANT SELECT ON BD_rentacar_G3.Cliente TO 'Roberto'@'localhost';




-- -----------------------------------------------------------------------------------

-- Insertar datos en la tabla Cliente
INSERT INTO Cliente (Cedula, Nombre1, Nombre2, Apellido1, Apellido2, Telefono, Direccion, Email, Licencia) VALUES
('001-010101-0000A', 'Juan', 'Miguel', 'Perez', 'Sanchez', '12345678', 'Calle Falsa 123', 'juan.perez@email.com', 'LIC-001'),
('002-020202-0000B', 'Maria', 'Lopez', 'Lopez', 'Garcia', '87654321', 'Avenida Central 456', 'maria.lopez@email.com', 'LIC-B2'),
('003-030303-0000C', 'Carlos', 'Antonio', 'Gomez', 'Rodriguez', '11223344', 'Calle Luna 789', 'carlos.gomez@email.com', 'LIC-003'),
('004-040404-0000D', 'Ana', 'Maria', 'Martinez', 'Pereira', '55667788', 'Calle Sol 101', 'ana.martinez@email.com', 'LIC-A1'),
('005-050505-0000E', 'Luis', 'Fernando', 'Diaz', 'Gonzalez', '22334455', 'Avenida Libertad 234', 'luis.diaz@email.com', 'LIC-B2'),
('006-060606-0000F', 'Patricia', 'Luisa', 'Fernandez', 'Castillo', '33445566', 'Calle 9 de Julio 567', 'patricia.fernandez@email.com', 'LIC-001'),
('007-070707-0000G', 'Miguel', 'Angel', 'Hernandez', 'Moreno', '44556677', 'Calle de la Paz 890', 'miguel.hernandez@email.com', 'LIC-C3'),
('008-080808-0000H', 'Elena', 'Maria', 'Garcia', 'Ruiz', '55667788', 'Avenida de Mayo 321', 'elena.garcia@email.com', 'LIC-A1'),
('009-090909-0000I', 'Juan', 'Carlos', 'Sanchez', 'Perez', '66778899', 'Calle 12 de Octubre 654', 'juan.sanchez@email.com', 'LIC-B2'),
('010-101010-0000J', 'Ricardo', 'David', 'Ruiz', 'Lopez', '77889900', 'Avenida Argentina 432', 'ricardo.ruiz@email.com', 'LIC-B1'),
('011-111111-0000K', 'Carmen', 'Elena', 'Morales', 'Hernandez', '88990011', 'Calle Independencia 765', 'carmen.morales@email.com', 'LIC-C3'),
('012-121212-0000L', 'Sergio', 'Alejandro', 'Torres', 'Santos', '99001122', 'Avenida del Sol 876', 'sergio.torres@email.com', 'LIC-001'),
('013-131313-0000M', 'Rosa', 'Beatriz', 'Jimenez', 'Diaz', '10111213', 'Calle de los Pinos 987', 'rosa.jimenez@email.com', 'LIC-A2'),
('014-141414-0000N', 'Eduardo', 'Alfonso', 'Vazquez', 'Rivera', '21222324', 'Calle Mistral 100', 'eduardo.vazquez@email.com', 'LIC-B1'),
('015-151515-0000O', 'Gabriela', 'Fernanda', 'Ruiz', 'Martinez', '32333435', 'Avenida Costa Rica 234', 'gabriela.ruiz@email.com', 'LIC-C2'),
('016-161616-0000P', 'Felipe', 'Antonio', 'Serrano', 'Jimenez', '43444546', 'Calle Mirador 432', 'felipe.serrano@email.com', 'LIC-B2'),
('017-171717-0000Q', 'Carla', 'Lucia', 'Castro', 'Fernandez', '54565768', 'Avenida Universitaria 123', 'carla.castro@email.com', 'LIC-A1'),
('018-181818-0000R', 'David', 'Manuel', 'Mendez', 'Morales', '65676879', 'Calle Las Palmas 876', 'david.mendez@email.com', 'LIC-B1'),
('019-191919-0000S', 'Laura', 'Patricia', 'Salazar', 'Lopez', '76787980', 'Avenida San Martin 345', 'laura.salazar@email.com', 'LIC-C3'),
('020-202020-0000T', 'Antonio', 'Carlos', 'Gonzalez', 'Vazquez', '87898091', 'Calle del Bosque 654', 'antonio.gonzalez@email.com', 'LIC-003');



-- Insertar datos en la tabla Empleados
INSERT INTO Empleado (Cedula, Nombre1,Nombre2, Apellido1,Apellido2, Direccion, Email) VALUES
('003-030303-0000C', 'Marcelo','Jose', 'Martines','Gonzalez', 'De la carretera la manzana 1c sur llegando a chernovil', 'Covid19MalumaYoPerreoSola@gmail.com'),
('007-070707-0000G', 'Luis','Mario', 'Rodriguez','Medina', 'Avenida Las Américas 123', 'RobaCarros@gmail.com');




-- Insertar datos en la tabla Coche
INSERT INTO Coche (Marca, Modelo, Anio, Placa, Color, Fecha_Registro, Estado) VALUES
('Toyota', 'Corolla', 2022, 'ABC123', 'Rojo', '2024-01-15', 'Disponible'),
('Honda', 'Civic', 2021, 'XYZ789', 'Azul', '2024-01-20', 'Disponible'),
('Ford', 'Focus', 2023, 'DEF456', 'Negro', '2024-01-25', 'Disponible'),
('Chevrolet', 'Cruze', 2020, 'GHI789', 'Blanco', '2024-02-01', 'En Mantenimiento'),
('Nissan', 'Sentra', 2022, 'JKL012', 'Plata', '2024-02-05', 'Disponible'),
('Mazda', '3', 2021, 'MNO345', 'Verde', '2024-02-10', 'Disponible'),
('Kia', 'Forte', 2020, 'PQR678', 'Gris', '2024-02-12', 'En Mantenimiento'),
('Hyundai', 'Elantra', 2022, 'STU901', 'Rojo', '2024-02-15', 'Disponible'),
('BMW', '320i', 2021, 'VWX234', 'Azul', '2024-02-18', 'En Alquiler'),
('Audi', 'A4', 2023, 'YZA567', 'Negro', '2024-02-20', 'Disponible'),
('Mercedes-Benz', 'C-Class', 2020, 'BCD890', 'Blanco', '2024-02-22', 'En Alquiler'),
('Volkswagen', 'Golf', 2022, 'EFG123', 'Plata', '2024-02-25', 'Disponible'),
('Porsche', 'Cayenne', 2023, 'HIJ456', 'Amarillo', '2024-03-01', 'En Mantenimiento'),
('Toyota', 'Yaris', 2021, 'KLM789', 'Rojo', '2024-03-05', 'Disponible'),
('Honda', 'HR-V', 2022, 'NOP012', 'Verde', '2024-03-08', 'En Alquiler'),
('Chevrolet', 'Equinox', 2020, 'QRS345', 'Azul', '2024-03-10', 'Disponible'),
('Nissan', 'Altima', 2023, 'TUV678', 'Gris', '2024-03-12', 'Disponible'),
('Mazda', 'CX-5', 2022, 'WXY901', 'Blanco', '2024-03-15', 'En Alquiler'),
('Kia', 'Sportage', 2021, 'ZAB234', 'Negro', '2024-03-18', 'Disponible');



-- Insertar datos en la tabla Alquiler
INSERT INTO Alquiler (Fecha_Inicio, Fecha_Fin) VALUES
('2024-03-01 09:00:00', '2024-03-10 17:30:00'),
('2024-03-05 10:15:00', '2024-03-15 16:45:00'),
('2024-03-10 08:30:00', '2024-03-20 18:00:00'),
('2024-03-12 11:00:00', '2024-03-22 19:15:00'),
('2024-03-14 09:45:00', '2024-03-24 17:00:00'),
('2024-03-18 08:00:00', '2024-03-28 16:00:00'),
('2024-03-20 12:00:00', '2024-03-30 20:00:00'),
('2024-03-22 10:30:00', '2024-04-01 18:30:00'),
('2024-03-25 09:00:00', '2024-04-04 15:00:00'),
('2024-03-28 08:45:00', '2024-04-07 19:00:00'),
('2024-03-30 13:00:00', '2024-04-09 17:45:00'),
('2024-04-02 10:00:00', '2024-04-12 18:30:00'),
('2024-04-05 09:30:00', '2024-04-15 19:15:00'),
('2024-04-08 11:15:00', '2024-04-18 16:30:00'),
('2024-04-10 08:00:00', '2024-04-20 20:00:00'),
('2024-04-12 10:45:00', '2024-04-22 17:00:00'),
('2024-04-15 09:00:00', '2024-04-25 18:45:00'),
('2024-04-18 12:30:00', '2024-04-28 19:30:00'),
('2024-04-20 10:00:00', '2024-04-30 16:00:00');


-- Insertar datos en la tabla Detalle_Alquiler
INSERT INTO Detalle_Alquiler (Id_Alquiler, Id_Cliente, Id_Coche, Precio_Total) VALUES
(1, 1, 1, 500.00),
(2, 2, 2, 600.00),
(3, 3, 3, 450.00),
(4, 4, 4, 700.00),
(5, 5, 5, 550.00),
(6, 6, 6, 650.00),
(7, 7, 7, 480.00),
(8, 8, 8, 530.00),
(9, 9, 9, 490.00),
(10, 10, 10, 720.00),
(11, 11, 11, 570.00),
(12, 12, 12, 510.00),
(13, 13, 13, 690.00),
(14, 14, 14, 500.00),
(15, 15, 15, 560.00),
(16, 16,16, 730.00),
(17, 17, 17, 520.00),
(18, 18, 18, 540.00),
(19, 19, 19, 710.00);

-- Insertar datos en la tabla Mantenimiento
INSERT INTO Mantenimiento (Descripcion, Justificacion, Fecha_Inicio, Fecha_Fin, Costo) VALUES
('Cambio de aceite y filtros', 'Mantenimiento preventivo', '2024-02-20 08:00:00', '2024-02-21 10:00:00', 50.00),
('Cambio de frenos', 'Mantenimiento preventivo', '2024-03-01 09:00:00', '2024-03-02 11:00:00', 75.00),
('Reemplazo de batería', 'Mantenimiento correctivo', '2024-03-10 14:00:00', '2024-03-10 16:00:00', 120.00),
('Revisión de sistema eléctrico', 'Inspección general', '2024-03-15 10:00:00', '2024-03-15 13:00:00', 80.00),
('Cambio de llantas', 'Mantenimiento preventivo', '2024-03-20 08:00:00', '2024-03-20 12:00:00', 200.00),
('Reemplazo de pastillas de freno', 'Mantenimiento preventivo', '2024-04-01 09:00:00', '2024-04-01 11:00:00', 65.00),
('Cambio de filtros de aire', 'Mantenimiento preventivo', '2024-04-05 07:00:00', '2024-04-05 09:00:00', 40.00),
('Inspección de frenos', 'Inspección de seguridad', '2024-04-10 10:00:00', '2024-04-10 12:00:00', 50.00),
('Revisión de suspensión', 'Inspección general', '2024-04-15 08:00:00', '2024-04-15 11:00:00', 90.00),
('Reemplazo de correa de distribución', 'Mantenimiento preventivo', '2024-04-20 09:00:00', '2024-04-20 14:00:00', 150.00),
('Reemplazo de bomba de agua', 'Mantenimiento correctivo', '2024-04-25 13:00:00', '2024-04-25 16:00:00', 200.00),
('Cambio de aceite de transmisión', 'Mantenimiento preventivo', '2024-05-01 08:00:00', '2024-05-01 10:00:00', 100.00),
('Reemplazo de bujías', 'Mantenimiento preventivo', '2024-05-05 09:00:00', '2024-05-05 11:00:00', 55.00),
('Revisión de sistema de climatización', 'Inspección general', '2024-05-10 10:00:00', '2024-05-10 12:00:00', 60.00),
('Cambio de aceite de motor', 'Mantenimiento preventivo', '2024-05-15 08:00:00', '2024-05-15 10:00:00', 45.00),
('Ajuste de frenos', 'Mantenimiento preventivo', '2024-06-01 11:00:00', '2024-06-01 13:00:00', 50.00),
('Cambio de embrague', 'Mantenimiento correctivo', '2024-06-10 09:00:00', '2024-06-10 15:00:00', 250.00),
('Reemplazo de alternador', 'Mantenimiento correctivo', '2024-06-15 08:00:00', '2024-06-15 12:00:00', 180.00),
('Revisión de sistema de dirección', 'Inspección general', '2024-06-20 10:00:00', '2024-06-20 13:00:00', 75.00),
('Reemplazo de faros', 'Mantenimiento correctivo', '2025-02-25 14:00:00', '2025-03-25 16:00:00', 40.00);

    
-- Insertar datos en la tabla Detalle_Mantenimiento
INSERT INTO Detalle_Mantenimiento (Id_Mantenimiento, Id_Empleado, Id_Coche, Observaciones, Recomendaciones, Partes_Cambiadas) VALUES
(1, 1, 1, 'El aceite estaba muy sucio', 'Realizar mantenimiento cada 3 meses', 'Aceite, Filtro de aceite'),
(2, 1, 2, 'Pastillas de freno desgastadas', 'Revisar frenos cada 6 meses', 'Pastillas de freno, Líquido de frenos'),
(3, 2, 3, 'Neumáticos con desgaste irregular', 'Balancear ruedas cada 6 meses', 'Neumáticos, Alineación de ruedas'),
(4, 2, 4, 'Frenos con ruido', 'Verificar frenos cada 4 meses', 'Pastillas de freno, Discos de freno'),
(5, 2, 5, 'Filtro de aire obstruido', 'Cambiar filtro de aire cada 12 meses', 'Filtro de aire'),
(6, 1, 6, 'Batería débil', 'Revisar batería cada 8 meses', 'Batería'),
(7, 2, 7, 'Fugas de aceite en el motor', 'Revisar sistema de sellos cada 6 meses', 'Juntas, Aceite del motor'),
(8, 1, 8, 'Luces traseras fundidas', 'Reemplazar luces cada 6 meses', 'Luces traseras'),
(9, 2, 9, 'Suspensión ruidosa', 'Revisar suspensión cada 6 meses', 'Amortiguadores, Muelles'),
(10, 2, 10, 'Aire acondicionado no enfría', 'Revisar sistema de refrigeración cada año', 'Filtro de aire acondicionado, Gas refrigerante'),
(11, 1, 11, 'Ruidos al frenar', 'Revisar frenos cada 3 meses', 'Pastillas de freno, Líquido de frenos'),
(12, 2, 12, 'Fugas de refrigerante', 'Revisar sistema de refrigeración cada 6 meses', 'Mangueras, Radiador'),
(13, 1, 13, 'Bujías sucias', 'Reemplazar bujías cada 12 meses', 'Bujías'),
(14, 2, 14, 'Aceite de motor sucio', 'Realizar cambio de aceite cada 5,000 km', 'Aceite, Filtro de aceite'),
(15, 1, 15, 'Sistema de dirección flojo', 'Revisar sistema de dirección cada 6 meses', 'Líquido de dirección, Bujes'),
(16, 2, 16, 'Frenos desajustados', 'Ajustar frenos cada 6 meses', 'Pastillas de freno, Discos de freno'),
(17, 1, 17, 'Neumáticos con baja presión', 'Revisar presión de neumáticos cada mes', 'Neumáticos'),
(18, 1, 18, 'Frenos chillando', 'Reemplazar pastillas de freno cada 6 meses', 'Pastillas de freno'),
(19, 2, 19, 'Motor con vibraciones', 'Revisar motor cada 12 meses', 'Motor, Suspensión'),
(10, 2, 15, 'Excesivo consumo de combustible', 'Revisar sistema de inyección cada 6 meses', 'Inyectores, Filtro de combustible');

-- ----------------------------------------------------------------------------------

-- Visualizar

-- Cliente
SELECT * FROM Cliente;

-- Empleado
SELECT * FROM Empleado;

-- Coche
SELECT * FROM Coche;

-- Alquiler
SELECT * FROM Alquiler;

-- Detalle_Alquiler
SELECT * FROM Detalle_Alquiler;

-- Mantenimiento
SELECT * FROM Mantenimiento;

-- Detalle_Mantenimiento
SELECT * FROM Detalle_Mantenimiento;

-- -------------------------------------------------------------------------------------

-- Editar

-- Cliente
UPDATE Cliente 
SET Nombre1 = 'NuevoNombre', Apellido2 = 'NuevoApellido' 
WHERE Id_Cliente = 1;

-- Empleado
UPDATE Empleado 
SET Email = 'IngenieroDetuCorazon@gmail.com', Direccion = 'Nueva Dirección' 
WHERE Id_Empleado = 1;

-- Coche
UPDATE Coche 
SET Estado = 'En Mantenimiento', Color = 'Azul Oscuro' 
WHERE Id_Coche = 1;

-- Alquiler
UPDATE Alquiler 
SET Fecha_Fin = '2024-04-15' 
WHERE Id_Alquiler = 1;

-- Detalle_Alquiler
UPDATE Detalle_Alquiler 
SET Precio_Total = 750.00 
WHERE Id_Detalle_Alquiler = 1;

-- Mantenimiento
UPDATE Mantenimiento 
SET Costo = 120.00, Justificacion = 'Cambio preventivo de aceite' 
WHERE Id_Mantenimiento = 1;

-- Detalle_Mantenimiento
UPDATE Detalle_Mantenimiento 
SET Observaciones = 'Revisado sin novedades' 
WHERE Id_Detalle_Mantenimiento = 1;

-- --------------------------------------------------------------------------------

-- Eliminar

-- Cliente
DELETE FROM Cliente 
WHERE Id_Cliente = 1;

-- Empleado
DELETE FROM Empleado 
WHERE Id_Empleado = 1;

-- Coche
DELETE FROM Coche 
WHERE Id_Coche = 1;

-- Alquiler
DELETE FROM Alquiler 
WHERE Id_Alquiler = 1;

-- Detalle_Alquiler
DELETE FROM Detalle_Alquiler 
WHERE Id_Detalle_Alquiler = 1;

-- Mantenimiento
DELETE FROM Mantenimiento 
WHERE Id_Mantenimiento = 1;

-- Detalle_Mantenimiento
DELETE FROM Detalle_Mantenimiento 
WHERE Id_Detalle_Mantenimiento = 1;

-- ----------------------------------------------------------------------------------

-- Reporte de alquileres 
SELECT 
    a.Id_Alquiler, 
    a.Fecha_Inicio, 
    a.Fecha_Fin, 
    c.Nombre1 AS Cliente_Nombre1,
    c.Apellido AS Cliente_Apellido1,
    co.Marca AS Coche_Marca,
    co.Modelo AS Coche_Modelo,
    co.Placa AS Coche_Placa,
    d.Precio_Total
FROM Alquiler a
JOIN Detalle_Alquiler d ON a.Id_Alquiler = d.Id_Alquiler
JOIN Cliente c ON d.Id_Cliente = c.Id_Cliente
JOIN Coche co ON d.Id_Coche = co.Id_Coche;



-- Reporte de mantenimiento 
SELECT 
    m.Id_Mantenimiento, 
    m.Descripcion, 
    m.Fecha_Inicio, 
    m.Fecha_Fin, 
    d.Observaciones, 
    d.Recomendaciones, 
    d.Partes_Cambiadas, 
    e.Nombre1,
    e.Apellido1, 
    co.Marca AS Coche_Marca, 
    co.Modelo AS Coche_Modelo
FROM Mantenimiento m
LEFT JOIN Detalle_Mantenimiento d ON m.Id_Mantenimiento = d.Id_Mantenimiento
LEFT JOIN Empleado e ON d.Id_Empleado = e.Id_Empleado
LEFT JOIN Coche co ON d.Id_Coche = co.Id_Coche;
    
    
-- Numeros de mantenimiento de un empleado
SELECT 
    E.Nombre1,
    E.Apellido1,
    COUNT(DM.Id_Coche) AS Total_Coches_Reparados
FROM Detalle_Mantenimiento DM
JOIN Empleado E ON DM.Id_Empleado = E.Id_Empleado
GROUP BY E.Id_Empleado
ORDER BY Total_Coches_Reparados DESC
LIMIT 1;

-- ----------------------------------------------------------------------------------

-- vistas de Empleados
CREATE VIEW Vista_Empleado_Mayor_Reparador AS
SELECT 
    E.Id_Empleado,
    E.Nombre1,
    E.Apellido1,
    COUNT(DM.Id_Coche) AS Total_Coches_Reparados
FROM Detalle_Mantenimiento DM
JOIN Empleado E ON DM.Id_Empleado = E.Id_Empleado
GROUP BY E.Id_Empleado
ORDER BY Total_Coches_Reparados DESC
LIMIT 1;

SELECT * FROM Vista_Empleado_Mayor_Reparador;

-- vista de estado de coches
CREATE VIEW Vista_Vehiculos_Estado AS
SELECT 
    co.Id_Coche,
    co.Marca,
    co.Modelo,
    co.Anio,
    co.Placa,
    co.Color,
    co.Fecha_Registro,
    co.Estado
FROM 
    Coche co;

select * from Vista_Vehiculos_Estado;


-- Vista Cliente
CREATE VIEW Vista_Cliente AS
SELECT 
    Id_Cliente,
    Nombre1,
    Apellido1,
    Cedula,
    Telefono,
    Email,
    Direccion
FROM Cliente;

select * from Vista_Cliente;

-- Vista Alquiler
CREATE VIEW Vista_Alquiler AS
SELECT 
    A.Id_Alquiler,
    A.Fecha_Inicio,
    A.Fecha_Fin
FROM Alquiler A;

SELECT * FROM Vista_Alquiler;


-- Vista Detalle Alquiler
CREATE VIEW Vista_Detalle_Alquiler AS
SELECT 
    DA.Id_Detalle_Alquiler,
    DA.Id_Alquiler,
    DA.Id_Coche,
    C.Marca AS Marca_Coche,
    C.Modelo AS Modelo_Coche,
    DA.Precio_Total
FROM Detalle_Alquiler DA
JOIN Coche C ON DA.Id_Coche = C.Id_Coche;

SELECT * FROM Vista_Detalle_Alquiler;


-- Vista Mantenimiento
CREATE VIEW Vista_Mantenimiento AS
SELECT 
    M.Id_Mantenimiento,
    M.Costo,
    M.Justificacion,
    M.Descripcion,
    M.Fecha_Inicio,
    M.Fecha_Fin
FROM Mantenimiento M;

SELECT * FROM Vista_Mantenimiento;

-- Vista Detalle Mantenimiento
CREATE VIEW Vista_Detalle_Mantenimiento AS
SELECT 
    DM.Id_Detalle_Mantenimiento,
    DM.Id_Mantenimiento,
    DM.Id_Empleado,
    DM.Id_Coche,
    C.Marca,
    C.Modelo,
    C.Placa,
    DM.Observaciones,
    DM.Recomendaciones,
    DM.Partes_Cambiadas,
    M.Costo
FROM Detalle_Mantenimiento DM
JOIN Mantenimiento M ON DM.Id_Mantenimiento = M.Id_Mantenimiento
JOIN Coche C ON DM.Id_Coche = C.Id_Coche;

SELECT * FROM Vista_Detalle_Mantenimiento;

 -- Vista de todos los coches
CREATE VIEW Coches_vista AS
SELECT Modelo, Marca, Estado
FROM Coche
WHERE Id_Coche; 

-- Vista de coches disponibles
CREATE VIEW vista_coches_disponibles AS
SELECT 
    c.Id_Coche,
    c.Marca,
    c.Modelo,
    c.Anio,
    c.Placa,
    c.Color,
    c.Fecha_Registro,
    c.Estado
FROM 
    Coche c
WHERE 
    c.Estado = 'Disponible';
    
    
    -- Vista de alquileres más altos en ventas, es decir cuales son las más altas y bajas
CREATE VIEW vista_alquileres_extremos AS
SELECT 
    da.Id_Detalle_Alquiler,
    da.Id_Alquiler,
    da.Id_Coche,
    da.Id_Cliente,
    Co.Marca,
    Co.Modelo,
    Co.Placa,
    Al.Fecha_Inicio,
    Al.Fecha_Fin,
    MAX(da.Precio_Total) as "Más alto",
    MIN(da.Precio_Total) as "Más Bajo"
FROM 
    Detalle_Alquiler da
JOIN Alquiler Al ON da.Id_Detalle_Alquiler = Al.Id_Alquiler
JOIN Coche Co ON da.Id_Detalle_Alquiler = Co.Id_Coche
GROUP BY da.Id_Detalle_Alquiler;

    


    
    -- Vista de coches con más tiempo alquilados
CREATE VIEW Vista_Coches_Mas_Tiempo_Alquilados AS
SELECT 
    Coche.Id_Coche,
    Coche.Marca,
    Coche.Modelo,
    Coche.Placa,
    SUM(DATEDIFF(Alquiler.Fecha_Fin, Alquiler.Fecha_Inicio)) AS Total_Dias_Alquilado
FROM 
    Detalle_Alquiler
JOIN 
    Coche ON Detalle_Alquiler.Id_Coche = Coche.Id_Coche
JOIN 
    Alquiler ON Detalle_Alquiler.Id_Alquiler = Alquiler.Id_Alquiler
GROUP BY 
    Coche.Id_Coche, Coche.Marca, Coche.Modelo, Coche.Placa
ORDER BY 
    Total_Dias_Alquilado DESC;

-- Vista de clientes más frecuentes
CREATE VIEW Clientes_Mas_Frecuentes AS
SELECT 
    c.Id_Cliente,
    c.Nombre1,
    c.Apellido1,
    COUNT(*) AS Veces_Alquilado
FROM 
    Detalle_Alquiler da
JOIN 
    Cliente c ON da.Id_Cliente = c.Id_Cliente
GROUP BY 
    c.Id_Cliente, c.Nombre1, c.Apellido1
ORDER BY 
    Veces_Alquilado DESC;

-- Vista de coche actualmente en mantenimiento
CREATE VIEW Coches_En_Mantenimiento AS
SELECT 
    c.Id_Coche,
    c.Marca,
    c.Modelo,
    c.Placa,
    m.Fecha_Inicio,
    m.Fecha_Fin
FROM 
    Detalle_Mantenimiento dm
JOIN 
    Coche c ON dm.Id_Coche = c.Id_Coche
JOIN 
    Mantenimiento m ON dm.Id_Mantenimiento = m.Id_Mantenimiento
WHERE 
    c.Estado = "En Mantenimiento"



-- -----------------------------------------------------------------------------------
-- procedimiento almacenado

-- Insertar nuevo cliente
DELIMITER //

CREATE PROCEDURE InsertarClienteSimple (
    IN cedula VARCHAR(16),
    IN nombre1 VARCHAR(50),
    IN nombre2 VARCHAR(50),
    IN apellido1 VARCHAR(50),
    IN apellido2 VARCHAR(50),
    IN telefono VARCHAR(8),
    IN direccion TEXT,
    IN email VARCHAR(100),
    IN licencia VARCHAR(8)
)
BEGIN
    INSERT INTO Cliente (
        Cedula, Nombre1, Nombre2, Apellido1, Apellido2, Telefono, Direccion, Email, Licencia
    )
    VALUES (
        cedula, nombre1, nombre2, apellido1, apellido2, telefono, direccion, email, licencia
    );
END;

//

DELIMITER ;

CALL InsertarClienteSimple(
    '123456789',
    'Ana',
    'Lucía',
    'Ramírez',
    'Torres',
    '88887777',
    'Heredia, Costa Rica',
    'ana.lucia@email.com',
    'L123456'
);

-- ---------------------------------------------------
-- Actualizar estado de coche a “mantenimiento”
DELIMITER //

CREATE PROCEDURE ActualizarEstadoCoche (
    IN id_coche INT
)
BEGIN
    UPDATE Coche
    SET Estado = 'En Mantenimiento'
    WHERE Id_Coche = id_coche;
END;
//

DELIMITER ;

CALL ActualizarEstadoCoche(3);

-- --------------------------------------------------------
-- Actualizar estado de coche a “Disponible” 
DELIMITER //

CREATE PROCEDURE ActualizarCocheDisponible (
    IN id_coche INT
)
BEGIN
    UPDATE Coche
    SET Estado = 'Disponible'
    WHERE Id_Coche = id_coche;
END;
//

DELIMITER ;

CALL ActualizarCocheDisponible(5);

-- -------------------------------------------------
-- Alquileres activos hoy
CREATE VIEW Alquileres_Activos_Hoy AS
SELECT 
    a.Id_Alquiler,
    da.Id_Cliente,
    concat(Cl.Nombre1, " ", Cl.Nombre2, " ", Cl.Apellido1, " ", Cl.Apellido2) AS Nombre,
    da.Id_Coche,
    Co.Marca,
    Co.Modelo,
    Co.Placa,
    a.Fecha_Inicio,
    a.Fecha_Fin
FROM 
    Alquiler a
JOIN 
    Detalle_Alquiler da ON a.Id_Alquiler = da.Id_Alquiler
JOIN 
    Cliente Cl ON a.Id_Alquiler = Cl.Id_Cliente
JOIN 
    Coche Co ON a.Id_Alquiler = Co.Id_Coche
WHERE 
    CURDATE() BETWEEN DATETIME(a.Fecha_Inicio) AND DATE(a.Fecha_Fin);

SELECT * FROM Alquileres_Activos_Hoy;

-- -------------------------------------------------------------
-- Actualizar estado de coche a “Alquilado”
DELIMITER //

CREATE PROCEDURE ActualizarEstadoCocheAlquilado (
    IN id_coche INT
)
BEGIN
    UPDATE Coche
    SET Estado = "En Alquiler"
    WHERE Id_Coche = id_coche;
END;
//

DELIMITER ;

CALL ActualizarEstadoCocheAlquilado(7);

-- -----------------------------------------------------------------

-- Insertar Cliente
DELIMITER //
CREATE PROCEDURE InsertarCliente (
    IN p_Cedula VARCHAR(16),
    IN p_Nombre1 VARCHAR(50),
    IN p_Apellido1 VARCHAR(50),
    IN p_Telefono VARCHAR(8),
    IN p_Direccion TEXT,
    IN p_Email VARCHAR(100),
    IN p_Licencia VARCHAR(8)
)
BEGIN
    INSERT INTO Cliente (Cedula, Nombre1, Apellido1, Telefono, Direccion, Email, Licencia)
    VALUES (p_Cedula, p_Nombre1, p_Apellido1, p_Telefono, p_Direccion, p_Email, p_Licencia);
END;
//
DELIMITER ;

-- Llamar
CALL InsertarCliente('001-100000-0001A', 'Juan', 'Pérez', '88889999', 'Managua', 'juan@example.com', 'LIC1234');

-- ---------------------------------------------------------------------------
-- Insertar Empleado
DELIMITER //
CREATE PROCEDURE InsertarEmpleado (
    IN p_Cedula VARCHAR(16),
    IN p_Nombre1 VARCHAR(50),
    IN p_Apellido1 VARCHAR(50),
    IN p_Direccion VARCHAR(150),
    IN p_Email VARCHAR(150)
)
BEGIN
    INSERT INTO Empleado (Cedula, Nombre, Apellido, Direccion, Email)
    VALUES (p_Cedula, p_Nombre, p_Apellido, p_Direccion, p_Email);
END;
//
DELIMITER ;

-- ----------------------------------------------------------------------------
-- Llamar
CALL InsertarEmpleado('002-200000-0002B', 'Ana', 'López', 'León', 'ana@example.com');

-- Insertar coche
DELIMITER //
CREATE PROCEDURE InsertarCoche (
    IN p_Marca VARCHAR(50),
    IN p_Modelo VARCHAR(50),
    IN p_Anio INT,
    IN p_Placa VARCHAR(150),
    IN p_Color VARCHAR(150),
    IN p_Fecha_Registro DATE,
    IN p_Estado VARCHAR(50)
)
BEGIN
    INSERT INTO Coche (Marca, Modelo, Anio, Placa, Color, Fecha_Registro, Estado)
    VALUES (p_Marca, p_Modelo, p_Anio, p_Placa, p_Color, p_Fecha_Registro, p_Estado);
END;
//
DELIMITER ;

-- Llamar
CALL InsertarCoche('Toyota', 'Yaris', 2020, 'M12345', 'Rojo', '2024-01-15', 'Disponible');

-- --------------------------------------------------------------------------------------
-- Insertar detalle alquiler
DELIMITER //
CREATE PROCEDURE InsertarDetalleAlquiler(
    IN p_Id_Alquiler INT,
    IN p_Id_Coche INT,
    IN p_Id_Cliente INT,
    IN p_Precio_Total DECIMAL(10,2)
)
BEGIN
    INSERT INTO Detalle_Alquiler(Id_Alquiler, Id_Coche, Id_Cliente, Precio_Total)
    VALUES(p_Id_Alquiler, p_Id_Coche, p_Id_Cliente, p_Precio_Total);
END;
//
DELIMITER ;

CALL InsertarDetalleAlquiler(1, 2, 3, 450.00);

-- ----------------------------------------------------------------------------------------
-- Insertar detalle mantenimiento
DELIMITER //
CREATE PROCEDURE InsertarDetalleMantenimiento(
    IN p_Id_Mantenimiento INT,
    IN p_Id_Empleado INT,
    IN p_Id_Coche INT,
    IN p_Observaciones TEXT
)
BEGIN
    INSERT INTO Detalle_Mantenimiento(Id_Mantenimiento, Id_Empleado, Id_Coche, Observaciones)
    VALUES(p_Id_Mantenimiento, p_Id_Empleado, p_Id_Coche, p_Observaciones);
END;
//
DELIMITER ;

CALL InsertarDetalleMantenimiento(1, 2, 3, 'Cambio de aceite y revisión general');


-- -------------------------------------------------------------------------------------
-- Obtener costo total de mantenimiento por coche
DELIMITER //
CREATE FUNCTION CostoMantenimientoPorCoche(p_IdCoche INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10,2);
    SELECT SUM(M.Costo) INTO total
    FROM Mantenimiento M
    INNER JOIN Detalle_Mantenimiento DM ON M.Id_Mantenimiento = DM.Id_Mantenimiento
    WHERE DM.Id_Coche = p_IdCoche;
    RETURN IFNULL(total, 0.00);
END;
//
DELIMITER ;

-- Llamar
SELECT CostoMantenimientoPorCoche(1);

-- Obtener el total de coches alquilador por cliente
DELIMITER //
CREATE FUNCTION TotalCochesPorCliente(p_Id_Cliente INT) 
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total
    FROM Detalle_Alquiler
    WHERE Id_Cliente = p_Id_Cliente;
    RETURN total;
END;
//
DELIMITER ;

SELECT TotalCochesPorCliente(1);


-- Verificar si un coche está disponible (estado = 'Disponible')
DELIMITER //
CREATE FUNCTION CocheDisponible(p_Id_Coche INT)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE disponible BOOLEAN;
    SELECT Estado = 'Disponible' INTO disponible
    FROM Coche
    WHERE Id_Coche = p_Id_Coche;
    RETURN disponible;
END;
//
DELIMITER ;

SELECT CocheDisponible(3);


-- Calcular el número de mantenimientos realizados a un coche
DELIMITER //
CREATE FUNCTION TotalMantenimientosPorCoche(p_Id_Coche INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total
    FROM Detalle_Mantenimiento
    WHERE Id_Coche = p_Id_Coche;
    RETURN total;
END;
//
DELIMITER ;

SELECT TotalMantenimientosPorCoche(3);


