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