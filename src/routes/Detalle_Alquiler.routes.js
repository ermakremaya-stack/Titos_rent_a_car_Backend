import { Router } from 'express';
import { obtenerDetalle_Alquileres, obtenerDetalle_Alquiler, registrarDetalle_Alquiler, eliminarDetalle_Alquiler, actualizarDetalle_Alquiler } from '../controllers/Detalle_Alquiler.controllers.js';

const router = Router();

// Rutas
router.get('/Detalle_Alquiler', obtenerDetalle_Alquileres);

// Ruta para obtener un detalle_alquiler por su ID
router.get('/Detalle_Alquiler/:Id_Detalle_Alquiler', obtenerDetalle_Alquiler);

// Ruta para registrar un nuevo Detalle_Alquiler
router.post('/registrarDetalle_Alquiler', registrarDetalle_Alquiler);

// Ruta para eliminar un Detalle_Alquiler por su ID
router.delete('/eliminarDetalle_Alquiler/:Id_Detalle_Alquiler', eliminarDetalle_Alquiler);

// Ruta para actualizar un Alquiler por su ID
router.patch('/actualizarDetalle_Alquiler/:Id_Detalle_Alquiler', actualizarDetalle_Alquiler);

export default router;