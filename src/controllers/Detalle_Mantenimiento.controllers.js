import { pool } from '../../db_connection.js';

// Obtener todas las Detalle_Mantenimiento

export const obtenerDetalle_Mantenimiento = async (req, res) => {
    try {
        const [result] = await pool.query('SELECT * FROM Detalle_Mantenimiento');
        res.json(result);
    } catch (error) {
        return res.status(500).json({
            mensaje: 'Ha ocurrido un error al leer los datos.',
            error: error
        });
    }
};