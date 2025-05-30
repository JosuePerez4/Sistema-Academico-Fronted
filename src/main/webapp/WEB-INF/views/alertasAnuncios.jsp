<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Alertas y Anuncios - Sistema Académico</title>
    <link rel="stylesheet" href="/css/profesor.css">
    <link rel="stylesheet" href="/css/alertasAnuncios.css"> <%-- Nuevo CSS específico --%>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <div class="container">
        <%-- Sidebar --%>
        <aside class="sidebar">
            <div class="logo">
                <img src="/image/logoufps.png" alt="Logo UFPS" class="logo-img" />
                <div class="version">Divisist 3.0</div>
            </div>
            <nav>
                <ul>
                    <li><a href="/profesor/dashboard"><span>Inicio</span></a></li>
                    <li><a href="/profesor/mis-clases"><span>Mis Clases</span></a></li>
                    <li><a href="/profesor/calificaciones"><span>Calificaciones</span></a></li>
                    <li class="active"><a href="/mensajes"><span>Mensajes <span class="badge">${notificacionesPendientes}</span></span></a></li>
                    <li><a href="/profesor/horario"><span>Horario</span></a></li>
                    <li><a href="/profesor/asistencias"><span>Asistencias</span></a></li>
                    <li><a href="/profesor/reportes"><span>Reportes</span></a></li>
                    <li><a href="/profesor/ajustes"><span>Ajustes</span></a></li>
                </ul>
            </nav>
            <div class="sidebar-footer">
                <a href="#">Ayuda</a>
                <a href="#">Contáctenos</a>
                <a href="/logout">Cerrar sesión</a>
            </div>
        </aside>

        <main class="main-content">
            <%-- Header --%>
            <header class="header">
                <div>
                    <h2><span class="highlight">Alertas y Anuncios</span></h2>
                    <div class="date">${fechaActual}</div>
                </div>
                <div class="header-actions">
                    <input type="text" placeholder="Búsqueda" class="search">
                    <div class="notification">
                        <a href="/mensajes" class="notification-link">
                            <span class="notif-badge">${notificacionesPendientes}</span>
                            <i class="fas fa-bell"></i>
                        </a>
                    </div>
                    <div class="profile">
                        <img src="/image/Perfil.png" alt="Perfil" />
                        <span>${profesor.nombre}</span>
                    </div>
                </div>
            </header>

            <div class="announcements-content">
                <h3>Últimos Anuncios</h3>
                <div class="announcement-list">
                    <div class="announcement-item">
                        <div class="announcement-header">
                            <span class="announcement-title">Mantenimiento Programado del Sistema</span>
                            <span class="announcement-date">29 de mayo de 2025</span>
                        </div>
                        <p class="announcement-body">Se informa a toda la comunidad académica que se realizará un mantenimiento programado del sistema el 30 de mayo de 2025 de 10:00 PM a 2:00 AM. Agradecemos su comprensión.</p>
                        <span class="announcement-author">Administración</span>
                    </div>
                    <div class="announcement-item new">
                        <div class="announcement-header">
                            <span class="announcement-title">Nueva Política de Evaluación Docente</span>
                            <span class="announcement-date">28 de mayo de 2025</span>
                        </div>
                        <p class="announcement-body">Se ha publicado la nueva política de evaluación docente, disponible para su consulta en la sección de "Documentos".</p>
                        <span class="announcement-author">Dirección Académica</span>
                    </div>
                    <div class="announcement-item">
                        <div class="announcement-header">
                            <span class="announcement-title">Convocatoria a Curso de Actualización</span>
                            <span class="announcement-date">25 de mayo de 2025</span>
                        </div>
                        <p class="announcement-body">Invitamos a todos los docentes a participar en el curso de actualización en metodologías de enseñanza innovadoras.</p>
                        <span class="announcement-author">Decanatura de Facultad</span>
                    </div>
                    </div>
                <button class="btn btn-secondary load-more-btn">Cargar Más Anuncios</button>
            </div>

        </main>
    </div>
</body>
</html>