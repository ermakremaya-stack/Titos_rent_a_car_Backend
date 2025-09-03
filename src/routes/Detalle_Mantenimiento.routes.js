import { Router } from 'express';
import { obtenerDetalle_Mantenimiento } from '../controllers/Detalle_Mantenimiento.controllers.js';

const router = Router();

// Rutas
router.get('/Detalle_Mantenimiento', obtenerDetalle_Mantenimiento);
export default router;