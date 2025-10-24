import { Router } from 'express';
import { obtenerCoches, obtenerCoche, registrarCoche, eliminarCoche, actualizarCoche } from '../controllers/Coche.controllers.js';

const router = Router();

// Rutas para realizar operaciones CRUD en la tabla Coche
router.get('/Coches', obtenerCoches);
router.get('/Coche/:Id_Coche', obtenerCoche);
router.post('/registrarcoche', registrarCoche);
router.delete('/eliminarcoche/:Id_Coche', eliminarCoche);
router.patch('/actualizarcoche/:Id_Coche', actualizarCoche);

export default router;