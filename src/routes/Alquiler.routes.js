import { Router } from 'express';
import { actualizarAlquiler, eliminarAlquiler, obtenerAlquiler, obtenerAlquileres, registrarAlquiler } from '../controllers/Alquiler.controllers.js';

const router = Router();

// Rutas
router.get('/Alquileres', obtenerAlquileres);

// Ruta para obtener un alquiler por su ID
router.get('/Alquiler/:Id_Alquiler', obtenerAlquiler);

// Ruta para registrar un nuevo alquiler
router.post('/registrarAlquiler', registrarAlquiler);

// Ruta para eliminar un Alquiler por su ID
router.delete('/eliminarAlquiler/:Id_Alquiler', eliminarAlquiler);

// Ruta para actualizar un Alquiler por su ID
router.patch('/actualizarAlquiler/:Id_Alquiler', actualizarAlquiler);

export default router;

