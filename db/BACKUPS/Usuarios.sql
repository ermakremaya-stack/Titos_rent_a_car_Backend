-- Obtener costo total de mantenimiento por coche

CREATE USER IF NOT EXISTS "ernesto"@"localhost" IDENTIFIED BY "123456";
CREATE USER IF NOT EXISTS "kreivin"@"localhost" IDENTIFIED BY "242526";
CREATE USER IF NOT EXISTS "maestrogarcia"@"localhost" IDENTIFIED BY "master15";

-- Administrador
GRANT ALL PRIVILEGES ON BD_rentacar_G3.Cliente TO "ernesto"@"localhost";
-- Editor
GRANT INSERT, UPDATE ON BD_rentacar_G3. Empleado TO "kreivin"@"localhost";
-- lector
GRANT SELECT ON BD_rentacar_G3. Alquiler TO "maestrogarcia"@"localhost";

SHOW GRANTS FOR "ernesto"@"localhost";
SHOW GRANTS FOR "kreivin"@"localhost";
SHOW GRANTS FOR "maestrogarcia"@"localhost";