import { Router } from 'express';
import { obtenerUsuario, obtenerUsuarioPorId, crearUsuario, eliminarUsuario, actualizarUsuario, loginUsuario} from '../controllers/Usuario.controllers.js';

const router = Router();

// Rutas
router.get('/usuarios', obtenerUsuario);


//rutas usuario por id
router.get('/usuarios/:Id_Usuario', obtenerUsuarioPorId);

router.get('/loginusuario/:Email/:Contrasena', loginUsuario);

//rutas para registrar un nuevo usuario
router.post('/registrarusuarios', crearUsuario);

//rutas para actualizar un usuario
router.patch('/usuarios/:Id_Usuario', actualizarUsuario);

//rutas para eliminar un usuario
router.delete('/usuarios/:Id_Usuario', eliminarUsuario);

export default router;