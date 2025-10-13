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
