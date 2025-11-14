// routes/empleado.routes.js (o donde esté)
import { Router } from 'express';
import { 
  obtenerEmpleados, 
  obtenerEmpleado, 
  registrarEmpleado, 
  eliminarEmpleado, 
  actualizarEmpleado,
  loginEmpleado
} from '../controllers/Empleado.controllers.js';

const router = Router();

// CORRECTO: Usa /Empleado (singular) o /empleados (plural minúscula)
// Recomendado: /empleados (RESTful)
router.get('/empleados', obtenerEmpleados);           // ← Cambiado
router.get('/empleados/:Id_Empleado', obtenerEmpleado);
router.post('/loginempleado', loginEmpleado);
router.post('/registrarEmpleado', registrarEmpleado);
router.delete('/empleados/:Id_Empleado', eliminarEmpleado);     // ← Cambiado
router.patch('/empleados/:Id_Empleado', actualizarEmpleado);   // ← Cambiado

export default router;