import { pool } from '../../db_connection.js';

// Obtener todas los empleado 

export const obtenerEmpleados = async (req, res) => {
    try {
        const [result] = await pool.query('SELECT * FROM Empleado');
        res.json(result);
    } catch (error) {
        return res.status(500).json({
            mensaje: 'Ha ocurrido un error al leer los datos.',
            error: error
        });
    }
}

// Obtener un empleado por su ID
export const obtenerEmpleado = async (req, res) => {
    try {
        const Id_Empleado = req.params.Id_Empleado;
        const [result] = await pool.query('SELECT * FROM Empleado WHERE  Id_Empleado = ?', [Id_Empleado]);
        if (result.length <= 0) {
            return res.status(404).json({
                mensaje: `Error al leer los datos. ID ${Id_Empleado} no encontrado.`
            });
        }
        res.json(result[0]);
    } catch (error) {
        return res.status(500).json({
            mensaje: 'Ha ocurrido un error al leer los datos de las empleado.'
        });
    }
};

// Registrar un nueva empleado
export const registrarEmpleado = async (req, res) => {
    try {
        const {
            Cedula,
            Nombre1,
            Nombre2,
            Apellido1,
            Apellido2,
            Direccion,
            Email
        } = req.body;
        const [result] = await pool.query(
            'INSERT INTO Empleado (Cedula, Nombre1, Nombre2, Apellido1, Apellido2, Direccion, Email) VALUES (?, ?, ?, ?, ?, ?, ?)',
            [Cedula,
            Nombre1,
            Nombre2,
            Apellido1,
            Apellido2,
            Direccion,
            Email]
        );
        res.status(201).json({ Id_Empleado: result.insertId });
    } catch (error) {
        return res.status(500).json({
            mensaje: 'Ha ocurrido un error al registrar lempleado empleado.',
            error: error
        });
    }
};