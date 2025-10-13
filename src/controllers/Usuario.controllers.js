import { pool } from '../../db_connection.js';

// Obtener todos lo usuario

export const obtenerUsuario = async (req, res) => {
    try {
        const [result] = await pool.query('SELECT * FROM Usuario');
        res.json(result);
    } catch (error) {
        return res.status(500).json({
            mensaje: 'Ha ocurrido un error al leer los datos.',
            error: error
        });
    }
};

// Obtener usuario por ID

export const obtenerUsuarioPorId = async (req, res) => {
    try {
        const { id } = req.params;
        const [result] = await pool.query('SELECT * FROM Usuario WHERE Id_Usuario = ?', [id]);
        if (result.length === 0) {
            return res.status(404).json({
                mensaje: 'Usuario no encontrado.'
            });
        }
        res.json(result[0]);
    } catch (error) {
        return res.status(500).json({
            mensaje: 'Ha ocurrido un error al leer los datos.',
            error: error
        });
    } };

// Crear nueva usuario
export const crearUsuario = async (req, res) => {
    try {
        const {Cedula, Rol, Nombre1, Nombre2, Apellido1, Apellido2, Telefono, Direccion, Email, Licencia} = req.body;
        const [result] = await pool.query('INSERT INTO Usuario (Cedula, Rol, Nombre1, Nombre2, Apellido1, Apellido2, Telefono, Direccion, Email, Licencia) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
            [Cedula, Rol, Nombre1, Nombre2, Apellido1, Apellido2, Telefono, Direccion, Email, Licencia]);
        res.json({
            Id_Usuario: result.insertId,
            Rol,
            Cedula,
            Nombre1,
            Nombre2,
            Apellido1,
            Apellido2,
            Telefono,
            Direccion,
            Email,
            Licencia
        });
    } catch (error) {
        return res.status(500).json({
            mensaje: 'Ha ocurrido un error al crear el usuario nuevo.',
            error: error
        });
    } };

// Actualizar usuario por ID 
export const actualizarCliente = async (req, res) => {
    try {
        const { id } = req.params;
        const {Cedula, Rol, Nombre1, Nombre2, Apellido1, Apellido2, Telefono, Direccion, Email, Licencia} = req.body;
        const [result] = await pool.query('UPDATE Usuario SET Cedula = ?, Rol = ?, Nombre1 = ?, Nombre2 = ?, Apellido1 = ?, Apellido2 = ?, Telefono = ?, Direccion = ?, Email = ?, Licencia = ? WHERE Id_Usuario = ?',
            [Cedula, Rol, Nombre1, Nombre2, Apellido1, Apellido2, Telefono, Direccion, Email, Licencia, id]);
        if (result.affectedRows === 0) {
            return res.status(404).json({
                mensaje: 'Usuario no encontrado.'
            });
        } } catch (error) {
        return res.status(500).json({
            mensaje: 'Ha ocurrido un error al actualizar el usuario.',
            error: error
        });
    }   res.json({
        Id_Usuario,
        Rol,
        Cedula,
        Nombre1,
        Nombre2,
        Apellido1,
        Apellido2,
        Telefono,
        Direccion,
        Email,
        Licencia
    });
};

// Eliminar usuario por ID
export const eliminarUsuario = async (req, res) => {
    try {
        const [result] = await pool.query('DELETE FROM Usuario WHERE Id_Usuario = ?', [req.params.Id_Usuario]);
        if (result.affectedRows <= 0) {
            return res.status(404).json({
                mensaje: `Error al eliminar. ID ${req.params.Id_Usuario} no encontrado.`
            });
        }
        //Respueesta exitosa
        res.sendStatus(204).send();
    } catch (error) {
        return res.status(500).json({
            mensaje: 'Ha ocurrido un error al eliminar el Usuario.',
            error: error
        });
    }
};