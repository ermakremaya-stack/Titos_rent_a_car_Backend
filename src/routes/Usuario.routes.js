import { Router } from 'express';
import { obtenerUsuario, registrarUsuario, eliminarUsuario } from '../controllers/Usuario.controllers.js';

const router = Router();

// Rutas
router.get('/Cliente', obtenerUsuario);
export default router;

//rutas usuario por id
router.get('/Cliente/:id_cliente', obtenerUsuario);

//rutas para registrar un nuevo usuario
router.post('/Cliente', registrarUsuario);

//rutas para actualizar un usuario
router.put('/Cliente/:id_cliente', obtenerUsuario);

//rutas para eliminar un usuario
router.delete('/Cliente/:id_cliente', eliminarUsuario);