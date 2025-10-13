import { Router } from 'express';
import { obtenerUsuario, obtenerUsuarioPorId, crearUsuario, eliminarUsuario, actualizarCliente} from '../controllers/Usuario.controllers.js';

const router = Router();

// Rutas
router.get('/Usuario', obtenerUsuario);
export default router;

//rutas usuario por id
router.get('/Usuario/:id_Usuario', obtenerUsuarioPorId);

//rutas para registrar un nuevo usuario
router.post('/Usuario', crearUsuario);

//rutas para actualizar un usuario
router.put('/Usuario/:id_Usuario', actualizarCliente);

//rutas para eliminar un usuario
router.delete('/Usuario/:id_Usuario', eliminarUsuario);