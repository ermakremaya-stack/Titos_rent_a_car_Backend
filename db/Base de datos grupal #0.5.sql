DROP DATABASE IF EXISTS BD_rentacar_G3;
CREATE DATABASE BD_rentacar_G3;
USE BD_rentacar_G3;

-- Tabla Cliente
CREATE TABLE Usuario (
    Id_Usuario INT PRIMARY KEY AUTO_INCREMENT,
    Rol ENUM('Usuario') DEFAULT "Usuario",
    Cedula VARCHAR (16) NOT NULL,
    Nombre1 VARCHAR(50) NOT NULL,
    Nombre2 VARCHAR(50),
    Apellido1 VARCHAR(50) NOT NULL,
    Apellido2 VARCHAR(50),
    Telefono VARCHAR(8) NOT NULL,
    Direccion TEXT NOT NULL,
    Email VARCHAR(100) UNIQUE,
    Licencia VARCHAR (8) NOT NULL,
    Contrasena VARCHAR (255) NOT NULL
);

-- Tabla Empleado
CREATE TABLE Empleado (
    Id_Empleado INT PRIMARY KEY AUTO_INCREMENT,
    Rol ENUM ("Administrador", "Mecánico", "Agente de alquiler"),
    Cedula VARCHAR (16) NOT NULL,
    Nombre1 VARCHAR(50) NOT NULL,
    Nombre2 VARCHAR(50),
    Apellido1 VARCHAR(50) NOT NULL,
    Apellido2 VARCHAR(50),
    Direccion VARCHAR(150) NOT NULL,
    Email VARCHAR(150) UNIQUE,
    Fecha_Contratacion DATE NOT NULL DEFAULT (CURRENT_DATE()),
    Contrasena VARCHAR (250) NOT NULL
);

-- Tabla Coche
CREATE TABLE Coche (
    Id_Coche INT PRIMARY KEY AUTO_INCREMENT,
    Marca VARCHAR(50) NOT NULL,
    Modelo VARCHAR(20) NOT NULL,
    Anio INT NOT NULL,
    Placa VARCHAR (10) NOT NULL UNIQUE,
    Color VARCHAR (50),
    Fecha_Registro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
    Valor_Dia DECIMAL (10,2),
	Estado ENUM('En Alquiler', 'En Mantenimiento', 'Disponible') DEFAULT 'Disponible'
);

-- SHOW CREATE TABLE Coche;
-- Tabla Alquiler

CREATE TABLE Alquiler (
    Id_Alquiler INT PRIMARY KEY AUTO_INCREMENT,
    Fecha_Inicio DATETime NOT NULL,
    Fecha_Fin DATETime NOT NULL,
    Estado ENUM ("En curso", "Cancelado", "En espera", "Finalizado")
);

-- Tabla Detalle_Alquiler
CREATE TABLE Detalle_Alquiler (
    Id_Detalle_Alquiler INT PRIMARY KEY AUTO_INCREMENT,
    Id_Alquiler INT,
    Id_Coche INT,
    Id_Usuario INT,
    Precio_Total DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (Id_Alquiler) REFERENCES Alquiler(Id_Alquiler) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (Id_Coche) REFERENCES Coche(Id_Coche) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (Id_Usuario) REFERENCES Usuario (Id_Usuario) ON DELETE CASCADE ON UPDATE CASCADE
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
    FOREIGN KEY (Id_Mantenimiento) REFERENCES Mantenimiento(Id_Mantenimiento) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (Id_Empleado) REFERENCES Empleado(Id_Empleado) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (Id_Coche) REFERENCES Coche(Id_Coche) ON DELETE CASCADE ON UPDATE CASCADE
);

-- ====================BITACORA================
CREATE TABLE IF NOT EXISTS bitacora_general (
    Id_Bitacora INT AUTO_INCREMENT PRIMARY KEY,
    Tabla_Afectada VARCHAR(50) NOT NULL,
    Tipo_Cambio VARCHAR(20) NOT NULL,
    Usuario VARCHAR(100) NOT NULL,
    Fecha DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);
-- ============================================


-- ==============================FUNSIONES===============================
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
END//

DELIMITER ;

/*
-- Llamar
SELECT CostoMantenimientoPorCoche(1);
*/

/*
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
*/

-- ============================================================================================



-- ==================================PROCEDIMIENTOS ALMACENADOS EMPLEADO=================================

-- ===============================================
-- PROCEDIMIENTO: InsertarEmpleado
-- ===============================================
DELIMITER //

CREATE PROCEDURE InsertarEmpleado (
    IN p_Rol ENUM('Administrador','Mecánico','Agente de alquiler'),
    IN p_Cedula VARCHAR(16),
    IN p_Nombre1 VARCHAR(50),
    IN p_Nombre2 VARCHAR(50),
    IN p_Apellido1 VARCHAR(50),
    IN p_Apellido2 VARCHAR(50),
    IN p_Direccion VARCHAR(100),
    IN p_Email VARCHAR(50),
    IN p_Contrasena VARCHAR (150)
)
BEGIN
    INSERT INTO Empleado (Rol, Cedula, Nombre1, Nombre2, Apellido1, Apellido2, Direccion,  Email, Contrasena)
    VALUES (p_Rol, p_Cedula, p_Nombre1, p_Nombre2, p_Apellido1, p_Apellido2, p_Direccion, p_Email, p_Contrasena);
END //

DELIMITER ;


-- ===============================================
-- PROCEDIMIENTO: ActualizarEmpleado
-- ===============================================
DELIMITER //

CREATE PROCEDURE ActualizarEmpleado (
    IN p_Id_Empleado INT,
    IN p_Rol ENUM('Administrador','Mecánico','Agente de alquiler'),
    IN p_Cedula VARCHAR(16),
    IN p_Nombre1 VARCHAR(50),
    IN p_Nombre2 VARCHAR(50),
    IN p_Apellido1 VARCHAR(50),
    IN p_Apellido2 VARCHAR(50),
    IN p_Direccion VARCHAR(100),
    IN p_Email VARCHAR(50),
    IN p_Contrasena VARCHAR (150)
    
)
BEGIN
    UPDATE Empleado
    SET 
		Rol = p_Rol,
        Cedula = p_Cedula,
        Nombre1 = p_Nombre1,
        Nombre2 = p_Nombre2,
        Apellido1 = p_Apellido1,
        Apellido2 = p_Apellido2,
        Direccion = p_Direccion,
        Email = p_Email,
        Contrasena = p_Contrasena
    WHERE Id_Empleado = p_Id_Empleado;
END //

DELIMITER ;

-- ===============================================
-- PROCEDIMIENTO: EliminarEmpleado
-- ===============================================
DELIMITER //

CREATE PROCEDURE EliminarEmpleado (
    IN p_Id_Empleado INT
)
BEGIN
    DELETE FROM Empleado
    WHERE Id_Empleado = p_Id_Empleado;
END //

DELIMITER ;


-- ==================================PROCEDIMIENTOS ALMACENADOS COCHES=================================

-- CREAR PROCEDIMIENTOS DE CRUD COCHE
DELIMITER //

CREATE PROCEDURE InsertarCoche (
    IN p_Marca VARCHAR(50),
    IN p_Modelo VARCHAR(20),
    IN p_Anio INT,
    IN p_Placa VARCHAR(10),
    IN p_Color VARCHAR(50),
    IN p_Valor_Dia DECIMAL(10,2)
)
BEGIN
    INSERT INTO Coche (Marca, Modelo, Anio, Placa, Color, Valor_Dia)
    VALUES (p_Marca, p_Modelo, p_Anio, p_Placa, p_Color, p_Valor_Dia);
END //

DELIMITER ;




DELIMITER //

CREATE PROCEDURE ActualizarCoche(
	IN p_Id_Coche INT, 
	IN p_Marca VARCHAR (50),
    IN p_Modelo VARCHAR (20),
    IN p_Anio INT,
	IN p_Placa VARCHAR (10),
    IN p_Color VARCHAR (50),
    IN p_Valor_Dia DECIMAL(10,2)
)
BEGIN
    UPDATE Coche
    SET 
        Marca = p_Marca,
        Modelo = p_Modelo,
        Anio = p_Anio,
        Placa = p_Placa,
        Color = p_Color,
        Valor_Dia = p_Valor_Dia
    WHERE Id_Coche = p_Id_Coche;
END //

DELIMITER ;


/*

drop trigger trg_evitar_placa_duplicada_update;
*/
DELIMITER //

CREATE PROCEDURE EliminarCoche (
    IN p_Id_Coche INT  -- Placa del coche que vamos a eliminar
)
BEGIN
    DELETE FROM Coche
    WHERE Id_Coche = p_Id_Coche;  -- Se elimina el coche basado en la placa
END //

DELIMITER ;


-- ==================================PROCEDIMIENTOS ALMACENADOS USUARIO=================================

DELIMITER //

CREATE PROCEDURE InsertarUsuario (
    IN p_Cedula VARCHAR(16),
    IN p_Nombre1 VARCHAR(50),
    IN p_Nombre2 VARCHAR(50),
    IN p_Apellido1 VARCHAR(50),
    IN p_Apellido2 VARCHAR(50),
    IN p_Telefono VARCHAR(8),
    IN p_Direccion TEXT,
    IN p_Email VARCHAR(100),
    IN p_Licencia VARCHAR(8),
    IN p_Contrasena VARCHAR(20)
)
BEGIN
    INSERT INTO Usuario (
        ROL, Cedula, Nombre1, Nombre2, Apellido1, Apellido2, Telefono, Direccion, Email, Licencia, Contrasena
    ) VALUES (
        'Usuario', p_Cedula, p_Nombre1, p_Nombre2, p_Apellido1, p_Apellido2, p_Telefono, p_Direccion, p_Email, p_Licencia, p_Contrasena
    );
END //

DELIMITER ;


-- Actualizar
DELIMITER //

CREATE PROCEDURE ActualizarUsuario (
    IN p_Id_Usuario INT,
    IN p_Cedula VARCHAR(16),
    IN p_Nombre1 VARCHAR(50),
    IN p_Nombre2 VARCHAR(50),
    IN p_Apellido1 VARCHAR(50),
    IN p_Apellido2 VARCHAR(50),
    IN p_Telefono VARCHAR(8),
    IN p_Direccion TEXT,
    IN p_Email VARCHAR(100),
    IN p_Licencia VARCHAR(8),
    IN p_Contrasena VARCHAR(20)
)
BEGIN
    UPDATE Usuario
    SET 
        Cedula = p_Cedula,
        Nombre1 = p_Nombre1,
        Nombre2 = p_Nombre2,
        Apellido1 = p_Apellido1,
        Apellido2 = p_Apellido2,
        Telefono = p_Telefono,
        Direccion = p_Direccion,
        Email = p_Email,
        Licencia = p_Licencia,
        Contrasena = p_Contrasena
    WHERE Id_Usuario = p_Id_Usuario;
END//

DELIMITER ;


-- ELIMINAR
DELIMITER //
CREATE PROCEDURE EliminarUsuario (
    IN p_Id_Usuario INT
)
BEGIN
    DELETE FROM Usuario
    WHERE Id_Usuario = p_Id_Usuario;
END //

DELIMITER ;


-- ==================================PROCEDIMIENTOS ALMACENADOS MANTENIMIENTO=================================

DELIMITER //
create procedure InsertMantenimientos(
in	m_descripcion TEXT ,
in   m_justificacion TEXT ,
in  m_fecha_Inicio DATETIME ,
in    m_fecha_Fin DATETIME ,
in   m_costo DECIMAL(10,2)
)
begin 
insert into Mantenimiento (Descripcion, Justificacion, Fecha_Inicio, Fecha_Fin, Costo) 
values (m_descripcion, m_justificacion, m_fecha_Inicio, m_fecha_Fin, m_costo); 
end //

DELIMITER ;

-- =============== Actualizar MANTENIMIENTO ===============================
/*
DELIMITER //

create procedure ActualizarMantenimientos (
IN m_Id_Mantenimiento INT
)
begin 
update Mantenimiento
set Descripcion = 'CAmbio de discos y pastillas'
where Id_Mantenimiento = m_Id_Mantenimiento;
end//

DELIMITER ;
*/
-- ============== Eliminar Mantenimiento ===================================
/*
DELIMITER //

CREATE PROCEDURE EliminarMantenimiento (
    IN p_Id_mantenimiento INT
)
BEGIN
    DELETE FROM Mantenimiento
    WHERE Id_Mantenimiento = p_Id_Mantenimiento;
END//

DELIMITER ;
*/
-- ============= insertar detalle mantenimiento ===========================
/*
DELIMITER //

CREATE PROCEDURE InsertDetalleMantenimiento(
    IN m_Id_Mantenimiento INT,
    IN m_Id_Empleado INT,
    IN m_Id_Coche INT,
    IN m_Observaciones TEXT,
    IN m_Recomendaciones TEXT,
    IN m_Partes_Cambiadas TEXT
)
BEGIN
    INSERT INTO Detalle_Mantenimiento (
        Id_Mantenimiento,
        Id_Empleado,
        Id_Coche,
        Observaciones,
        Recomendaciones,
        Partes_Cambiadas
    )
    VALUES (
        m_Id_Mantenimiento,
        m_Id_Empleado,
        m_Id_Coche,
        m_Observaciones,
        m_Recomendaciones,
        m_Partes_Cambiadas
    );
END //

DELIMITER ;
*/
-- ========= actualizar detalles mantenimientos ===========
DELIMITER //

CREATE PROCEDURE ActualizarDetalleMantenimiento (
    IN m_Id_Detalle_Mantenimiento INT
)
BEGIN
    UPDATE Detalle_Mantenimiento
    SET 
        Observaciones = 'Actualización: se revisaron todas las piezas y se realizaron ajustes menores',
        Recomendaciones = 'Revisar nuevamente en 3 meses',
        Partes_Cambiadas = 'Pastillas de freno, aceite y filtro'
    WHERE Id_Detalle_Mantenimiento = m_Id_Detalle_Mantenimiento;
END//

DELIMITER ;


-- ============== eliminar detalle mantenimiento =============
DELIMITER //

CREATE PROCEDURE EliminarDetalleMantenimiento (
    IN m_Id_Detalle_Mantenimiento INT
)
BEGIN
    DELETE FROM Detalle_Mantenimiento
    WHERE Id_Detalle_Mantenimiento = m_Id_Detalle_Mantenimiento;
END //

DELIMITER ;



DELIMITER //

create procedure ActualizarMantenimientos (
IN m_Id_Mantenimiento INT
)
begin 
update Mantenimiento
set Descripcion = 'Cambio de discos y pastillas'
where Id_Mantenimiento = m_Id_Mantenimiento;
end//
DELIMITER ;

-- ============== Eliminar Mantenimiento ===================================
-- ELIMINAR
DELIMITER //
CREATE PROCEDURE EliminarMantenimiento (
    IN p_Id_mantenimiento INT
)
BEGIN
    DELETE FROM Mantenimiento
    WHERE Id_Mantenimiento = p_Id_Mantenimiento;
END //
DELIMITER ;


-- ============= insertar detalle mantenimiento ===========================
DELIMITER //

CREATE PROCEDURE InsertDetalleMantenimiento(
    IN m_Id_Mantenimiento INT,
    IN m_Id_Empleado INT,
    IN m_Id_Coche INT,
    IN m_Observaciones TEXT,
    IN m_Recomendaciones TEXT,
    IN m_Partes_Cambiadas TEXT
)
BEGIN
    INSERT INTO Detalle_Mantenimiento (
        Id_Mantenimiento,
        Id_Empleado,
        Id_Coche,
        Observaciones,
        Recomendaciones,
        Partes_Cambiadas
    )
    VALUES (
        m_Id_Mantenimiento,
        m_Id_Empleado,
        m_Id_Coche,
        m_Observaciones,
        m_Recomendaciones,
        m_Partes_Cambiadas
    );
END //

DELIMITER ;

-- ===============================PROCEDIMIENTOS PARA ALQUILER=================================== --

-- ===============================PROCEDIMIENTO INSERTAR ALQUILER================================ --

DELIMITER //

CREATE PROCEDURE insert_alquiler(
IN a_fecha_inicio DATETime,
IN a_fecha_fin  DATETime
)
BEGIN
INSERT INTO Alquiler (Fecha_Inicio, Fecha_Fin)
VALUES (a_fecha_inicio, a_fecha_fin);

END//

DELIMITER ;


-- ===============================PROCEDIMIENTO ACTUALIZAR ALQUILER================================ --

DELIMITER //
CREATE PROCEDURE Actualizar_Alquiler(
    IN p_Id_Alquiler INT,
    IN p_Fecha_Inicio DATETIME,
    IN p_Fecha_Fin DATETIME
)
BEGIN
    UPDATE Alquiler
    SET Fecha_Inicio = p_Fecha_Inicio,
        Fecha_Fin = p_Fecha_Fin
    WHERE Id_Alquiler = p_Id_Alquiler;
END //

DELIMITER ;


-- ===============================PROCEDIMIENTO ELIMINAR ALQUILER================================ --


DELIMITER //

CREATE PROCEDURE Eliminar_Alquiler(
    IN p_Id_Alquiler INT
)
BEGIN
    DELETE FROM Alquiler
    WHERE Id_Alquiler = p_Id_Alquiler;
END//

DELIMITER ;

-- ================= DETALLE ALQUILER ===================== --

DELIMITER //
CREATE PROCEDURE Insertar_Detalle_Alquiler (
    IN p_Id_Alquiler INT,
    IN p_Id_Coche INT,
    IN p_Id_Usuario INT,
    IN p_Precio_Total DECIMAL(10,2)
)
BEGIN
    INSERT INTO Detalle_Alquiler (Id_Alquiler, Id_Coche, Id_Usuario, Precio_Total)
    VALUES (p_Id_Alquiler, p_Id_Coche, p_Id_Usuario, p_Precio_Total);
END//

DELIMITER ;


-- ==========================PROCEDIMIENTO PARA Actualizar_Detalle_Alquiler============================= -- 

DELIMITER //
CREATE PROCEDURE Actualizar_Detalle_Alquiler (
    IN p_Id_Detalle_Alquiler INT,
    IN p_Id_Alquiler INT,
    IN p_Id_Coche INT,
    IN p_Id_Usuario INT,
    IN p_Precio_Total DECIMAL(10,2)
)
BEGIN
    UPDATE Detalle_Alquiler
    SET Id_Alquiler = p_Id_Alquiler,
        Id_Coche = p_Id_Coche,
        Id_Usuario = p_Id_Usuario,
        Precio_Total = p_Precio_Total
    WHERE Id_Detalle_Alquiler = p_Id_Detalle_Alquiler;
END //
DELIMITER ;


-- =========== PROCEDIMIENTO PARA ELIMINAR DETALLE ALQUILER ================ --

DELIMITER //
CREATE PROCEDURE Eliminar_Detalle_Alquiler (
    IN p_Id_Detalle_Alquiler INT
)
BEGIN
    DELETE FROM Detalle_Alquiler
    WHERE Id_Detalle_Alquiler = p_Id_Detalle_Alquiler;
END//

DELIMITER ;


-- ################################################################


-- ==================TRIGGERS ALQUILER EN TABLA BITACORA===================
DELIMITER $$
-- Trigger para INSERT en Alquiler
CREATE TRIGGER trg_alquiler_insert
AFTER INSERT ON Alquiler
FOR EACH ROW
BEGIN
    INSERT INTO bitacora_general (tabla_afectada, tipo_cambio, usuario)
    VALUES ('Alquiler', 'INSERT', USER());
END$$

-- Trigger para UPDATE en Alquiler
CREATE TRIGGER trg_alquiler_update
AFTER UPDATE ON Alquiler
FOR EACH ROW
BEGIN
    INSERT INTO bitacora_general (tabla_afectada, tipo_cambio, usuario)
    VALUES ('Alquiler', 'UPDATE', USER());
END$$

-- Trigger para DELETE en Alquiler
CREATE TRIGGER trg_alquiler_delete
AFTER DELETE ON Alquiler
FOR EACH ROW
BEGIN
    INSERT INTO bitacora_general (tabla_afectada, tipo_cambio, usuario)
    VALUES ('Alquiler', 'DELETE', USER());
END$$

DELIMITER ;

-- ==================TRIGGERS DETALLE ALQUILER EN TABLA BITACORA===================

DELIMITER $$
CREATE TRIGGER trg_Detalle_Alquiler_insert
AFTER INSERT ON Detalle_Alquiler
FOR EACH ROW
BEGIN
    INSERT INTO bitacora_general (tabla_afectada, tipo_cambio, usuario)
    VALUES ('Detalle_Alquiler', 'INSERT', USER());
END$$

CREATE TRIGGER trg_Detalle_Alquiler_update
AFTER UPDATE ON Detalle_Alquiler
FOR EACH ROW
BEGIN
    INSERT INTO bitacora_general (tabla_afectada, tipo_cambio, usuario)
    VALUES ('Detalle_Alquiler', 'UPDATE', USER());
END$$

CREATE TRIGGER trg_Detalle_Alquiler_delete
AFTER DELETE ON Detalle_Alquiler
FOR EACH ROW
BEGIN
    INSERT INTO bitacora_general (tabla_afectada, tipo_cambio, usuario)
    VALUES ('Detalle_Alquiler', 'DELETE', USER());
END$$

DELIMITER ;

-- ==================TRIGGERS COCHE EN TABLA BITACORA===================
-- Triggers de coche
DELIMITER $$

CREATE TRIGGER trg_coche_insert
AFTER INSERT ON Coche
FOR EACH ROW
BEGIN
    INSERT INTO bitacora_general (tabla_afectada, tipo_cambio, usuario)
    VALUES ('Coche', 'INSERT', USER());
END$$

CREATE TRIGGER trg_coche_update
AFTER UPDATE ON Coche
FOR EACH ROW
BEGIN
    INSERT INTO bitacora_general (tabla_afectada, tipo_cambio, usuario)
    VALUES ('Coche', 'UPDATE', USER());
END$$

CREATE TRIGGER trg_coche_delete
AFTER DELETE ON Coche
FOR EACH ROW
BEGIN
    INSERT INTO bitacora_general (tabla_afectada, tipo_cambio, usuario)
    VALUES ('Coche', 'DELETE', USER());
END$$

DELIMITER ;
-- ==================TRIGGERS USUARIO EN TABLA BITACORA===================

DELIMITER $$
CREATE TRIGGER trg_usuario_insert
AFTER INSERT ON Usuario
FOR EACH ROW
BEGIN
    INSERT INTO bitacora_general (tabla_afectada, tipo_cambio, usuario)
    VALUES ('Usuario', 'INSERT', USER());
END$$

CREATE TRIGGER trg_usuario_update
AFTER UPDATE ON Usuario
FOR EACH ROW
BEGIN
    INSERT INTO bitacora_general (tabla_afectada, tipo_cambio, usuario)
    VALUES ('Usuario', 'UPDATE', USER());
END$$

CREATE TRIGGER trg_usuario_delete
AFTER DELETE ON Usuario
FOR EACH ROW
BEGIN
    INSERT INTO bitacora_general (tabla_afectada, tipo_cambio, usuario)
    VALUES ('Usuario', 'DELETE', USER());
END$$

DELIMITER ;



-- ==================TRIGGERS MANTENIMIENTO EN TABLA BITACORA=================== 
DELIMITER $$

CREATE TRIGGER trg_Mantenimiento_insert
AFTER INSERT ON Mantenimiento
FOR EACH ROW
BEGIN
    INSERT INTO bitacora_general (tabla_afectada, tipo_cambio, usuario)
    VALUES ('Mantenimiento', 'INSERT', USER());
END$$

CREATE TRIGGER trg_Mantenimiento_update
AFTER UPDATE ON Mantenimiento
FOR EACH ROW
BEGIN
    INSERT INTO bitacora_general (tabla_afectada, tipo_cambio, usuario)
    VALUES ('Mantenimiento', 'UPDATE', USER());
END$$

CREATE TRIGGER trg_Mantenimiento_delete
AFTER DELETE ON Mantenimiento
FOR EACH ROW
BEGIN
    INSERT INTO bitacora_general (tabla_afectada, tipo_cambio, usuario)
    VALUES ('Mantenimiento', 'DELETE', USER());
END$$

DELIMITER ;

-- ==================TRIGGERS DETALLE MANTENIMIENTO EN TABLA BITACORA=================== 

DELIMITER $$
CREATE TRIGGER trg_Detalle_Mantenimiento_insert
AFTER INSERT ON Detalle_Mantenimiento
FOR EACH ROW
BEGIN
    INSERT INTO bitacora_general (tabla_afectada, tipo_cambio, usuario)
    VALUES ('Detalle_Mantenimiento', 'INSERT', USER());
END$$

CREATE TRIGGER trg_Detalle_Mantenimiento_update
AFTER UPDATE ON Detalle_Mantenimiento
FOR EACH ROW
BEGIN
    INSERT INTO bitacora_general (tabla_afectada, tipo_cambio, usuario)
    VALUES ('Detalle_Mantenimiento', 'UPDATE', USER());
END$$

CREATE TRIGGER trg_Detalle_Mantenimiento_delete
AFTER DELETE ON Detalle_Mantenimiento
FOR EACH ROW
BEGIN
    INSERT INTO bitacora_general (tabla_afectada, tipo_cambio, usuario)
    VALUES ('Detalle_Mantenimiento', 'DELETE', USER());
END$$

DELIMITER ;


-- ==================TRIGGERS EMPLEADO EN TABLA BITACORA=================== 

DELIMITER $$

CREATE TRIGGER trg_empleado_insert
AFTER INSERT ON empleado
FOR EACH ROW
BEGIN
    INSERT INTO bitacora_general (tabla_afectada, tipo_cambio, usuario)
    VALUES ('empleado', 'INSERT', USER());
END$$

CREATE TRIGGER trg_empleado_update
AFTER UPDATE ON empleado
FOR EACH ROW
BEGIN
    INSERT INTO bitacora_general (tabla_afectada, tipo_cambio, usuario)
    VALUES ('empleado', 'UPDATE', USER());
END$$

CREATE TRIGGER trg_empleado_delete
AFTER DELETE ON empleado
FOR EACH ROW
BEGIN
    INSERT INTO bitacora_general (tabla_afectada, tipo_cambio, usuario)
    VALUES ('empleado', 'DELETE', USER());
END$$

DELIMITER ;
-- ============================================================================


-- ####################################TRIGGERS DIANMICOS COCHES#########################################
-- #########################CAMBIAR EL ESTADO DE UN COCHE ############################
DELIMITER $$

CREATE TRIGGER trg_Coche_En_Alquiler
AFTER INSERT ON Detalle_Alquiler
FOR EACH ROW
BEGIN
    UPDATE Coche
    SET Estado = 'En Alquiler'
    WHERE Id_Coche = NEW.Id_Coche;
END $$

-- Cuando se registre un mantenimiento

CREATE TRIGGER trg_Coche_En_Mantenimiento
AFTER INSERT ON Detalle_Mantenimiento
FOR EACH ROW
BEGIN
    UPDATE Coche
    SET Estado = 'En Mantenimiento'
    WHERE Id_Coche = NEW.Id_Coche;
END $$

DELIMITER ;

-- ###########################################################################


-- Cuando se cancele un alquiler
DELIMITER $$

CREATE TRIGGER trg_actualizar_estado_coche_cancelado
AFTER UPDATE ON Alquiler
FOR EACH ROW
BEGIN
    -- Verifica si el alquiler cambió a "Cancelado"
    IF NEW.Estado = 'Cancelado' THEN
        -- Actualiza los coches asociados a ese alquiler a "Disponible"
        UPDATE Coche
        SET Estado = 'Disponible'
        WHERE Id_Coche IN (
            SELECT Id_Coche
            FROM Detalle_Alquiler
            WHERE Id_Alquiler = NEW.Id_Alquiler
        );
    END IF;
END$$

DELIMITER ;

-- ########################################################################

-- Prevenir que se modifiquen los alquileres o detalles cancelados
DELIMITER $$

CREATE TRIGGER trg_prevenir_modificacion_cancelado
BEFORE UPDATE ON Alquiler
FOR EACH ROW
BEGIN
    IF OLD.Estado = ('Cancelado', 'Finalizado') THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No se puede modificar un alquiler cancelado o finalizado.';
    END IF;
END$$

DELIMITER ;


DELIMITER $$

CREATE TRIGGER trg_prevenir_insert_detalle_en_alquiler_cerrado
BEFORE INSERT ON Detalle_Alquiler
FOR EACH ROW
BEGIN
    DECLARE v_estado ENUM('En curso','Cancelado','En espera','Finalizado');

    SELECT Estado INTO v_estado
    FROM Alquiler
    WHERE Id_Alquiler = NEW.Id_Alquiler;

    IF v_estado IN ('Cancelado', 'Finalizado') THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No se pueden agregar detalles a un alquiler cancelado o finalizado.';
    END IF;
END$$

DELIMITER ;



DELIMITER $$

CREATE TRIGGER trg_prevenir_update_detalle_en_alquiler_cerrado
BEFORE UPDATE ON Detalle_Alquiler
FOR EACH ROW
BEGIN
    DECLARE v_estado ENUM('En curso','Cancelado','En espera','Finalizado');

    SELECT Estado INTO v_estado
    FROM Alquiler
    WHERE Id_Alquiler = NEW.Id_Alquiler;

    IF v_estado IN ('Cancelado', 'Finalizado') THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No se pueden modificar detalles de un alquiler cancelado o finalizado.';
    END IF;
END$$

DELIMITER ;

-- ###############################################################################

-- Trigger para cambiar el estado del alquiler al insertar 
DELIMITER $$

CREATE TRIGGER trg_alquiler_estado_before_insert
BEFORE INSERT ON Alquiler
FOR EACH ROW
BEGIN
    DECLARE fecha_actual DATETIME;
    SET fecha_actual = NOW();

	IF (fecha_actual < NEW.Fecha_Inicio) THEN
		SET NEW.Estado = 'En espera';
	ELSEIF (fecha_actual BETWEEN NEW.Fecha_Inicio AND NEW.Fecha_Fin) THEN
		SET NEW.Estado = 'En curso';
	END IF;
        
END$$

DELIMITER ;

--  ##############################################################################
-- -- Trigger para cambiar el estado del alquiler al actualizar 

DELIMITER $$

CREATE TRIGGER trg_alquiler_estado_before_update
BEFORE UPDATE ON Alquiler
FOR EACH ROW
BEGIN
    DECLARE fecha_actual DATETIME;
    SET fecha_actual = NOW();

    -- Solo se cambia automáticamente el estado del alquiler
        IF (fecha_actual < NEW.Fecha_Inicio) THEN
            SET NEW.Estado = 'En espera';
        ELSEIF (fecha_actual BETWEEN NEW.Fecha_Inicio AND NEW.Fecha_Fin) THEN
            SET NEW.Estado = 'En curso';
        END IF;
END$$

DELIMITER ;



-- ########################-Revisar si existen placas duplicadas-##########

DELIMITER $$

CREATE TRIGGER trg_evitar_placa_duplicada
BEFORE INSERT ON Coche
FOR EACH ROW
BEGIN
    DECLARE existe INT;

    SELECT COUNT(*) INTO existe
    FROM Coche
    WHERE Coche.Placa = NEW.Placa;

    IF existe > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: La placa ya está registrada en el sistema.';
    END IF;
END$$

DELIMITER ;


DELIMITER $$

CREATE TRIGGER trg_evitar_placa_duplicada_update
BEFORE UPDATE ON Coche
FOR EACH ROW
BEGIN
  DECLARE Existe INT;

  SELECT COUNT(*) INTO existe
  FROM Coche
  -- Aplicamos condicion para evitar valores duplicados
  WHERE Placa = NEW.Placa AND Coche.Id_Coche <> OLD.Id_Coche;

  IF Existe > 0 THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Error: La placa ya está registrada en otro coche.';
  END IF;
END $$

DELIMITER ;

/*
SHOW TRIGGERS LIKE 'Coche';
DROP TRIGGER IF EXISTS trg_evitar_placa_duplicada;
*/


-- ==================================EVENTOS==================================
-- Evento para actualizar coches que ya terminaron su alquiler
DELIMITER $$
CREATE EVENT ev_actualizar_estado_coche
ON SCHEDULE EVERY 1 HOUR
STARTS CURRENT_TIMESTAMP
DO
BEGIN
    UPDATE Coche c
    JOIN Detalle_Alquiler da ON c.Id_Coche = da.Id_Coche
    JOIN Alquiler a ON da.Id_Alquiler = a.Id_Alquiler
    SET c.Estado = 'Disponible'
    WHERE a.Fecha_Fin < NOW()
      AND c.Estado = 'En Alquiler';

    UPDATE Coche c
    JOIN Detalle_Mantenimiento dm ON c.Id_Coche = dm.Id_Coche
    JOIN Mantenimiento m ON dm.Id_Mantenimiento = m.Id_Mantenimiento
    SET c.Estado = 'Disponible'
    WHERE m.Fecha_Fin < NOW()
      AND c.Estado = 'En Mantenimiento';
END;

DELIMITER ;

-- ################################################################################
-- EVENTO QUE PONE EL ALQUILER EN FINALIZADO CUANDO LA FECHA FIN SEA INFERIOR AL ACTUAL
DELIMITER $$

CREATE EVENT ev_actualizar_alquiler_finalizado
ON SCHEDULE EVERY 1 HOUR
DO
BEGIN
UPDATE Alquiler
SET Estado = 'Finalizado'
WHERE Fecha_Fin < NOW()
  AND Estado = 'En curso';
END$$

DELIMITER ;

-- Activamos los eventos
/*
#para activar los eventos en MySQL 
SET GLOBAL event_scheduler = ON; 
#mostrar todos los eventos creados en MySQL
SHOW EVENTS; 
*/

-- ===========================CREAR USUARIOS=================================================================
-- Crear rol
DROP ROLE IF EXISTS 'Administrador'@'localhost';
CREATE ROLE 'Administrador'@'localhost';

-- Otorgarle permisos al rol
GRANT USAGE ON *.* TO 'Administrador'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON BD_rentacar_G3.* TO 'Administrador'@'localhost';

FLUSH PRIVILEGES;

-- Crear usuario
DROP USER IF EXISTS 'Ermakremaya'@'localhost';
CREATE USER 'Ermakremaya'@'localhost' IDENTIFIED BY 'ermakremaya123';

-- Asignar el rol al usuario
GRANT 'Administrador'@'localhost' TO 'Ermakremaya'@'localhost';

-- Activar el rol por defecto para el usuario
SET DEFAULT ROLE 'Administrador'@'localhost' TO 'Ermakremaya'@'localhost';

FLUSH PRIVILEGES;

-- ##################################-Pruebas de ejecucion-#######################


-- =================================INSERTS===========================================
INSERT INTO Usuario (Cedula, Nombre1, Nombre2, Apellido1, Apellido2, Telefono, Direccion, Email, Licencia, Contrasena) VALUES
('001-010101-0000A', 'Maycol', 'Daniel', 'Perez', 'Sanchez', '12345678', 'Calle Falsa 123', 'maycolsekee@gmail.com', 'LIC-001', 'maycol123');


INSERT INTO Empleado (Rol, Cedula, Nombre1, Nombre2, Apellido1, Apellido2, Direccion, Email, Contrasena) VALUES
('Administrador', '011-111111-0000K', 'Equipo de', 'Integrantes', 'Desarrollo', 'Increible', 'Calle Independencia 765', 'ermakremaya@gmail.com', 'ermakremaya123'),
('Agente de alquiler', '012-121212-0000L', 'Maryina', 'Alejandro', 'Torres', 'Santos', 'Avenida del Sol 876', 'maryina@gmail.com', 'maryina123'),
('Mecánico', '013-131313-0000M', 'Kreivin', 'Beatriz', 'Jimenez', 'Diaz', 'Calle de los Pinos 987', 'kreivin@gmail.com', 'kreivin123');


INSERT INTO Coche (Marca, Modelo, Anio, Placa, Color, Valor_Dia) VALUES
('Toyota', 'Corolla', 2022, 'ABC123', '#FF0000', 25.00),
('Toyota', 'Corolla', 2022, 'ABC852', '#FF0000', 25.00),
('Honda', 'Civic', 2021, 'XYZ789', '#0000FF', 28.00),
('Ford', 'Focus', 2023, 'DEF456', '#000000', 30.00),
('Chevrolet', 'Cruze', 2020, 'GHI789', '#FFFFFF', 24.50),
('Nissan', 'Sentra', 2022, 'JKL012', '#C0C0C0', 27.00),
('Mazda', '3', 2021, 'MNO345', '#008000', 29.50),
('Kia', 'Forte', 2020, 'PQR678', '#808080', 23.75),
('Hyundai', 'Elantra', 2022, 'STU901', '#FF0000', 26.00),
('BMW', '320i', 2021, 'VWX234', '#0000FF', 45.00),
('Audi', 'A4', 2023, 'YZA567', '#000000', 48.00),
('Mercedes-Benz', 'C-Class', 2020, 'BCD890', '#FFFFFF', 50.00),
('Volkswagen', 'Golf', 2022, 'EFG123', '#C0C0C0', 27.50),
('Porsche', 'Cayenne', 2023, 'HIJ456', '#FFFF00', 120.00),
('Toyota', 'Yaris', 2021, 'KLM789', '#FF0000', 22.00),
('Honda', 'HR-V', 2022, 'NOP012', '#008000', 32.00),
('Chevrolet', 'Equinox', 2020, 'QRS345', '#0000FF', 34.50),
('Nissan', 'Altima', 2023, 'TUV678', '#808080', 31.00),
('Mazda', 'CX-5', 2022, 'WXY901', '#FFFFFF', 35.00),
('Kia', 'Sportage', 2021, 'ZAB234', '#000000', 33.00);
     


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


INSERT INTO Detalle_Alquiler (Id_Alquiler, Id_Coche, Id_Usuario, Precio_Total) VALUES
(1, 1, 1, 500.00),
(2, 2, 1, 600.00),
(3, 3, 1, 450.00),
(4, 4, 1, 700.00),
(5, 5, 1, 550.00),
(6, 6, 1, 650.00),
(7, 7, 1, 480.00),
(8, 8, 1, 530.00),
(9, 9, 1, 490.00),
(10, 10, 1, 720.00),
(11, 11, 1, 570.00),
(12, 12, 1, 510.00),
(13, 13, 1, 690.00),
(14, 14, 1, 500.00),
(15, 15, 1, 560.00),
(16, 16, 1, 730.00),
(17, 17, 1, 520.00),
(18, 18, 1, 540.00),
(19, 19, 1, 710.00);


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


INSERT INTO Detalle_Mantenimiento (Id_Mantenimiento, Id_Empleado, Id_Coche, Observaciones, Recomendaciones, Partes_Cambiadas) VALUES
(1, 1, 2, 'Cambio exitoso de aceite y filtro', 'Revisar cada 5,000 km', 'Aceite, Filtro de aceite'),
(2, 2, 2, 'Sistema de frenos reemplazado', 'Verificar cada 3 meses', 'Pastillas de freno, Discos'),
(3, 2, 2, 'Batería vieja reemplazada', 'Mantener bornes limpios', 'Batería'),
(4, 2, 2, 'Sistema eléctrico inspeccionado', 'Revisar cada 6 meses', 'Cableado'),
(5, 2, 2, 'Llantas nuevas instaladas', 'Rotar cada 10,000 km', '4 Llantas');

-- =====================================================================================================
/*
-- Ejemplo de uso:
CALL InsertarEmpleado('Agente de alquiler', '121-098424-100C', 'Carlos', 'Andrés', 'Martínez', 'López', 'León', 'carlo13@gmail.com', 'C202401153');

-- Ejemplo de uso:
CALL ActualizarEmpleado( '1' ,'Administrador', "121-098487-100C", 'Carlos', 'Andrés', 'Martínez', 'López', 'Managua', 'Carlo12@gmail.com', '77777777');

-- Ejemplo de uso:
CALL EliminarEmpleado(1);



-- Ejemplo
CALL InsertarCoche('Toyota', 'Etios', 2020, 'M12348', 'Rojo');

CALL ActualizarCoche(21, "Toyota", "Etios", 2011, "DJS1254", "Rojo");

CALL EliminarCoche('1');



CALL InsertarUsuario(
    '099-999999-0009Z', 'Carlos', 'Eduardo', 'Mora', 'Jimenez',
    '88889999', 'San José', 'carlos.mora@email.com', 'LIC-Z9', 'claveSegura'
);

CALL ActualizarUsuario(
    1, '099-888888-0001X', 'Carlos', 'Andrés', 'Mora', 'Jimenez',
    '88882222', 'San Pedro', 'carlos.actualizado@email.com', 'LIC-ZX', 'nuevaClave'
);

CALL EliminarUsuario(10);


call InsertMantenimientos('BAlbulas', 'Mantenimiento preventivo', '2025-02-10 08:00:00', '2025-02-20 10:00:00', 50.00);


call ActualizarMantenimientos(1);

CALL EliminarMantenimiento(1);

-- Ejemplo
CALL insert_alquiler('2025-07-10 12:00:00', '2025-10-25 12:50:00');

-- ================ EJEMPLO PARA ACTUALIZAR ALQUILER ================= --
CALL Actualizar_Alquiler(1, '2025-10-28 08:00:00', '2025-10-31 18:00:00');

-- ======= EJEMPLO PARA ELIMINAR ALQUILER ====== --
CALL Eliminar_Alquiler(2);


-- ================== EJEMPLO DE INSERTAR ==================== --
CALL Insertar_Detalle_Alquiler(1, 2, 3, 150.00);

-- =========== EJEMPLO DE ACTUALIZAR ================ --
CALL Actualizar_Detalle_Alquiler(1, 3, 5, 6, 200.75);

-- =========== EJEMPLO DE ELIMINAR ================ --
CALL Eliminar_Detalle_Alquiler(2);
*/

-- Lista de triggers
SHOW TRIGGERS FROM BD_rentacar_G3;

-- Lista de procedimientos almacenados
SHOW PROCEDURE STATUS WHERE Db = 'BD_rentacar_G3';

-- Lista de funciones
SHOW FUNCTION STATUS WHERE Db = 'BD_rentacar_G3';

-- Lista de vistas
SHOW FULL TABLES IN BD_rentacar_G3 WHERE TABLE_TYPE = 'VIEW';

-- Lista de eventos
SHOW EVENTS FROM BD_rentacar_G3;

-- Mostrar derechos del usuarios
#SHOW GRANTS FOR 'pachenco'@'localhost';