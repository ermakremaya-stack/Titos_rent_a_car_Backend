import { pool } from '../../db_connection.js';

// Obtener todas las coches

export const obtenerCoches = async (req, res) => {
    try {
        const [result] = await pool.query('SELECT * FROM Coche');
        res.json(result);
    } catch (error) {
        return res.status(500).json({
            mensaje: 'Ha ocurrido un error al leer los datos.',
            error: error
        });
    }
};

// Obtener un coche por su ID
export const obtenerCoche = async (req, res) => {
    try {
        const [result] = await pool.query('SELECT * FROM Coche WHERE Id_Coche = ?', [req.params.Id_Coche]);
        if (result.length <= 0) {
            return res.status(404).json({
                mensaje: `Error al leer los datos. ID ${req.params.Id_Coche} no encontrado.`
            });
        }
        res.json(result[0]);
    } catch (error) {
        return res.status(500).json({
            mensaje: 'Ha ocurrido un error al leer los datos del coche.'
        });
    }   
};


// Registrar un nuevo coche
export const registrarCoche = async (req, res) => {
    try {
        const { marca, modelo, anio, placa, color, fecha_registro, estado } = req.body;
        const [result] = await pool.query(
        'INSERT INTO Coche (Marca, Modelo, Anio, Placa, Color, Fecha_Registro, Estado) VALUES (?, ?, ?, ?, ?, ?, ?)',
        [marca, modelo, anio, placa, color, fecha_registro, estado]
);
        res.status(201).json({ id_coche: result.insertId });
    } catch (error) {
        return res.status(500).json({
            mensaje: 'Ha ocurrido un error al registrar el coche.',
            error: error
        });
    }
};

