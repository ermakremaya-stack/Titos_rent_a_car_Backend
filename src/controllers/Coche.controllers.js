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
    const { marca, modelo, anio, placa, color} = req.body;
    await pool.query(
      'CALL InsertarCoche (?, ?, ?, ?, ?); ',
      [marca, modelo, anio, placa, color],
    );
    res.status(201).json({ mensaje: 'Coche registrado exitosamente.' });
  } catch (error) {
    return res.status(500).json({
      mensaje: 'Ha ocurrido un error al registrar el coche.',
      error: error
    });
  }
};


// Eliminar un coche por su ID
export const eliminarCoche = async (req, res) => {
  try {
    const [result] = await pool.query('CALL EliminarCoche(?)', [req.params.Id_Coche]);

    if (result.affectedRows <= 0) {
      return res.status(404).json({
        mensaje: `Error al eliminar. ID ${req.params.Id_Coche} no encontrado.`
      });
    }
    //Respuesta exitosa
    res.status(200).json({ mensaje: `Coche con ID ${req.params.Id_Coche} eliminado exitosamente.` });
    
  } catch (error) {
    return res.status(500).json({
      mensaje: 'Ha ocurrido un error al eliminar el coche.',
      error: error
    });
  }
};

// Actualizar un coche por su ID
export const actualizarCoche = async (req, res) => {
  try {
    const Id_Coche = req.params.Id_Coche;
    const { marca, modelo, anio, placa, color } = req.body;

    const [result] = await pool.query(
      'CALL ActualizarCoche (?, ?, ?, ?, ?, ?);',
      [Id_Coche, marca, modelo, anio, placa, color]
    );
    if (result.affectedRows === 0) {
      return res.status(404).json({
        mensaje: `Error al actualizar el coche. El ID ${Id_Coche} no fue encontrado.`
      });
    }
    res.status(200).json({
      mensaje: `Coche con ID ${Id_Coche} actualizado exitosamente.`
    });
  } catch (error) {
    return res.status(500).json({
      mensaje: "Ha ocurrido un error al actualizar el coche.",
      error: error
    });
  }
};
