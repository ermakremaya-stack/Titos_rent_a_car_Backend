//Importar las dependencias necesarias
import express from 'express';
import cors from 'cors';

//Importar las rutas
import rutasAlquiler from './src/routes/Alquiler.routes.js';
import rutasUsuario from './src/routes/Usuario.routes.js';
import rutasCoche from './src/routes/Coche.routes.js';
import rutasDetalleAlquiler from './src/routes/Detalle_Alquiler.routes.js';
import rutasDetalleMantenimiento from './src/routes/Detalle_Mantenimiento.routes.js';
import rutasEmpleado from './src/routes/Empleado.routes.js';
import rutasMantenimiento from './src/routes/Mantenimiento.routes.js';
// backend/index.js o app.js
import dotenv from 'dotenv';
dotenv.config(); 

// Crear la aplicación de Express
const app = express();

// Habilitar CORS para cualquier origen
app.use(cors({
    methods: ['GET', 'POST', 'PUT', 'DELETE', 'PATCH'],
    allowedHeaders: ['Content-Type'],
}));

//Middleware para parsear el cuerpo de las solicitudes
app.use(express.json({ limit: '10mb' })); //16 MB
app.use(express.urlencoded({ limit: '10mb', extended: true }));

//Rutas;
app.use('/api', rutasAlquiler);
app.use('/api', rutasUsuario);
app.use('/api', rutasCoche);
app.use('/api', rutasDetalleAlquiler);
app.use('/api', rutasDetalleMantenimiento);
app.use('/api', rutasEmpleado);
app.use('/api', rutasMantenimiento);
app.set('appName', 'TitosRentACar');

// Manejo de rutas no encontradas
app.use((req, res, next) => {
    res.status(484).json({
        message: 'La ruta que ha especificado no se encuentra registrada.'
    });
});

// Exportar la aplicación
export default app;