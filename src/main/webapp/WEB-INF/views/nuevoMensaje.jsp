<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="es">

        <head>
            <meta charset="UTF-8">
            <title>Nuevo Mensaje - Sistema Académico</title>
            <link rel="stylesheet" href="/css/profesor.css">
            <link rel="stylesheet" href="/css/nuevoMensaje.css"> <%-- Nuevo CSS específico --%>
                <link rel="preconnect" href="https://fonts.googleapis.com">
                <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
                <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap"
                    rel="stylesheet">
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        </head>

        <body>
            <div class="container">
                <%-- Sidebar (repetido por simplicidad, considerar incluirlo con JSP include) --%>
                    <aside class="sidebar">
                        <div class="logo">
                            <img src="/image/logoufps.png" alt="Logo UFPS" class="logo-img" />
                            <div class="version">Divisist 3.0</div>
                        </div>
                        <nav>
                            <ul>
                                <li><a href="/profesor/dashboard"
                                        class="${currentPage == 'dashboard' ? 'active' : ''}">Inicio</a></li>
                                <li><a href="/profesor/clases" class="${currentPage == 'clases' ? 'active' : ''}">Mis
                                        Clases</a></li>
                                <li><a href="/profesor/calificaciones"
                                        class="${currentPage == 'calificaciones' ? 'active' : ''}">Calificaciones</a>
                                </li>
                                <li><a href="/mensajes" class="${currentPage == 'mensajes' ? 'active' : ''}">Mensajes
                                        <span class="badge">3</span></a></li>
                                <li><a href="/profesor/horario"
                                        class="${currentPage == 'horario' ? 'active' : ''}">Horario</a></li>
                                <li><a href="/profesor/asistencias"
                                        class="${currentPage == 'asistencias' ? 'active' : ''}">Asistencias</a></li>
                                <li><a href="/profesor/evaluaciones"
                                        class="${currentPage == 'evaluaciones' ? 'active' : ''}">Evaluaciones</a></li>
                                <li><a href="/profesor/ajustes"
                                        class="${currentPage == 'ajustes' ? 'active' : ''}">Ajustes</a></li>
                                <li><a href="/profesor/recursos"
                                        class="${currentPage == 'recursos' ? 'active' : ''}">Recursos Académicos</a>
                                </li>
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
                                    <h2><span class="highlight">Redactar Nuevo Mensaje</span></h2>
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

                            <div class="compose-message-container">
                                <form action="/mensajes/enviar" method="post" class="message-form">
                                    <div class="form-group">
                                        <label for="to">Para:</label>
                                        <input type="text" id="to" name="to"
                                            placeholder="Nombre de destinatario o correo" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="subject">Asunto:</label>
                                        <input type="text" id="subject" name="subject" placeholder="Asunto del mensaje"
                                            required>
                                    </div>
                                    <div class="form-group">
                                        <label for="message-content">Mensaje:</label>
                                        <textarea id="message-content" name="content" rows="10"
                                            placeholder="Escribe tu mensaje aquí..." required></textarea>
                                    </div>
                                    <div class="form-actions">
                                        <button type="submit" class="btn btn-primary"><i class="fas fa-paper-plane"></i>
                                            Enviar Mensaje</button>
                                        <a href="/mensajes/interna" class="btn btn-secondary"><i
                                                class="fas fa-times"></i> Cancelar</a>
                                    </div>
                                </form>
                            </div>

                    </main>
            </div>
        </body>

        </html>