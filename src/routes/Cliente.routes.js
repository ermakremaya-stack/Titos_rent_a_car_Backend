import { Router } from 'express';
import { obtenerCliente } from '../controllers/Cliente.controllers.js';

const router = Router();

// Rutas
router.get('/Cliente', obtenerCliente);
export default router;

//rutas cliente por id
router.get('/Cliente/:id_cliente', obtenerCliente);

//rutas para registrar un nuevo cliente
router.post('/Cliente', obtenerCliente);