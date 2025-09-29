@echo off
REM Obtener la fecha actual en formato YYYY-MM-DD
set FECHA=%date:~6,4%-%date:~3,2%-%date:~0,2%

REM Cambia esta ruta según donde esté instalado tu MySQL
"C:\Program Files\MySQL\MySQL Workbench 8.0 CE\mysqldump.exe" -u root BD_rentacar_G3 -p > C:\Users\dell\OneDrive\Music\Titos_rent_a_car\db\BACKUPS\BD_rentacar_G3.sql

REM Mensaje de confirmacion
echo Backup completado: C:\Users\dell\OneDrive\Music\Titos_rent_a_car\db\BACKUPS\BD_rentacar_G3.sql
pause