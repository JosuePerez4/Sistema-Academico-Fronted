<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Evaluaciones - Sistema Académico</title>
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
                <li><a href="/profesor/dashboard">Inicio</a></li>
                <li><a href="/profesor/clases">Mis Clases</a></li>
                <li><span>Calificaciones</span></li>
                <li><span>Mensajes <span class="badge">3</span></span></li>
                <li><span>Horario</span></li>
                <li><span>Asistencias</span></li>
                <li class="active"><a href="/profesor/evaluaciones">Evaluaciones</a></li>
                <li><a href="/profesor/ajustes">Ajustes</a></li>
            </ul>
        </nav>
        <div class="sidebar-footer">
            <a href="/ayuda">Ayuda</a>
            <a href="/profesor/contacto">Contáctenos</a>
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
                    <span class="notif-badge">3</span>
                    <i class="fas fa-bell"></i>
                </div>
                <div class="profile">
                    <img src="/image/Perfil.png" alt="Perfil" />
                    <span>${nombre}</span>
                </div>
            </div>
        </header>
        <div style="background:white;border-radius:30px;padding:40px 50px;max-width:1100px;margin:0 auto;box-shadow:0 4px 24px rgba(0,0,0,0.07);">
            <h2 style="color:#54a7b9;margin-bottom:30px;">Crear Evaluación</h2>
            <form style="display:flex;flex-direction:column;gap:20px;max-width:500px;">
                <label style="font-size:18px;font-weight:600;">Tipo de evaluación
                    <select style="margin-top:8px;padding:8px 12px;border-radius:8px;border:1px solid #e7e9ed;width:100%;">
                        <option>Examen</option>
                        <option>Quiz</option>
                        <option>Trabajo</option>
                        <option>Otro</option>
                    </select>
                </label>
                <label style="font-size:18px;font-weight:600;">Nombre de la evaluación
                    <input type="text" style="margin-top:8px;padding:8px 12px;border-radius:8px;border:1px solid #e7e9ed;width:100%;" placeholder="Ej: Parcial 1" />
                </label>
                <label style="font-size:18px;font-weight:600;">Fecha
                    <input type="date" style="margin-top:8px;padding:8px 12px;border-radius:8px;border:1px solid #e7e9ed;width:100%;" />
                </label>
                <button type="button" style="margin-top:20px;padding:12px 0;background:#54a7b9;color:white;font-size:18px;font-weight:700;border:none;border-radius:8px;">Crear</button>
            </form>
        </div>
    </main>
</div>
</body>
</html> 