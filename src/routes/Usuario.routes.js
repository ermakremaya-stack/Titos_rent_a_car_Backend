import { Router } from 'express';
import { obtenerUsuario, obtenerUsuarioPorId, crearUsuario, eliminarUsuario, actualizarUsuario} from '../controllers/Usuario.controllers.js';

const router = Router();

// Rutas
router.get('/Usuarios', obtenerUsuario);
export default router;

//rutas usuario por id
router.get('/Usuario/:Id_Usuario', obtenerUsuarioPorId);

//rutas para registrar un nuevo usuario
router.post('/Usuario', crearUsuario);

//rutas para actualizar un usuario
router.patch('/Usuario/:Id_Usuario', actualizarUsuario);

//rutas para eliminar un usuario
router.delete('/Usuario/:Id_Usuario', eliminarUsuario);