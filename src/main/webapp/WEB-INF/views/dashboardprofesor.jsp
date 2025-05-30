<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="es">

        <head>
            <meta charset="UTF-8" />
            <title>Dashboard Profesor - Sistema Académico</title>
            <link rel="stylesheet" href="/css/profesor.css" />
            <link rel="preconnect" href="https://fonts.googleapis.com" />
            <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
            <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap"
                rel="stylesheet" />
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
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
                            <li><a href="/mensajes" class="${currentPage == 'mensajes' ? 'active' : ''}">Mensajes <span
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
                            <h2>
                                Bienvenido de vuelta,
                                <span class="highlight">Maestro #${profesor.id}</span>
                            </h2>
                            <div class="date">${fechaActual}</div>
                        </div>
                        <div class="header-actions">
                            <input type="text" placeholder="Búsqueda" class="search" />
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

                    <div class="dashboard-summary">
                        <section class="next-class-section">
                            <h3>Próxima Clase</h3>
                            <div class="next-class-info">
                                <c:choose>
                                    <c:when test="${not empty proximaClase.nombre}">
                                        <span class="class-name"><strong>${proximaClase.nombre}</strong></span>
                                        <span class="class-code">${proximaClase.codigo}</span>
                                        <span class="class-time">${proximaClase.horario}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="class-name"><strong>${claseActual.nombre}</strong></span>
                                        <span class="class-code">${claseActual.codigo}</span>
                                        <span class="class-time">${claseActual.horario}</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </section>

                        <section class="teacher-rating-section">
                            <h3>Calificación Docente</h3>
                            <div class="teacher-rating-info">
                                <span class="rating-value">${profesor.calificacion}</span>
                            </div>
                        </section>

                        <section class="workload-section">
                            <h3>Intensidad Horaria</h3>
                            <div class="workload-info">
                                <span class="workload-hours">${claseActual.horasSemanales}</span>
                            </div>
                        </section>
                    </div>
                    <div class="calendar-container">
                        <table class="calendar">
                            <thead>
                                <tr>
                                    <th>Lun</th>
                                    <th>Mar</th>
                                    <th>Mié</th>
                                    <th>Jue</th>
                                    <th>Vie</th>
                                    <th>Sáb</th>
                                    <th>Dom</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${calendario.semanas}" var="semana">
                                    <tr>
                                        <c:forEach items="${semana.dias}" var="dia">
                                            <td
                                                class="${dia.esHoy ? 'current-day' : ''} ${dia.esFinDeSemana ? 'weekend' : ''}">
                                                ${dia.dia}
                                                <c:if test="${dia.tieneClase}">
                                                    <span class="class-indicator"></span>
                                                </c:if>
                                            </td>
                                        </c:forEach>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </main>
            </div>
        </body>

        </html>