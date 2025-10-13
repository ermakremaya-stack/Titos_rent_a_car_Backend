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

