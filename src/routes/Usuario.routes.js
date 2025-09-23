import { Router } from 'express';
import { obtenerUsuario, registrarUsuario, eliminarUsuario} from '../controllers/Usuario.controllers.js';

const router = Router();

// Rutas
router.get('/Usuario', obtenerUsuario);
export default router;

//rutas usuario por id
router.get('/Usuario/:id_Usuario', obtenerUsuario);

//rutas para registrar un nuevo usuario
router.post('/Usuario', registrarUsuario);

//rutas para actualizar un usuario
router.put('/Usuario/:id_Usuario', obtenerUsuario);

//rutas para eliminar un usuario
router.delete('/Usuario/:id_Usuario', eliminarUsuario);