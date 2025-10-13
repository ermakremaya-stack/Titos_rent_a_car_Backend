import { pool } from '../../db_connection.js';

// Obtener todas los Detalle_Alquileres

export const obtenerDetalle_Alquileres = async (req, res) => {
    try {
        const [result] = await pool.query('SELECT * FROM Detalle_Alquiler');
        res.json(result);
    } catch (error) {
        return res.status(500).json({
            mensaje: 'Ha ocurrido un error al leer los datos.',
            error: error
        });
    }
};

// Obtener un detalle de alquiler por su ID
export const obtenerDetalle_Alquiler = async (req, res) => {
    try {
        const id_Detalle_Alquiler = req.params.id_Detalle_Alquiler;
        const [result] = await pool.query(
            'SELECT * FROM Detalle_Alquiler WHERE Id_Detalle_Alquiler = ?',
            [id_Detalle_Alquiler]
        );
        if (result.length <= 0) {
            return res.status(404).json({
                mensaje: `Error al leer los datos. ID ${id_Detalle_Alquiler} no encontrado.`
            });
        }
        res.json(result[0]);
    } catch (error) {
        return res.status(500).json({
            mensaje: 'Ha ocurrido un error al leer los datos de Detalle_Alquiler.',
            error: error
        });
    }
};


// Registrar un nuevo Detalle_Alquiler
export const registrarDetalle_Alquiler = async (req, res) => {
    try {
        const { Id_Alquiler, Id_Coche, Id_Usuario, Precio_Total } = req.body;
        const [result] = await pool.query(
            'INSERT INTO Detalle_Alquiler (Id_Alquiler, Id_Coche, Id_Usuario, Precio_Total) VALUES (?, ?, ?, ?)',
            [Id_Alquiler, Id_Coche, Id_Usuario, Precio_Total]
        );
        res.status(201).json({ id_Detalle_Alquiler: result.insertId });
    } catch (error) {
        return res.status(500).json({
            mensaje: 'Ha ocurrido un error al registrar el Detalle_Alquiler.',
            error: error
        });
    }
};

// Eliminar un detalle de alquiler por su ID
export const eliminarDetalle_Alquiler = async (req, res) => {
    try {
        const [result] = await pool.query('DELETE FROM Detalle_Alquiler WHERE Id_Detalle_Alquiler = ?', [req.params.Id_Detalle_Alquiler]);
        if (result.affectedRows <= 0) {
            return res.status(404).json({
                mensaje: `Error al eliminar. ID ${req.params.Id_Detalle_Alquiler} no encontrado.`
            });
        }
        // Respuesta exitosa
        res.sendStatus(204);
    } catch (error) {
        return res.status(500).json({
            mensaje: 'Ha ocurrido un error al eliminar el detalle de alquiler.',
            error: error
        });
    }
};

// Actualizar un detalle de alquiler por su ID
export const actualizarDetalle_Alquiler = async (req, res) => {
    try {
        const Id_Detalle_Alquiler = req.params.Id_Detalle_Alquiler;
        const { Id_Alquiler, Id_Coche, Id_Usuario, Precio_Total } = req.body;

        const [result] = await pool.query(
            'UPDATE Detalle_Alquiler SET Id_Alquiler = ?, Id_Coche = ?, Id_Usuario = ?, Precio_Total = ? WHERE Id_Detalle_Alquiler = ?',
            [Id_Alquiler, Id_Coche, Id_Usuario, Precio_Total, Id_Detalle_Alquiler]
        );
        if (result.affectedRows === 0) {
            return res.status(404).json({
                mensaje: `Error al actualizar el detalle de alquiler. El ID ${Id_Detalle_Alquiler} no fue encontrado.`
            });
        }
        res.status(200).json({
            mensaje: `Detalle de alquiler con ID ${Id_Detalle_Alquiler} actualizado exitosamente.`
        });
    } catch (error) {
        return res.status(500).json({
            mensaje: "Ha ocurrido un error al actualizar el detalle de alquiler.",
            error: error
        });
    }
};
