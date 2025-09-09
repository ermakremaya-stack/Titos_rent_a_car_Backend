import { Router } from 'express';
import { obtenerCoches, obtenerCoche, registrarCoche } from '../controllers/Coche.controllers.js';

const router = Router();

// Rutas
router.get('/Coche', obtenerCoches);
router.get('/Coche/:Id_Coche', obtenerCoche);
router.post('/registrarCoche', registrarCoche);

export default router;