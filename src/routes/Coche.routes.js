import { Router } from 'express';
import { obtenerCoches } from '../controllers/Coche.controllers.js';

const router = Router();

// Rutas
router.get('/Coche', obtenerCoches);
export default router;