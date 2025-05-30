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
                            <li><a href="/profesor/dashboard"
                                    class="${currentPage == 'dashboard' ? 'active' : ''}">Inicio</a></li>
                            <li><a href="/profesor/clases" class="${currentPage == 'clases' ? 'active' : ''}">Mis
                                    Clases</a></li>
                            <li><a href="/profesor/calificaciones"
                                    class="${currentPage == 'calificaciones' ? 'active' : ''}">Calificaciones</a></li>
                            <li><a href="/mensajes"
                                    class="${currentPage == 'mensajes' ? 'active' : ''}">Mensajes <span
                                        class="badge">3</span></a></li>
                            <li><a href="/profesor/horario"
                                    class="${currentPage == 'horario' ? 'active' : ''}">Horario</a></li>
                            <li><a href="/profesor/asistencias"
                                    class="${currentPage == 'asistencias' ? 'active' : ''}">Asistencias</a></li>
                            <li><a href="/profesor/evaluaciones"
                                    class="${currentPage == 'evaluaciones' ? 'active' : ''}">Evaluaciones</a></li>
                            <li><a href="/profesor/ajustes"
                                    class="${currentPage == 'ajustes' ? 'active' : ''}">Ajustes</a></li>
                            <li><a href="/profesor/recursos"
                                    class="${currentPage == 'recursos' ? 'active' : ''}">Recursos Académicos</a></li>
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
                    <div
                        style="background:white;border-radius:30px;padding:40px 50px;max-width:1100px;margin:0 auto;box-shadow:0 4px 24px rgba(0,0,0,0.07);">
                        <h2 style="color:#54a7b9;margin-bottom:30px;">Asignación automática de cursos</h2>
                        <h2 style="color:#54a7b9;margin-bottom:30px;">Asignación manual de cursos</h2>
                        <h2 style="color:#21465b;margin-top:60px;">Mis cursos</h2>
                    </div>
                </main>
            </div>
        </body>

        </html>