import { Router } from 'express';
import {
  obtenerMantenimientos,
  obtenerMantenimiento,
  registrarMantenimiento,
  eliminarMantenimiento,
  actualizarMantenimiento
} from '../controllers/Mantenimiento.controllers.js';

const router = Router();

// Obtener todos los mantenimientos
router.get('/mantenimientos', obtenerMantenimientos);

// Obtener un mantenimiento por ID
router.get('/mantenimientos/:id', obtenerMantenimiento);

// Registrar un nuevo mantenimiento
router.post('/mantenimientos', registrarMantenimiento);

// Eliminar un mantenimiento por ID
router.delete('/mantenimientos/:Id_Mantenimiento', eliminarMantenimiento);

// Actualizar un mantenimiento por ID
router.patch('/mantenimientos/:id', actualizarMantenimiento);

export default router;
