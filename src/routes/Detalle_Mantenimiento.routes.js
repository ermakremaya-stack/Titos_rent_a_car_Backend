import { Router } from 'express';
import {
  obtenerDetalle_Mantenimientos,
  obtenerDetalle_Mantenimiento,
  registrarDetalle_Mantenimiento,
  eliminarDetalle_Mantenimiento,
  actualizarDetalle_Mantenimiento
} from '../controllers/Detalle_Mantenimiento.controllers.js';

const router = Router();

// Obtener todos los detalles de mantenimiento
router.get('/detalles-mantenimiento', obtenerDetalle_Mantenimientos);

// Obtener un detalle de mantenimiento por ID
router.get('/detalles-mantenimiento/:id', obtenerDetalle_Mantenimiento);

// Registrar detalle de mantenimiento
router.post('/detalles-mantenimiento', registrarDetalle_Mantenimiento);

// Actualizar detalle de mantenimiento
router.patch('/detalles-mantenimiento/:id', actualizarDetalle_Mantenimiento);

// Eliminar detalle de mantenimiento
router.delete('/detalles-mantenimiento/:id', eliminarDetalle_Mantenimiento);

export default router;
