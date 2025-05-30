<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Mis Clases - Sistema Académico</title>
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
                <li class="active"><a href="/profesor/clases">Mis Clases</a></li>
                <li><span>Calificaciones</span></li>
                <li><span>Mensajes <span class="badge">3</span></span></li>
                <li><span>Horario</span></li>
                <li><span>Asistencias</span></li>
                <li><span>Reportes</span></li>
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
            <h2 style="color:#54a7b9;margin-bottom:30px;">Asignación automática de cursos</h2>
            <c:if test="${not empty cursosDisponibles}">
                <form action="/profesor/asignar-curso" method="post" style="margin-bottom:30px;">
                    <label for="curso">Curso disponible:</label>
                    <select name="cursoId" id="curso" required>
                        <c:forEach var="curso" items="${cursosDisponibles}">
                            <option value="${curso.id}">${curso.nombre} (${curso.codigo}) - ${curso.creditos} créditos</option>
                        </c:forEach>
                    </select>
                    <label for="horas" style="margin-left:20px;">Horas a asignar:</label>
                    <input type="number" name="horasAsignadas" id="horas" min="1" max="40" required style="width:60px;">
                    <button type="submit" style="margin-left:20px;">Asignar</button>
                </form>
            </c:if>
            <c:if test="${empty cursosDisponibles}">
                <p>No hay cursos disponibles para asignar.</p>
            </c:if>
            <h2 style="color:#54a7b9;margin-bottom:30px;">Asignación manual de cursos</h2>
            <h2 style="color:#21465b;margin-top:60px;">Mis cursos</h2>
        </div>
    </main>
</div>
</body>
</html> 