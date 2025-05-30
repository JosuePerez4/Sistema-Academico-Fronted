<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Asistencias - Sistema Académico</title>
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
                <li><a href="/estudiantes/materias" style="text-decoration: none; color: inherit;"><span>Materias</span></a></li>
                <li class="active"><a href="/estudiantes/asistencias" style="text-decoration: none; color: inherit;"><span>Asistencias</span></a></li>
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
                <h2>Control de Asistencias, <span class="highlight">${nombre}</span></h2>
                <div class="date">Gestión de asistencias por materia</div>
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

        <!-- Mensajes -->
        <c:if test="${not empty mensaje}">
            <div class="alert alert-success alert-dismissible fade show">
                <i class="fas fa-check-circle"></i> ${mensaje}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show">
                <i class="fas fa-exclamation-circle"></i> ${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        
        <!-- Resumen General -->
        <div class="dashboard-summary" style="margin-bottom: 30px;">
            <section class="next-class-section" style="flex:1;">
                <h3>Total Materias</h3>
                <div class="next-class-info">
                    <span class="rating-value" style="font-size: 28px; color: #21465b;">${materiasConAsistencia != null ? materiasConAsistencia.size() : 0}</span>
                    <span class="class-code">Con registro de asistencia</span>
                </div>
            </section>
            <section class="teacher-rating-section">
                <h3>Hoy</h3>
                <div class="teacher-rating-info">
                    <span class="rating-value" style="color: #28a745;">Activo</span>
                    <span style="font-size:14px;color:var(--dark-gray);">Para registro</span>
                </div>
            </section>
            <section class="workload-section">
                <h3>Fecha</h3>
                <div class="workload-info">
                    <span class="workload-hours" style="font-size: 16px;">${fechaActual != null ? fechaActual : 'Hoy'}</span>
                    <span style="font-size:14px;color:var(--dark-gray);">${new java.util.Date()}</span>
                </div>
            </section>
        </div>

        <!-- Lista de Materias con Asistencias -->
        <div class="calendar-container">
            <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:20px;">
                <h3>Materias Matriculadas</h3>
                <div class="alert alert-info" style="margin: 0; padding: 10px;">
                    <i class="fas fa-info-circle"></i> 
                    <small>Puedes registrar tu asistencia diaria desde aquí</small>
                </div>
            </div>

            <c:choose>
                <c:when test="${not empty materiasConAsistencia}">
                    <div style="display: grid; grid-template-columns: repeat(auto-fill, minmax(400px, 1fr)); gap: 20px;">
                        <c:forEach items="${materiasConAsistencia}" var="materia" varStatus="status">
                            <div class="asistencia-card">
                                <div class="calendar-container" style="padding: 20px; border: 1px solid #dee2e6; border-radius: 10px; height: 100%;">
                                    <!-- Header de la materia -->
                                    <div style="display: flex; justify-content: space-between; align-items: start; margin-bottom: 15px;">
                                        <div>
                                            <h4 style="margin: 0; color: #21465b; font-size: 16px;">${materia.nombreMateria != null ? materia.nombreMateria : 'Materia ' += (status.index + 1)}</h4>
                                            <p style="margin: 5px 0; color: #6c757d; font-size: 12px;">
                                                <i class="fas fa-code"></i> ID Inscripción: ${materia.id}
                                            </p>
                                        </div>
                                        <span class="badge" style="background-color: #28a745; color: white; padding: 4px 8px; border-radius: 4px; font-size: 12px;">
                                            ${materia.estado != null ? materia.estado : 'ACTIVA'}
                                        </span>
                                    </div>
                                    
                                    <!-- Estadísticas de Asistencia -->
                                    <div class="estadisticas-asistencia" style="margin-bottom: 15px;">
                                        <h6 style="color: #21465b; margin-bottom: 10px;">
                                            <i class="fas fa-chart-pie"></i> Estadísticas de Asistencia
                                        </h6>
                                        <div class="row g-2">
                                            <div class="col-4">
                                                <div class="stat-box presente">
                                                    <div class="stat-number">${materia.estadisticasAsistencia.PRESENTE != null ? materia.estadisticasAsistencia.PRESENTE : 0}</div>
                                                    <div class="stat-label">Presente</div>
                                                </div>
                                            </div>
                                            <div class="col-4">
                                                <div class="stat-box ausente">
                                                    <div class="stat-number">${materia.estadisticasAsistencia.AUSENTE != null ? materia.estadisticasAsistencia.AUSENTE : 0}</div>
                                                    <div class="stat-label">Ausente</div>
                                                </div>
                                            </div>
                                            <div class="col-4">
                                                <div class="stat-box justificado">
                                                    <div class="stat-number">${materia.estadisticasAsistencia.JUSTIFICADO != null ? materia.estadisticasAsistencia.JUSTIFICADO : 0}</div>
                                                    <div class="stat-label">Justificado</div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Información adicional -->
                                    <div style="margin-bottom: 15px;">
                                        <p style="margin: 5px 0; color: #6c757d; font-size: 14px;">
                                            <i class="fas fa-user text-success"></i> 
                                            <strong>Profesor:</strong> ${materia.nombreProfesor != null ? materia.nombreProfesor : 'Por asignar'}
                                        </p>
                                        <p style="margin: 5px 0; color: #6c757d; font-size: 14px;">
                                            <i class="fas fa-clock text-info"></i> 
                                            <strong>Horario:</strong> ${materia.horario != null ? materia.horario : 'Por definir'}
                                        </p>
                                    </div>

                                    <!-- Botones de Acción -->
                                    <div style="margin-top: auto;">
                                        <div style="display: flex; gap: 8px;">
                                            <a href="/estudiantes/registrar-asistencia/${materia.id}" 
                                               class="btn btn-success btn-sm" style="flex: 1; text-decoration: none; text-align: center;">
                                                <i class="fas fa-plus"></i> Registrar Hoy
                                            </a>
                                            <a href="/estudiantes/historial-asistencia/${materia.id}" 
                                               class="btn btn-outline-primary btn-sm" style="flex: 1; text-decoration: none; text-align: center;">
                                                <i class="fas fa-history"></i> Ver Historial
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div style="text-align: center; padding: 40px; color: #6c757d;">
                        <i class="fas fa-calendar-check" style="font-size: 48px; margin-bottom: 20px; color: #dee2e6;"></i>
                        <h3>No hay materias matriculadas</h3>
                        <p>Aún no tienes materias matriculadas para registrar asistencia.</p>
                        <a href="/estudiantes/matricula" class="btn btn-primary" style="margin-top: 15px; text-decoration: none;">
                            <i class="fas fa-plus"></i> Ir a Matrícula
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Información Adicional -->
        <div class="calendar-container" style="margin-top: 30px;">
            <h4><i class="fas fa-info-circle text-primary"></i> Información sobre Asistencias</h4>
            <div class="row">
                <div class="col-md-6">
                    <h6><i class="fas fa-exclamation-triangle text-warning"></i> Importante</h6>
                    <ul class="list-unstyled">
                        <li><i class="fas fa-check text-success"></i> Registra tu asistencia diariamente</li>
                        <li><i class="fas fa-check text-success"></i> Las ausencias pueden afectar tu calificación final</li>
                        <li><i class="fas fa-check text-success"></i> Puedes justificar ausencias cuando sea necesario</li>
                    </ul>
                </div>
                <div class="col-md-6">
                    <h6><i class="fas fa-chart-bar text-info"></i> Estados de Asistencia</h6>
                    <ul class="list-unstyled">
                        <li><i class="fas fa-circle text-success"></i> <strong>Presente:</strong> Asististe a clase</li>
                        <li><i class="fas fa-circle text-danger"></i> <strong>Ausente:</strong> No asististe sin justificación</li>
                        <li><i class="fas fa-circle text-warning"></i> <strong>Justificado:</strong> Ausencia con justificación válida</li>
                    </ul>
                </div>
            </div>
        </div>
    </main>
</div>

<style>
.asistencia-card {
    transition: transform 0.2s ease;
}

.asistencia-card:hover {
    transform: translateY(-2px);
}

.stat-box {
    text-align: center;
    padding: 10px 5px;
    border-radius: 8px;
    margin: 2px;
}

.stat-box.presente {
    background-color: #d1edff;
    border: 1px solid #28a745;
}

.stat-box.ausente {
    background-color: #f8d7da;
    border: 1px solid #dc3545;
}

.stat-box.justificado {
    background-color: #fff3cd;
    border: 1px solid #ffc107;
}

.stat-number {
    font-size: 18px;
    font-weight: bold;
    color: #21465b;
}

.stat-label {
    font-size: 11px;
    color: #6c757d;
    font-weight: 500;
}

.alert {
    margin-bottom: 20px;
}

.btn {
    border-radius: 6px;
    transition: all 0.2s ease;
}

.btn:hover {
    transform: translateY(-1px);
}

.list-unstyled li {
    margin-bottom: 5px;
    font-size: 14px;
}

.row.g-2 {
    --bs-gutter-x: 0.5rem;
    --bs-gutter-y: 0.5rem;
}
</style>

</body>
</html> 