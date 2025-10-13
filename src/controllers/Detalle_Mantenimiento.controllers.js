import { pool } from '../../db_connection.js';

// Obtener todas las Detalle_Mantenimiento

export const obtenerDetalle_Mantenimiento = async (req, res) => {
    try {
        const [result] = await pool.query('SELECT * FROM Detalle_Mantenimiento');
        res.json(result);
    } catch (error) {
        return res.status(500).json({
            mensaje: 'Ha ocurrido un error al leer los datos.',
            error: error
        });
    }
};



// Obtener una mantenimiento por su ID
export const obtenerDetalle_Mantenimientos = async (req, res) => {
try {
    const id_Detalle_Mantenimiento = req.params.id_Detalle_Mantenimiento;
const [result] = await pool.query('SELECT * FROM Detalle_Mantenimiento WHERE id_Detalle_Mantenimiento = ?', [id_Detalle_Mantenimiento]);
if (result.length <= 0) {
return res.status(404).json({
mensaje: `Error al leer los datos. ID ${id_Detalle_Mantenimiento} no encontrado.`
});
}
res.json(result[0]);
} catch (error) {
return res.status(500).json({
mensaje: 'Ha ocurrido un error al leer los datos de los Detalle_Mantenimiento.'
});
}
};

// Registrar un nueva Detalle_Mantenimiento
export const registrarDetalle_Mantenimiento = async (req, res) => {
try {
const {   Id_Mantenimiento ,  Id_Empleado ,  Id_Coche , Observaciones , Recomendaciones , Partes_Cambiadas } = req.body;
const [result] = await pool.query(
'INSERT INTO Detalle_Mantenimiento (    Id_Mantenimiento ,  Id_Empleado ,  Id_Coche , Observaciones , Recomendaciones , Partes_Cambiadas) VALUES (?, ?,?,?,?,?)',
[   Id_Mantenimiento ,  Id_Empleado ,  Id_Coche , Observaciones , Recomendaciones , Partes_Cambiadas]
);
res.status(201).json({ id_Detalle_Mantenimiento: result.insertId });
} catch (error) {
return res.status(500).json({
mensaje: 'Ha ocurrido un error al registrar las Detalle_Mantenimiento.',
error: error
});
}
};

// Eliminar Mantenimiento por id 
export const eliminarDetalle_Mantenimiento = async (req, res)=> {
    try{
        const id_Detalle_Mantenimiento = req.params.id_Detalle_Mantenimiento;
        const [result] = await pool.query('DELETE FROM Detalle_Mantenimiento WHERE id_Detalle_Mantenimiento = ?',[id_Detalle_Mantenimiento]);

        if (result.affectedRows === 0 ){
            return res.status(404).json({
            mensaje: `Error al eliminar la Detalle_Mantenimiento. el ID ${id_Detalle_Mantenimiento} no fue encontrado.`
        });
    }

    //respuesta sin contenido para indicar exito
res.status(204).send();
}catch (error){
    return res.status(500).json({
        mensaje: 'Ha ocurrido un error al eliminar el Detalle_Mantenimiento.',
        error: error
    });
}
};


// controlador para actualizar parcialmente una Detalle_Matenimiento por su ID
export const actualizarDetalle_Mantenimiento = async (req, res) => {
    try {
        const {id_Detalle_Mantenimiento} = req.params;
        const datos = req.body;

        const [result] = await pool.query(
            'UPDATE Detalle_Mantenimiento SET ? WHERE id_Detalle_Mantenimiento = ?',
            [datos, id_Detalle_Mantenimiento]
        );
        if (result.affectedRows === 0){
            return res.status(404).json({
                mensaje: `Detalle_Mantenimiento con ID ${id_Detalle_Mantenimiento} no encotrado.`
            });
        }
        res.status(200).json({
            mensaje: `Detalle_Mantenimiento con ID ${id_Detalle_Mantenimiento} actualizada exitosamente.`
        });
    } catch (error) {
        return res.status(500).json({
            mensaje: 'Ha ocurrido un error al actualizar el Detalle_Mantenimiento.',
            error: error
        });
    }
};