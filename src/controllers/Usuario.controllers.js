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
        const [result] = await pool.query('SELECT * FROM Usuario WHERE Id_Usuario = ?', [req.params.Id_Usuario]);
        if (result.length <= 0) {
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



export const loginUsuario = async (req, res) => {
    try {
        const { Email, Contrasena } = req.body;  // ← VIENE DEL BODY

        const [result] = await pool.query(
            'SELECT Id_Usuario, Nombre1, Apellido1, Email, ROL FROM Usuario WHERE Email = ? AND Contrasena = ?',
            [Email, Contrasena]
        );

        if (result.length === 0) {
            return res.status(401).json({
                success: false,
                message: "Usuario o contraseña incorrectos"
            });
        }

        const usuario = result[0];

        res.json({
            success: true,
            usuario: {
                id: usuario.Id_Usuario,
                nombre: `${usuario.Nombre1} ${usuario.Apellido1}`,
                email: usuario.Email,
                rol: usuario.ROL
            }
        });

    } catch (error) {
        res.status(500).json({ success: false, message: "Error" });
    }
};





// Crear nueva usuario
export const crearUsuario = async (req, res) => {
    try {
        const {Cedula, Rol, Nombre1, Nombre2, Apellido1, Apellido2, Telefono, Direccion, Email, Licencia, Contrasena} = req.body;
        const [result] = await pool.query('INSERT INTO Usuario (Cedula, Rol, Nombre1, Nombre2, Apellido1, Apellido2, Telefono, Direccion, Email, Licencia, Contrasena) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
            [Cedula, Rol, Nombre1, Nombre2, Apellido1, Apellido2, Telefono, Direccion, Email, Licencia, Contrasena]);
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
            Licencia,
            Contrasena
        });
    } catch (error) {
        return res.status(500).json({
            mensaje: 'Ha ocurrido un error al crear el usuario nuevo.',
            error: error
        });
    } };

// Actualizar usuario por ID 
export const actualizarUsuario = async (req, res) => {
    try {
        const Id_Usuario = req.params.Id_Usuario;
        const {Cedula, Rol, Nombre1, Nombre2, Apellido1, Apellido2, Telefono, Direccion, Email, Licencia, Contrasena} = req.body;
        const [result] = await pool.query(
            'UPDATE Usuario SET Cedula = ?, Rol = ?, Nombre1 = ?, Nombre2 = ?, Apellido1 = ?, Apellido2 = ?, Telefono = ?, Direccion = ?, Email = ?, Licencia = ?, Contrasena = ? WHERE Id_Usuario = ?',
            [Cedula, Rol, Nombre1, Nombre2, Apellido1, Apellido2, Telefono, Direccion, Email, Licencia, Contrasena, Id_Usuario]);
        if (result.affectedRows === 0) {
            return res.status(404).json({
                mensaje: 'Usuario no encontrado.'
            });
        } 
        res.status(200).json({
            mensaje: `Usuario con ID ${Id_Usuario} actualizado exitosamente.`
        });
        }catch (error) {
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
        Licencia,
        Contrasena
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