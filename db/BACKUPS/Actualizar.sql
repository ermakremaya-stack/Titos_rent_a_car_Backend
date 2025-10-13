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
