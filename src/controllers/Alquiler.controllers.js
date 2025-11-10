import { pool } from '../../db_connection.js';

// Obtener todas las alquiler

export const obtenerAlquileres = async (req, res) => {
    try {
        const [result] = await pool.query('SELECT * FROM Alquiler');
        res.json(result);
    } catch (error) {
        return res.status(500).json({
            mensaje: 'Ha ocurrido un error al leer los datos.',
            error: error
        });
    }
};

// Obtener un alquiler por su ID
export const obtenerAlquiler = async (req, res) => {
    try {
        const [result] = await pool.query('SELECT * FROM Alquiler WHERE Id_Alquiler = ?', [req.params.Id_Alquiler]);
        if (result.length <= 0) {
            return res.status(404).json({
                mensaje: `Error al leer los datos. ID ${req.params.Id_Alquiler} no encontrado.`
            });
        }
        res.json(result[0]);
    } catch (error) {
        return res.status(500).json({
            mensaje: 'Ha ocurrido un error al leer los datos de alquileres.',
            error: error
        });
    }   
};

// Registrar un nuevo alquiler
export const registrarAlquiler = async (req, res) => {
    try {
        const { fecha_inicio, fecha_fin } = req.body;
        const [result] = await pool.query(
            'INSERT INTO Alquiler (Fecha_Inicio, Fecha_Fin) VALUES (?, ?)',
            [fecha_inicio, fecha_fin]
        );
        res.status(201).json({ id_alquiler: result.insertId});
    } catch (error) {
        return res.status(500).json({
            mensaje: 'Ha ocurrido un error al registrar el alquiler.',
            error: error
        });
    }
};

// Eliminar un alquiler por su ID
export const eliminarAlquiler = async (req, res) => {
    try {
        const [result] = await pool.query('DELETE FROM Alquiler WHERE Id_Alquiler = ?', [req.params.Id_Alquiler]);
        if (result.affectedRows <= 0) {
            return res.status(404).json({
                mensaje: `Error al eliminar. ID ${req.params.Id_Alquiler} no encontrado.`
            });
        }
        // Respuesta exitosa
        res.sendStatus(204);
    } catch (error) {
        return res.status(500).json({
            mensaje: 'Ha ocurrido un error al eliminar el alquiler.',
            error: error
        });
    }
};

// Actualizar un alquiler por su ID
export const actualizarAlquiler = async (req, res) => {
    try {
        const Id_Alquiler = req.params.Id_Alquiler;
        const { fecha_inicio, fecha_fin } = req.body;

        const [result] = await pool.query(
            'Call ',
            [fecha_inicio, fecha_fin, Id_Alquiler]
        );
        if (result.affectedRows === 0) {
            return res.status(404).json({
                mensaje: `Error al actualizar el alquiler. El ID ${Id_Alquiler} no fue encontrado.`
            });
        }
        res.status(200).json({
            mensaje: `Alquiler con ID ${Id_Alquiler} actualizado exitosamente.`
        });
    } catch (error) {
        return res.status(500).json({
            mensaje: "Ha ocurrido un error al actualizar el alquiler.",
            error: error
        });
    }
};
