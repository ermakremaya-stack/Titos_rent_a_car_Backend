import { Router } from 'express';
import { obtenerDetalle_Alquiler } from '../controllers/Detalle_Alquiler.controllers.js';

const router = Router();

// Rutas
router.get('/Detalle_Alquiler', obtenerDetalle_Alquiler);
export default router;