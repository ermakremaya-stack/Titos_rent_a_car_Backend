import { Router } from 'express';
import { obtenerEmpleado } from '../controllers/Empleado.controllers.js';

const router = Router();

// Rutas
router.get('/Empleado', obtenerEmpleado);
export default router;