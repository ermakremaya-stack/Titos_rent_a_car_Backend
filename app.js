//Importar las dependencias necesarias
import express from 'express';
import cors from 'cors';

//Importar las rutas
import rutasAlquiler from './routes/Alquiler.routes.js';
import rutasCliente from './routes/Cliente.routes.js';
import rutasCoche from './routes/Coche.routes.js';
import rutasDetalleAlquiler from './routes/DetalleAlquiler.routes.js';
import rutasDetalleMantenimiento from './routes/DetalleMantenimiento.routes.js';
import rutasEmpleado from './routes/Empleado.routes.js';
import rutasMantenimiento from './routes/Mantenimiento.routes.js';

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

//Rotas;
app.use('/api', rutasAlquiler);
app.use('/api', rutasCliente);
app.use('/api', rutasCoche);
app.use('/api', rutasDetalleAlquiler);
app.use('/api', rutasDetalleMantenimiento);
app.use('/api', rutasEmpleado);
app.use('/api', rutasMantenimiento);

// Manejo de rutas no encontradas
app.use((req, res, next) => {
    res.status(484).json({
        message: 'La ruta que ha especificado no se encuentra registrada.'
    });
});

// Exportar la aplicación
export default app;