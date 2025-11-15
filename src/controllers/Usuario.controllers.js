import { pool } from '../../db_connection.js';
import nodemailer from 'nodemailer';
import bcrypt from 'bcrypt';

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
  }
};



export const loginUsuario = async (req, res) => {
  try {
    const { Email, Contrasena } = req.body;  

    //Aseguramos de mandar un mensaje para que el correo y la contraseña esten
    if (!Email || !Contrasena) {
    return res.status(400).json({ 
      success: false, 
      message: "Faltan correo o contraseña" 
    });
  }

    const [result] = await pool.query(
      'SELECT * FROM Usuario WHERE Email = ?',
      [Email]
    );

    if (result.length === 0) {
      return res.status(401).json({ 
        success: false, 
        message: "Correo o contraseña incorrectos" 
      });
    }

    const usuario = result[0];

    // HÍBRIDO: INTENTAR CON BCRYPT, SI FALLA → TEXTO SIMPLE
    let match = false;

    const esEncriptada = usuario.Contrasena?.startsWith("$2b$") || usuario.Contrasena?.startsWith("$2a$");
    if (esEncriptada){
      match = await bcrypt.compare(Contrasena, usuario.Contrasena);
    }

    // 2. SI NO → COMPARAR TEXTO PLANO
    if (!match && usuario.Contrasena === Contrasena) {
      match = true;
    }

    if (!match) {
      return res.status(401).json({ 
        success: false, 
        message: "Correo o contraseña incorrectos" 
      });
    }

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




export const crearUsuario = async (req, res) => {
  const { 
    Cedula, Nombre1, Nombre2, Apellido1, Apellido2, 
    Telefono, Direccion, Email, Licencia, Contrasena 
  } = req.body;

  // Validación
  if (!Cedula || !Nombre1 || !Apellido1 || !Telefono || !Direccion || !Email || !Licencia || !Contrasena) {
    return res.status(400).json({ success: false, message: "Faltan campos obligatorios" });
  }

  try {
    // 1. Hash de contraseña (60 caracteres)
    const hashedPassword = await bcrypt.hash(Contrasena, 10);

    // 2. Insertar en tabla Usuario (Rol fijo: "Usuario")
    const [result] = await pool.query(
      `INSERT INTO Usuario 
      (ROL, Cedula, Nombre1, Nombre2, Apellido1, Apellido2, Telefono, Direccion, Email, Licencia, Contrasena) 
      VALUES ('Usuario', ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`,
      [Cedula, Nombre1, Nombre2, Apellido1, Apellido2, Telefono, Direccion, Email, Licencia, hashedPassword]
    );

    res.json({ 
      success: true, 
      message: "Usuario creado con éxito", 
      Id_Usuario: result.insertId 
    });

  } catch (error) {
    console.error("Error:", error);
    if (error.code === 'ER_DUP_ENTRY') {
      return res.status(400).json({ success: false, message: "El email ya está registrado" });
    }
    res.status(500).json({ success: false, message: "Error del servidor" });
  }
};

// Actualizar usuario por ID 
export const actualizarUsuario = async (req, res) => {
  try {
    const Id_Usuario = req.params.Id_Usuario;
    const { Cedula, Rol, Nombre1, Nombre2, Apellido1, Apellido2, Telefono, Direccion, Email, Licencia, Contrasena } = req.body;
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
  } catch (error) {
    return res.status(500).json({
      mensaje: 'Ha ocurrido un error al actualizar el usuario.',
      error: error
    });
  } res.json({
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


// ===== RECUPERAR CONTRASEÑA (AL FINAL DEL ARCHIVO) =====
export const recuperarContrasena = async (req, res) => {
  const { Email } = req.body;

  if (!Email) {
    return res.status(400).json({ success: false, message: "Falta el correo" });
  }

  try {
    // 1. Buscar usuario
    const [result] = await pool.query('SELECT * FROM Usuario WHERE Email = ?', [Email]);
    if (result.length === 0) {
      return res.status(404).json({ success: false, message: "Correo no encontrado" });
    }

    const usuario = result[0];

    // 2. Generar nueva contraseña
    const nuevaContrasena = Math.random().toString(36).slice(-8);

    // 3. Actualizar en BD
    await pool.query('UPDATE Usuario SET Contrasena = ? WHERE Email = ?', [nuevaContrasena, Email]);

    // 4. Enviar email
    const transporter = nodemailer.createTransport({
      service: 'gmail',
      auth: {
        user: process.env.EMAIL_USER,
        pass: process.env.EMAIL_PASS
      }
    });

    await transporter.sendMail({
      from: '"TitosRentACar" <titosrentacar@gmail.com>',
      to: Email,
      subject: "Recuperación de Contraseña - TitosRentACar",
      html: `
        <div style="font-family: Arial, sans-serif; max-width: 600px; margin: auto; padding: 20px; border: 1px solid #ddd; border-radius: 10px;">
          <h2 style="color: #8B4513; text-align: center;">Tito's Rent a Car</h2>
          <h3>¡Hola, ${usuario.Nombre1}!</h3>
          <p>Solicitaste recuperar tu contraseña. Aquí está tu nueva contraseña:</p>
          <div style="background: #f0f0f0; padding: 15px; text-align: center; font-size: 18px; font-weight: bold; border-radius: 5px; margin: 20px 0;">
            ${nuevaContrasena}
          </div>
          <p><strong>Recomendación:</strong> Inicia sesión y cámbiala por una segura.</p>
          <p style="text-align: center;">
            <a href="http://localhost:5173/inicio" style="background: #8B4513; color: white; padding: 10px 20px; text-decoration: none; border-radius: 5px;">
              Ir al Login
            </a>
          </p>
          <hr>
          <p style="font-size: 12px; color: #777; text-align: center;">
            Este es un mensaje automático. No respondas.
          </p>
        </div>
      `
    });

    res.json({ success: true, message: "¡Contraseña enviada al correo!" });
  } catch (error) {
    console.error("Error al enviar email:", error);
    res.status(500).json({ success: false, message: "Error al enviar email" });
  }
};