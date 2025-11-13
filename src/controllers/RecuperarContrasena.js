// controllers/Usuario.controllers.js
import nodemailer from 'nodemailer';
import { pool } from '../../db_connection.js';

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
    const hashed = nuevaContrasena; // ¡EN PRODUCCIÓN: USA BCRYPT!

    // 3. Actualizar en BD
    await pool.query('UPDATE Usuario SET Contrasena = ? WHERE Email = ?', [hashed, Email]);

    // 4. Enviar email
    const transporter = nodemailer.createTransport({
      service: 'gmail',
      auth: {
        user: 'titosrentacar@gmail.com',     // ← TU CORREO
        pass: 'tu-app-password-aqui'         // ← APP PASSWORD (NO TU CONTRASEÑA NORMAL)
      }
    });

    await transporter.sendMail({
      from: '"Tito\'s Rent a Car" <titosrentacar@gmail.com>',
      to: Email,
      subject: "Recuperación de Contraseña",
      html: `
        <h3>¡Hola, ${usuario.Nombre1}!</h3>
        <p>Tu nueva contraseña es:</p>
        <h2><strong>${nuevaContrasena}</strong></h2>
        <p>Inicia sesión y cámbiala por una segura.</p>
        <a href="http://localhost:5173/inicio">Ir al login</a>
      `
    });

    res.json({ success: true, message: "Contraseña enviada al correo" });
  } catch (error) {
    console.error(error);
    res.status(500).json({ success: false, message: "Error al enviar email" });
  }
};