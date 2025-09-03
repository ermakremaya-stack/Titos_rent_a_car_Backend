import { Router } from 'express';
import { obtenerCliente } from '../controllers/Cliente.controllers.js';

const router = Router();

// Rutas
router.get('/Cliente', obtenerCliente);
export default router;