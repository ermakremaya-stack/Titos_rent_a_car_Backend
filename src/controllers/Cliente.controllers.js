import { pool } from '../../db_connection.js';

// Obtener todas las cliente

export const obtenerCliente = async (req, res) => {
    try {
        const [result] = await pool.query('SELECT * FROM Cliente');
        res.json(result);
    } catch (error) {
        return res.status(500).json({
            mensaje: 'Ha ocurrido un error al leer los datos.',
            error: error
        });
    }
};

// Obtener cliente por ID

export const obtenerClientePorId = async (req, res) => {
    try {
        const { id } = req.params;
        const [result] = await pool.query('SELECT * FROM Cliente WHERE idCliente = ?', [id]);
        if (result.length === 0) {
            return res.status(404).json({
                mensaje: 'Cliente no encontrado.'
            });
        }
        res.json(result[0]);
    } catch (error) {
        return res.status(500).json({
            mensaje: 'Ha ocurrido un error al leer los datos.',
            error: error
        });
    } };

// Crear nueva cliente 
export const crearCliente = async (req, res) => {
    try {
        const { nombre, direccion, telefono, email } = req.body;
        const [result] = await pool.query('INSERT INTO Cliente (nombre, direccion, telefono, email) VALUES (?, ?, ?, ?)', [nombre, direccion, telefono, email]);
        res.json({
            idCliente: result.insertId,
            nombre,
            direccion,
            telefono,
            email
        });
    } catch (error) {
        return res.status(500).json({
            mensaje: 'Ha ocurrido un error al crear el cliente.',
            error: error
        });
    } };

// Actualizar cliente por ID 
export const actualizarCliente = async (req, res) => {
    try {
        const { id } = req.params;
        const { nombre, direccion, telefono, email } = req.body;
        const [result] = await pool.query('UPDATE Cliente SET nombre = ?, direccion = ?, telefono = ?, email = ? WHERE idCliente = ?', [nombre, direccion, telefono, email, id]);
        if (result.affectedRows === 0) {
            return res.status(404).json({
                mensaje: 'Cliente no encontrado.'
            });
        } } catch (error) {
        return res.status(500).json({
            mensaje: 'Ha ocurrido un error al actualizar el cliente.',
            error: error
        });
    }   res.json({
        idCliente: id,
        nombre,
        direccion,
        telefono,
        email
    });
};