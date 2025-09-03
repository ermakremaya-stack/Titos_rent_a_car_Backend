import { Router } from 'express';
import { obtenerAlquiler } from '../controllers/Alquiler.controllers.js';

const router = Router();

// Rutas
router.get('/Alquiler', obtenerAlquiler);
export default router;