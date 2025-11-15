import { pool } from '../../db_connection.js';

// Obtener todas los empleado 

export const obtenerEmpleados = async (req, res) => {
  try {
    const [result] = await pool.query('SELECT * FROM Empleado');
    res.json(result);
  } catch (error) {
    return res.status(500).json({
      mensaje: 'Ha ocurrido un error al leer los datos.',
      error: error
    });
  }
}

// Obtener un empleado por su ID
export const obtenerEmpleado = async (req, res) => {
  try {
    const Id_Empleado = req.params.Id_Empleado;
    const [result] = await pool.query('SELECT * FROM Empleado WHERE  Id_Empleado = ?', [Id_Empleado]);
    if (result.length <= 0) {
      return res.status(404).json({
        mensaje: `Error al leer los datos. ID ${Id_Empleado} no encontrado.`
      });
    }
    res.json(result[0]);
  } catch (error) {
    return res.status(500).json({
      mensaje: 'Ha ocurrido un error al leer los datos de las empleado.'
    });
  }
};

// Registrar un nueva empleado
export const registrarEmpleado = async (req, res) => {
  try {
    const {
      Rol,
      Cedula,
      Nombre1,
      Nombre2,
      Apellido1,
      Apellido2,
      Direccion,
      Email,
      Contrasena
    } = req.body;
    const [result] = await pool.query(
      'INSERT INTO Empleado (Rol, Cedula, Nombre1, Nombre2, Apellido1, Apellido2, Direccion, Email, Contrasena) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)',
      [ Rol,
        Cedula,
        Nombre1,
        Nombre2,
        Apellido1,
        Apellido2,
        Direccion,
        Email,
        Contrasena]
    );
    res.status(201).json({ Id_Empleado: result.insertId });
  } catch (error) {
    return res.status(500).json({
      mensaje: 'Ha ocurrido un error al registrar lempleado empleado.',
      error: error
    });
  }
};

// Eliminar un Empleado por su ID
export const eliminarEmpleado = async (req, res) => {
  try {
    const [result] = await pool.query('DELETE FROM Empleado WHERE Id_Empleado = ?', [req.params.Id_Empleado]);
    if (result.affectedRows <= 0) {
      return res.status(404).json({
        mensaje: `Error al eliminar. ID ${req.params.Id_Empleado} no encontrado.`
      });
    }
    //Respueesta exitosa
    res.sendStatus(204).send();
  } catch (error) {
    return res.status(500).json({
      mensaje: 'Ha ocurrido un error al eliminar el Empleado.',
      error: error
    });
  }
};

// Actualizar una Empleado por su ID
export const actualizarEmpleado = async (req, res) => {
  try {
    const Id_Empleado = req.params.Id_Empleado;
    const {Rol, Cedula, Nombre1, Nombre2, Apellido1, Apellido2, Direccion, Email, Contrasena } = req.body;

    const [result] = await pool.query(
      'UPDATE Empleado SET Rol = ?, Cedula = ?, Nombre1 = ?, Nombre2 = ?, Apellido1 = ?, Apellido2 = ?, Direccion = ?, Email = ?, Contrasena = ? WHERE Id_Empleado = ?',
      [Rol, Cedula, Nombre1, Nombre2, Apellido1, Apellido2, Direccion, Email, Contrasena, Id_Empleado]
    );
    if (result.affectedRows === 0) {
      return res.status(404).json({
        mensaje: `Error al actualizar el empleado. El ID ${Id_Empleado} no fue encontrado.`
      });
    }
    res.status(200).json({
      mensaje: `Empleado con ID ${Id_Empleado} actualizado exitosamente.`
    });
  } catch (error) {
    return res.status(500).json({
      mensaje: "Ha ocurrido un error al actualizar el empleado.",
      error: error
    });
  }
};





export const loginEmpleado = async (req, res) => {
  try {
    const { Email, Contrasena } = req.body;

    const [result] = await pool.query(
      'SELECT Id_Empleado, Nombre1, Apellido1, Email, ROL FROM Empleado WHERE Email = ? AND Contrasena = ?',
      [Email, Contrasena]
    );

    if (result.length === 0) {
      return res.status(401).json({
        success: false,
        message: "Usuario o contraseña incorrectos"
      });
    }

    const empleado = result[0];

    res.json({
      success: true,
      usuario: {
        id: empleado.Id_Empleado,
        nombre: `${empleado.Nombre1} ${empleado.Apellido1}`,
        email: empleado.Email,
        rol: empleado.ROL
      }
    });

  } catch (error) {
    res.status(500).json({ success: false, message: "Error" });
  }
};