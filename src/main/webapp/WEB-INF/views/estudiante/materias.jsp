<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Mis Materias - Sistema Académico</title>
    <link rel="stylesheet" href="/css/profesor.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
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
                <li><a href="/estudiantes/dashboard" style="text-decoration: none; color: inherit;"><span>Inicio</span></a></li>
                <li><a href="/estudiantes/matricula" style="text-decoration: none; color: inherit;"><span>Matrícula</span></a></li>
                <li><span>Inclusiones</span></li>
                <li class="active"><a href="/estudiantes/materias" style="text-decoration: none; color: inherit;"><span>Materias</span></a></li>
                <li><a href="/estudiantes/asistencias" style="text-decoration: none; color: inherit;"><span>Asistencias</span></a></li>
                <li><span>Mensajes <span class="badge">2</span></span></li>
                <li><span>Horario</span></li>
                <li><span>Evaluaciones</span></li>
                <li><a href="/estudiantes/cursos-disponibles" style="text-decoration: none; color: inherit;"><span>Cursos disponibles</span></a></li>
                <li><span>Ajustes</span></li>
            </ul>
        </nav>
        <div class="sidebar-footer">
            <a href="#">Ayuda</a>
            <a href="/contacto">Contáctenos</a>
            <a href="/logout">Cerrar sesión</a>
        </div>
    </aside>
    <main class="main-content">
        <header class="header">
            <div>
                <h2>Mis Materias, <span class="highlight">${nombre}</span></h2>
                <div class="date">Semestre actual</div>
            </div>
            <div class="header-actions">
                <input type="text" placeholder="Buscar materia" class="search">
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
        
        <div class="dashboard-summary">
            <section class="next-class-section" style="flex:1;">
                <h3>Total Materias</h3>
                <div class="next-class-info">
                    <span class="rating-value" style="font-size: 28px; color: #21465b;">${materiasMatriculadas != null ? materiasMatriculadas.size() : 0}</span>
                    <span class="class-code">Matriculadas este semestre</span>
                </div>
            </section>
            <section class="teacher-rating-section">
                <h3>Créditos</h3>
                <div class="teacher-rating-info">
                    <span class="rating-value">15</span>
                    <span style="font-size:14px;color:var(--dark-gray);">Créditos actuales</span>
                </div>
            </section>
            <section class="workload-section">
                <h3>Progreso</h3>
                <div class="workload-info">
                    <span class="workload-hours">75%</span>
                    <span style="font-size:14px;color:var(--dark-gray);">Completado</span>
                </div>
            </section>
        </div>

        <div class="calendar-container" style="margin-top: 30px;">
            <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:20px;">
                <h3>Materias Matriculadas</h3>
                <button class="search" style="padding:8px 16px;">
                    <i class="fas fa-plus"></i> Ver Calificaciones
                </button>
            </div>

            <c:if test="${not empty error}">
                <div class="alert alert-danger" style="background-color: #f8d7da; color: #721c24; padding: 15px; border-radius: 8px; margin-bottom: 20px;">
                    ${error}
                </div>
            </c:if>

            <c:choose>
                <c:when test="${not empty materiasMatriculadas}">
                    <div style="display: grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap: 20px;">
                        <c:forEach items="${materiasMatriculadas}" var="materia" varStatus="status">
                            <div class="calendar-container" style="padding: 20px; border: 1px solid #dee2e6; border-radius: 10px;">
                                <div style="display: flex; justify-content: space-between; align-items: start; margin-bottom: 15px;">
                                    <h4 style="margin: 0; color: #21465b;">${materia.nombreMateria != null ? materia.nombreMateria : 'Materia ' += (status.index + 1)}</h4>
                                    <span class="badge" style="background-color: #28a745; color: white; padding: 4px 8px; border-radius: 4px; font-size: 12px;">
                                        ${materia.estado != null ? materia.estado : 'ACTIVA'}
                                    </span>
                                </div>
                                <div style="margin-bottom: 10px;">
                                    <p style="margin: 5px 0; color: #6c757d;">
                                        <i class="fas fa-code"></i> Código: ${materia.codigoMateria != null ? materia.codigoMateria : 'N/A'}
                                    </p>
                                    <p style="margin: 5px 0; color: #6c757d;">
                                        <i class="fas fa-credit-card"></i> Créditos: ${materia.creditos != null ? materia.creditos : '3'}
                                    </p>
                                    <p style="margin: 5px 0; color: #6c757d;">
                                        <i class="fas fa-user"></i> Profesor: ${materia.nombreProfesor != null ? materia.nombreProfesor : 'Por asignar'}
                                    </p>
                                    <p style="margin: 5px 0; color: #6c757d;">
                                        <i class="fas fa-clock"></i> Horario: ${materia.horario != null ? materia.horario : 'Por definir'}
                                    </p>
                                </div>
                                <div style="display: flex; gap: 10px; margin-top: 15px;">
                                    <button class="search" style="flex: 1; padding: 8px; font-size: 12px; background-color: #007bff;">
                                        Ver Detalles
                                    </button>
                                    <a href="/estudiantes/registrar-asistencia/${materia.id != null ? materia.id : status.index + 1}" 
                                       class="search" style="flex: 1; padding: 8px; font-size: 12px; background-color: #28a745; text-decoration: none; text-align: center;">
                                        Asistencia
                                    </a>
                                    <a href="/estudiantes/historial-asistencia/${materia.id != null ? materia.id : status.index + 1}" 
                                       class="search" style="flex: 1; padding: 8px; font-size: 12px; background-color: #ffc107; color: #212529; text-decoration: none; text-align: center;">
                                        Historial
                                    </a>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div style="text-align: center; padding: 40px; color: #6c757d;">
                        <i class="fas fa-book-open" style="font-size: 48px; margin-bottom: 20px; color: #dee2e6;"></i>
                        <h3>No hay materias matriculadas</h3>
                        <p>Aún no tienes materias matriculadas para este semestre.</p>
                        <a href="/estudiantes/matricula" class="search" style="display: inline-block; margin-top: 15px; text-decoration: none;">
                            Ir a Matrícula
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </main>
</div>

<script>
function verDetalles(materiaId) {
    window.location.href = '/estudiantes/materia/' + materiaId;
}

function verCalificaciones(materiaId) {
    window.location.href = '/estudiantes/calificaciones/' + materiaId;
}
</script>

</body>
</html> 