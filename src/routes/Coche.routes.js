import { Router } from 'express';
import { obtenerCoches, obtenerCoche, registrarCoche, eliminarCoche } from '../controllers/Coche.controllers.js';

const router = Router();

// Rutas para realizar operaciones CRUD en la tabla Coche
router.get('/Coche', obtenerCoches);
router.get('/Coche/:Id_Coche', obtenerCoche);
router.post('/registrarCoche', registrarCoche);
router.delete('/eliminarcoche/:Id_Coche', eliminarCoche);

export default router;