<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Mensajería Interna - Sistema Académico</title>
    <link rel="stylesheet" href="/css/profesor.css">
    <link rel="stylesheet" href="/css/mensajeriaInterna.css"> <%-- Nuevo CSS específico --%>
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
                    <h2><span class="highlight">Mensajería Interna</span></h2>
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

            <div class="internal-messages-content">
                <h3>Tus Conversaciones</h3>
                <div class="conversation-list">
                    <c:forEach items="${conversaciones}" var="conv">
                        <%-- CADA CONVERSACIÓN DEBE SER UN ENLACE (<a>) --%>
                        <a href="/mensajes/conversacion/${conv.id}" class="conversation-item ${!conv.leido ? 'unread' : ''}">
                            <span class="conversation-title">${conv.participante} - ${conv.asunto}</span>
                            <span class="conversation-date">${conv.ultimaFecha}</span>
                            <p class="conversation-preview">${conv.preview}</p>
                        </a>
                    </c:forEach>
                </div>
                <a href="/mensajes/nuevo" class="btn btn-primary new-message-btn"><i class="fas fa-plus"></i> Nuevo Mensaje</a>
            </div>

        </main>
    </div>
</body>
</html>