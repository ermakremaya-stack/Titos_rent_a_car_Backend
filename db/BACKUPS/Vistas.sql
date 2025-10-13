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
