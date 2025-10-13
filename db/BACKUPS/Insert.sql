
-- Insertar datos en la tabla Usuario
INSERT INTO Usuario (Cedula, Rol, Nombre1, Nombre2, Apellido1, Apellido2, Telefono, Direccion, Email, Licencia) VALUES
('001-010101-0000A', 'Cliente', 'Juan', 'Miguel', 'Perez', 'Sanchez', '12345678', 'Calle Falsa 123', 'juan.perez@email.com', 'LIC-001'),
('002-020202-0000B', 'Cliente', 'Maria', 'Lopez', 'Lopez', 'Garcia', '87654321', 'Avenida Central 456', 'maria.lopez@email.com', 'LIC-B2'),
('003-030303-0000C', 'Cliente', 'Carlos', 'Antonio', 'Gomez', 'Rodriguez', '11223344', 'Calle Luna 789', 'carlos.gomez@email.com', 'LIC-003'),
('004-040404-0000D', 'Cliente', 'Ana', 'Maria', 'Martinez', 'Pereira', '55667788', 'Calle Sol 101', 'ana.martinez@email.com', 'LIC-A1'),
('005-050505-0000E', 'Cliente', 'Luis', 'Fernando', 'Diaz', 'Gonzalez', '22334455', 'Avenida Libertad 234', 'luis.diaz@email.com', 'LIC-B2'),
('006-060606-0000F', 'Cliente', 'Patricia', 'Luisa', 'Fernandez', 'Castillo', '33445566', 'Calle 9 de Julio 567', 'patricia.fernandez@email.com', 'LIC-001'),
('007-070707-0000G', 'Cliente', 'Miguel', 'Angel', 'Hernandez', 'Moreno', '44556677', 'Calle de la Paz 890', 'miguel.hernandez@email.com', 'LIC-C3'),
('008-080808-0000H', 'Cliente', 'Elena', 'Maria', 'Garcia', 'Ruiz', '55667788', 'Avenida de Mayo 321', 'elena.garcia@email.com', 'LIC-A1'),
('009-090909-0000I', 'Cliente', 'Juan', 'Carlos', 'Sanchez', 'Perez', '66778899', 'Calle 12 de Octubre 654', 'juan.sanchez@email.com', 'LIC-B2'),
('010-101010-0000J', 'Cliente', 'Ricardo', 'David', 'Ruiz', 'Lopez', '77889900', 'Avenida Argentina 432', 'ricardo.ruiz@email.com', 'LIC-B1'),
('011-111111-0000K', 'Empleado', 'Carmen', 'Elena', 'Morales', 'Hernandez', '88990011', 'Calle Independencia 765', 'carmen.morales@email.com', 'LIC-C3'),
('012-121212-0000L', 'Empleado', 'Sergio', 'Alejandro', 'Torres', 'Santos', '99001122', 'Avenida del Sol 876', 'sergio.torres@email.com', 'LIC-001'),
('013-131313-0000M', 'Empleado', 'Rosa', 'Beatriz', 'Jimenez', 'Diaz', '10111213', 'Calle de los Pinos 987', 'rosa.jimenez@email.com', 'LIC-A2'),
('014-141414-0000N', 'Empleado', 'Eduardo', 'Alfonso', 'Vazquez', 'Rivera', '21222324', 'Calle Mistral 100', 'eduardo.vazquez@email.com', 'LIC-B1'),
('015-151515-0000O', 'Empleado', 'Gabriela', 'Fernanda', 'Ruiz', 'Martinez', '32333435', 'Avenida Costa Rica 234', 'gabriela.ruiz@email.com', 'LIC-C2'),
('016-161616-0000P', 'Administrador', 'Felipe', 'Antonio', 'Serrano', 'Jimenez', '43444546', 'Calle Mirador 432', 'felipe.serrano@email.com', 'LIC-B2'),
('017-171717-0000Q', 'Administrador', 'Carla', 'Lucia', 'Castro', 'Fernandez', '54565768', 'Avenida Universitaria 123', 'carla.castro@email.com', 'LIC-A1'),
('018-181818-0000R', 'Administrador', 'David', 'Manuel', 'Mendez', 'Morales', '65676879', 'Calle Las Palmas 876', 'david.mendez@email.com', 'LIC-B1'),
('019-191919-0000S', 'Administrador', 'Laura', 'Patricia', 'Salazar', 'Lopez', '76787980', 'Avenida San Martin 345', 'laura.salazar@email.com', 'LIC-C3'),
('020-202020-0000T', 'Administrador', 'Antonio', 'Carlos', 'Gonzalez', 'Vazquez', '87898091', 'Calle del Bosque 654', 'antonio.gonzalez@email.com', 'LIC-003');




-- Insertar datos en la tabla Empleados
INSERT INTO Empleado (Cedula, Nombre1, Nombre2, Apellido1, Apellido2, Direccion, Email) VALUES
('011-111111-0000K', 'Carmen', 'Elena', 'Morales', 'Hernandez', 'Calle Independencia 765', 'carmen.morales@email.com'),
('012-121212-0000L', 'Sergio', 'Alejandro', 'Torres', 'Santos', 'Avenida del Sol 876', 'sergio.torres@email.com'),
('013-131313-0000M', 'Rosa', 'Beatriz', 'Jimenez', 'Diaz', 'Calle de los Pinos 987', 'rosa.jimenez@email.com'),
('014-141414-0000N', 'Eduardo', 'Alfonso', 'Vazquez', 'Rivera', 'Calle Mistral 100', 'eduardo.vazquez@email.com'),
('015-151515-0000O', 'Gabriela', 'Fernanda', 'Ruiz', 'Martinez', 'Avenida Costa Rica 234', 'gabriela.ruiz@email.com');





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
INSERT INTO Detalle_Alquiler (Id_Alquiler, Id_Usuario, Id_Coche, Precio_Total) VALUES
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
