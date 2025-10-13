DELIMITER $$

-- Trigger para INSERT en Alquiler
CREATE TRIGGER trg_alquiler_insert
AFTER INSERT ON Alquiler
FOR EACH ROW
BEGIN
    INSERT INTO bitacora_general (tabla_afectada, tipo_cambio, usuario)
    VALUES ('Alquiler', 'INSERT', USER());
END$$

DELIMITER $$

-- Trigger para UPDATE en Alquiler
CREATE TRIGGER trg_alquiler_update
AFTER UPDATE ON Alquiler
FOR EACH ROW
BEGIN
    INSERT INTO bitacora_general (tabla_afectada, tipo_cambio, usuario)
    VALUES ('Alquiler', 'UPDATE', USER());
END$$

DELIMITER $$ 
-- Trigger para DELETE en Alquiler
CREATE TRIGGER trg_alquiler_delete
AFTER DELETE ON Alquiler
FOR EACH ROW
BEGIN
    INSERT INTO bitacora_general (tabla_afectada, tipo_cambio, usuario)
    VALUES ('Alquiler', 'DELETE', USER());
END$$

DELIMITER ;

-- INSERTAR ALQUILER
INSERT INTO Alquiler (Fecha_Inicio, Fecha_Fin)
VALUES ('2025-09-23 10:00:00', '2025-09-25 10:00:00');

-- ACTUALIZAR ALQUILER
UPDATE Alquiler SET Fecha_Fin = '2025-09-26 18:00:00' WHERE Id_Alquiler = 1;

-- ELIMINAR ALQUILER
DELETE FROM Alquiler WHERE Id_Alquiler = 1;

-- Visualizar
SELECT * FROM bitacora_general;

DELIMITER $$

CREATE TRIGGER trg_coche_en_mantenimiento
AFTER INSERT ON Detalle_Mantenimiento
FOR EACH ROW
BEGIN
    UPDATE Coche
    SET Estado = 'En Mantenimiento'
    WHERE Id_Coche = NEW.Id_Coche;
END$$

DELIMITER ;

SHOW TRIGGERS;.