import { Router } from 'express';
import { obtenerMantenimiento } from '../controllers/Mantenimiento.controllers.js';

const router = Router();

// Rutas
router.get('/Mantenimiento', obtenerMantenimiento);
export default router;