Este repositorio contiene la práctica integradora de Robótica Móvil, donde se implementa la simulación de un robot diferencial utilizando:
- Cinemática directa  
- Cinemática inversa  
- Control cinemático  

Se comparan los resultados obtenidos con y sin saturación de actuadores, mostrando gráficas, animaciones y métricas de desempeño.

# Contenido
- `/codigo/` → Scripts en MATLAB (`.m`) para cada método y la simulación completa.  
- `/evidencias/` → Imágenes de las gráficas y animación (`.gif`).  
- `README.md` → Documento explicativo con tabla comparativa y conclusiones.  

# Parámetros principales
- Radio de rueda: 0.08 m  
- Distancia entre ruedas: 0.35 m  
- Tiempo de simulación: 20 s  
- Paso de integración: 0.02 s  
- Velocidad angular máxima de rueda: 18 rad/s  
- Ganancias del controlador: k_p = 1.0, k_θ = 2.0  
- Tolerancia de llegada: 0.05 m  
- Punto objetivo: (2.5, 1.5) m  

# Instrucciones de ejecución
1. Clonar o descargar este repositorio en la computadora.
