<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Contáctanos - Sistema Académico</title>
    <link rel="stylesheet" href="/css/profesor.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
</head>
<body>
<div class="container">
    <aside class="sidebar">
        <div class="logo">
            <img src="/image/logoufps.png" alt="Logo UFPS" class="logo-img" />
            <div class="version">Divisist 3.0</div>
        </div>
        <nav>
            <ul>
                <li><span>Inicio</span></li>
                <li><span>Inclusiones</span></li>
                <li><span>Materias</span></li>
                <li><span>Mensajes <span class="badge">2</span></span></li>
                <li><span>Horario</span></li>
                <li><span>Evaluaciones</span></li>
                <li><span>Cursos disponibles</span></li>
                <li><span>Ajustes</span></li>
            </ul>
        </nav>
        <div class="sidebar-footer">
            <a href="/ayuda">Ayuda</a>
            <a href="/contacto" class="active">Contáctenos</a>
            <a href="/logout">Cerrar sesión</a>
        </div>
    </aside>
    <main class="main-content">
        <header class="header">
            <div>
                <h2>Bienvenido de vuelta, <span class="highlight">${nombre}</span></h2>
                <div class="date">${fechaActual}</div>
            </div>
            <div class="header-actions">
                <input type="text" placeholder="Búsqueda" class="search">
                <div class="notification">
                    <span class="notif-badge">4</span>
                    <i class="fas fa-bell"></i>
                </div>
                <div class="profile">
                    <img src="/image/Perfil.png" alt="Perfil" />
                    <span>${nombre}</span>
                </div>
            </div>
        </header>
        <div style="background:white;border-radius:30px;padding:40px 50px;max-width:1100px;margin:0 auto;box-shadow:0 4px 24px rgba(0,0,0,0.07);">
            <p style="font-size:22px;font-weight:700;margin-bottom:20px;">Si necesitas ayuda, contáctanos por medio de correo electrónico a:<br>
                <span style="font-weight:900;">ayuda.divisist3.0@UFPS.edu.com</span><br>
                o al número<br>
                <span style="font-weight:900;">+57 3124228724</span>
            </p>
            <p style="font-size:20px;font-weight:600;">Cualquier asistencia directa que necesites con tus cursos y/o evaluaciones, puedes comunicarte con tu profesor directamente por medio de la pestaña Mensajes.</p>
        </div>
    </main>
</div>
</body>
</html> 