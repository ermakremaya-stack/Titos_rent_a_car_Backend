DELIMITER $$
CREATE EVENT actualizar_coches_terminados
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
END$$
DELIMITER ;

-- Evento para marcar mantenimientos vencidos

DELIMITER $$
CREATE EVENT marcar_mantenimientos_vencidos
ON SCHEDULE EVERY 1 DAY
STARTS CURRENT_TIMESTAMP
DO
BEGIN
    UPDATE Mantenimiento m
    SET m.Estado = 'Vencido'
    WHERE m.Fecha_Fin < NOW()
      AND m.Estado != 'Vencido';
END$$
DELIMITER ;

SET GLOBAL event_scheduler = ON; #para activar los eventos en MySQL
SHOW EVENTS; #mostrar todos los eventos creados en MySQL
