# Multitask App

Multitask es una aplicación móvil desarrollada con Flutter que integra múltiples herramientas útiles para el día a día. La aplicación está diseñada con un enfoque en la salud, el bienestar y la productividad, permitiendo a los usuarios acceder a funcionalidades variadas como recordatorios de tareas, cálculo de IMC, búsqueda de ejercicios, noticias, y más.

## Características Principales

### 1. **Task Reminder**
- Permite a los usuarios agregar, ver y eliminar recordatorios de tareas.
- Interfaz intuitiva para una gestión de tareas sencilla.

### 2. **BMI Calculator**
- Calcula el Índice de Masa Corporal (IMC) basado en la altura y el peso del usuario.
- Clasifica el resultado en categorías como `Bajo peso`, `Peso normal`, `Sobrepeso` y `Obesidad`.

### 3. **Exercise Finder**
- Proporciona una lista de ejercicios divididos por grupos musculares como pecho, espalda, piernas, etc.
- Cada ejercicio incluye una breve descripción para guiar al usuario.

### 4. **Weather Information**
- Muestra el clima actual de una ciudad predeterminada.
- Incluye temperatura, descripción del clima y un ícono representativo.

### 5. **News Feed**
- Muestra noticias actualizadas desde una fuente RSS en línea.
- Cada noticia incluye un título, descripción breve y la opción de abrir el artículo completo.

### 6. **GitHub Profile Viewer**
- Permite buscar perfiles de GitHub y muestra información como nombre, repositorios públicos, y correo electrónico (si está disponible).

## Tecnologías Usadas

- **Flutter**: Framework principal para desarrollo móvil.
- **Dart**: Lenguaje de programación usado en Flutter.
- **API REST**: Para integrar datos externos (clima, noticias, etc.).
- **http**: Paquete utilizado para realizar solicitudes HTTP.
- **url_launcher**: Para abrir enlaces externos desde la app.

## Instalación

1. **Requisitos Previos:**
   - Flutter SDK instalado en tu máquina.
   - Android Studio o Visual Studio Code configurado para Flutter.

2. **Clonar el Repositorio:**
   ```bash
   git clone https://github.com/tu-usuario/multitask-app.git
   cd multitask-app
