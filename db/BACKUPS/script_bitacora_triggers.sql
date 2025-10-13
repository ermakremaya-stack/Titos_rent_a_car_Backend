
-- =====================================
-- Tabla de Bitácora General
-- Esta bitacora guardará todas las afectaciones a las tablas.
-- =====================================
CREATE TABLE IF NOT EXISTS bitacora_general (
    id_bitacora INT AUTO_INCREMENT PRIMARY KEY,
    tabla_afectada VARCHAR(50) NOT NULL,
    tipo_cambio VARCHAR(20) NOT NULL,
    usuario VARCHAR(100) NOT NULL,
    fecha DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- *************************************
-- Se debe hacer un trigger por cada tabla y por cada acción 
-- *************************************

-- =====================================
-- Triggers para tabla EMPLEADO
-- =====================================
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

-- =====================================
-- Triggers para tabla CAJA
-- =====================================
CREATE TRIGGER trg_caja_insert
AFTER INSERT ON caja
FOR EACH ROW
BEGIN
    INSERT INTO bitacora_general (tabla_afectada, tipo_cambio, usuario)
    VALUES ('caja', 'INSERT', USER());
END$$

CREATE TRIGGER trg_caja_update
AFTER UPDATE ON caja
FOR EACH ROW
BEGIN
    INSERT INTO bitacora_general (tabla_afectada, tipo_cambio, usuario)
    VALUES ('caja', 'UPDATE', USER());
END$$

CREATE TRIGGER trg_caja_delete
AFTER DELETE ON caja
FOR EACH ROW
BEGIN
    INSERT INTO bitacora_general (tabla_afectada, tipo_cambio, usuario)
    VALUES ('caja', 'DELETE', USER());
END$$

-- =====================================
-- Triggers para tabla TURNO
-- =====================================
CREATE TRIGGER trg_turno_insert
AFTER INSERT ON turno
FOR EACH ROW
BEGIN
    INSERT INTO bitacora_general (tabla_afectada, tipo_cambio, usuario)
    VALUES ('turno', 'INSERT', USER());
END$$

CREATE TRIGGER trg_turno_update
AFTER UPDATE ON turno
FOR EACH ROW
BEGIN
    INSERT INTO bitacora_general (tabla_afectada, tipo_cambio, usuario)
    VALUES ('turno', 'UPDATE', USER());
END$$

CREATE TRIGGER trg_turno_delete
AFTER DELETE ON turno
FOR EACH ROW
BEGIN
    INSERT INTO bitacora_general (tabla_afectada, tipo_cambio, usuario)
    VALUES ('turno', 'DELETE', USER());
END$$

DELIMITER ;
