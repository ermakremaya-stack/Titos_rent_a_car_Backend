import { Router } from 'express';
import { obtenerEmpleados, obtenerEmpleado, registrarEmpleado } from '../controllers/Empleado.controllers.js';

const router = Router();

// Rutas
router.get('/Empleado', obtenerEmpleados);

// Ruta para obtener un cliente por su ID
router.get('/Empleados/:Id_Empleado', obtenerEmpleado);

// Ruta para registrar una nueva Categoría
router.post('/registrarEmpleado', registrarEmpleado);

export default router;