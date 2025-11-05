import { Router } from 'express';
import { obtenerMantenimientos, obtenerMantenimiento, registrarMantenimiento, eliminarMantenimiento, actualizarMantenimiento} from '../controllers/Mantenimiento.controllers.js';

const router = Router();

// Ruta para obtener todas las Mantenimiento
router.get('/Mantenimientos', obtenerMantenimientos);

// ruta para obtener una Mantenimiento por su ID
router.get('/Mantenimiento/:Id', obtenerMantenimiento);

// Ruta para registrar una nueva Mantenimiento
router.post('/Mantenimiento', registrarMantenimiento);

// ruta para eliminar una Mantenimiento por ID
router.delete('/Mantenimiento/:Id_Mantenimiento', eliminarMantenimiento);

// Ruta para actualizar una Mantenimiento por su ID
router.patch('/actualizarMantenimiento/:Id_Mantenimiento', actualizarMantenimiento);

export default router;


