import { pool } from '../../db_connection.js';

// Obtener todas las Mantenimiento

export const obtenerMantenimientos = async (req, res) => {
    try {
        const [result] = await pool.query('SELECT * FROM Mantenimiento');
        res.json(result);
    } catch (error) {
        return res.status(500).json({
            mensaje: 'Ha ocurrido un error al leer los datos.',
            error: error
        });
    }
};


// Obtener una mantenimiento por su ID
export const obtenerMantenimiento = async (req, res) => {
try {
    const Id_Mantenimiento = req.params.Id_Mantenimiento;
const [result] = await pool.query('SELECT * FROM Mantenimiento WHERE id_Mantenimiento = ?', [Id_Mantenimiento]);
if (result.length <= 0) {
return res.status(404).json({
mensaje: `Error al leer los datos. ID ${Id_Mantenimiento} no encontrado.`
});
}
res.json(result[0]);
} catch (error) {
return res.status(500).json({
mensaje: 'Ha ocurrido un error al leer los datos de los Mantenimiento.'
});
}
};


// Registrar un nueva Mantenimiento
export const registrarMantenimiento = async (req, res) => {
try {
const {  Descripcion, Justificacion, Fecha_Inicio, Fecha_Fin, Costo } = req.body;
const [result] = await pool.query(
'INSERT INTO Mantenimiento ( Descripcion,Justificacion,Fecha_Inicio,Fecha_Fin,Costo) VALUES (?,?,?,?,?)',
[ Descripcion, Justificacion, Fecha_Inicio, Fecha_Fin, Costo]
);
res.status(201).json({ Id_Mantenimiento: result.insertId });
} catch (error) {
return res.status(500).json({
mensaje: 'Ha ocurrido un error al registrar los Mantenimiento.',
error: error
});
}
};

// Eliminar Mantenimiento por id 
export const eliminarMantenimiento = async (req, res)=> {
    try{
        const Id_Mantenimiento = req.params.Id_Mantenimiento;
        const [result] = await pool.query('DELETE FROM Mantenimiento WHERE Id_Mantenimiento = ?',[Id_Mantenimiento]);

        if (result.affectedRows === 0 ){
            return res.status(404).json({
            mensaje: `Error al eliminar la Mantenimiento. el ID ${Id_Mantenimiento} no fue encontrado.`
        });
    }

    //respuesta sin contenido para indicar exito
res.status(204).send();
}catch (error){
    return res.status(500).json({
        mensaje: 'Ha ocurrido un error al eliminar el Mantenimiento.',
        error: error
    });
}
};


// controlador para actualizar parcialmente una Matenimiento por su ID
export const actualizarMantenimiento = async (req, res) => {
    try {
        const {Id_Mantenimiento} = req.params;
        const datos = req.body;

        const [result] = await pool.query(
            'UPDATE Mantenimiento SET ? WHERE Id_Mantenimiento = ?',
            [datos, Id_Mantenimiento]
        );
        if (result.affectedRows === 0){
            return res.status(404).json({
                mensaje: `Mantenimiento con ID ${Id_Mantenimiento} no encotrado.`
            });
        }
        res.status(200).json({
            mensaje: `Mantenimiento con ID ${Id_Mantenimiento} actualizada exitosamente.`
        });
    } catch (error) {
        return res.status(500).json({
            mensaje: 'Ha ocurrido un error al actualizar el Mantenimiento.',
            error: error
        });
    }
};