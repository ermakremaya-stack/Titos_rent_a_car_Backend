import { Router } from 'express';
import { obtenerEmpleados, obtenerEmpleado, registrarEmpleado, eliminarEmpleado, actualizarEmpleado } from '../controllers/Empleado.controllers.js';

const router = Router();

// Rutas
router.get('/Empleado', obtenerEmpleados);

// Ruta para obtener un cliente por su ID
router.get('/Empleados/:Id_Empleado', obtenerEmpleado);

// Ruta para registrar una nueva Categoría
router.post('/registrarEmpleado', registrarEmpleado);

// Ruta para eliminar un empleado por su ID
router.delete('/eliminarEmpleado/:Id_Empleado', eliminarEmpleado);

// Ruta para actualizar un empleado por su ID
router.patch('/actualizarempleado/:Id_Empleado', actualizarEmpleado);

export default router;