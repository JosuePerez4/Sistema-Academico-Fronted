<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Detalles del Curso - Sistema Académico</title>
    <link rel="stylesheet" href="/css/profesor.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
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
                <li><span>Mensajes <span class="badge">2</span></span></li>
                <li><span>Horario</span></li>
                <li><span>Evaluaciones</span></li>
                <li class="active"><a href="/estudiantes/cursos-disponibles" style="text-decoration: none; color: inherit;"><span>Cursos disponibles</span></a></li>
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
                <h2>Detalles del Curso - <span class="highlight">${curso.nombre}</span></h2>
                <div class="date">Información completa del curso</div>
            </div>
            <div class="header-actions">
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

        <!-- Navegación -->
        <div style="margin-bottom: 20px;">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="/estudiantes/cursos-disponibles">Cursos Disponibles</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Detalles del Curso</li>
                </ol>
            </nav>
        </div>

        <!-- Información Principal del Curso -->
        <div class="calendar-container" style="margin-bottom: 30px;">
            <div class="row">
                <div class="col-md-8">
                    <h3 style="color: #21465b; margin-bottom: 15px;">${curso.nombre}</h3>
                    <div class="curso-badges mb-3">
                        <span class="badge bg-primary me-2">${curso.codigo}</span>
                        <span class="badge bg-success me-2">${curso.creditos} Créditos</span>
                        <span class="badge bg-info me-2">${curso.duracion}</span>
                        <span class="badge bg-warning text-dark">${curso.modalidad}</span>
                    </div>
                    <p class="lead text-muted">${curso.descripcion}</p>
                </div>
                <div class="col-md-4 text-end">
                    <div class="card bg-light">
                        <div class="card-body text-center">
                            <h5 class="card-title">¿Listo para inscribirte?</h5>
                            <a href="/estudiantes/seleccionar-grupo/${curso.id}" class="btn btn-success btn-lg">
                                <i class="fas fa-plus"></i> Inscribirse al Curso
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Información Detallada -->
        <div class="row">
            <!-- Información General -->
            <div class="col-md-6">
                <div class="calendar-container" style="margin-bottom: 30px;">
                    <h4><i class="fas fa-info-circle text-primary"></i> Información General</h4>
                    <table class="table table-borderless">
                        <tbody>
                            <tr>
                                <td><strong>Código:</strong></td>
                                <td>${curso.codigo}</td>
                            </tr>
                            <tr>
                                <td><strong>Créditos:</strong></td>
                                <td>${curso.creditos}</td>
                            </tr>
                            <tr>
                                <td><strong>Duración:</strong></td>
                                <td>${curso.duracion}</td>
                            </tr>
                            <tr>
                                <td><strong>Modalidad:</strong></td>
                                <td>${curso.modalidad}</td>
                            </tr>
                            <tr>
                                <td><strong>Grupos disponibles:</strong></td>
                                <td>${curso.grupos.size()} grupos</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Prerrequisitos -->
            <div class="col-md-6">
                <div class="calendar-container" style="margin-bottom: 30px;">
                    <h4><i class="fas fa-list-check text-warning"></i> Prerrequisitos</h4>
                    <c:choose>
                        <c:when test="${not empty curso.prerrequisitos}">
                            <ul class="list-group list-group-flush">
                                <c:forEach items="${curso.prerrequisitos}" var="prerrequisito">
                                    <li class="list-group-item">
                                        <i class="fas fa-check-circle text-success me-2"></i>
                                        ${prerrequisito}
                                    </li>
                                </c:forEach>
                            </ul>
                        </c:when>
                        <c:otherwise>
                            <div class="alert alert-info">
                                <i class="fas fa-info-circle"></i> No hay prerrequisitos específicos para este curso.
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>

        <!-- Horarios Disponibles -->
        <div class="calendar-container" style="margin-bottom: 30px;">
            <h4><i class="fas fa-calendar-alt text-info"></i> Horarios Disponibles</h4>
            <p class="text-muted mb-3">Selecciona el horario que mejor se adapte a tu disponibilidad.</p>
            
            <div class="row g-3">
                <c:forEach items="${curso.grupos}" var="grupo" varStatus="status">
                    <div class="col-md-4">
                        <div class="card h-100 horario-card">
                            <div class="card-header bg-primary text-white">
                                <h6 class="mb-0">
                                    <i class="fas fa-users"></i> ${grupo.nombre}
                                </h6>
                            </div>
                            <div class="card-body">
                                <div class="horario-info">
                                    <p class="mb-2">
                                        <i class="fas fa-calendar text-primary"></i>
                                        <strong>Días:</strong> ${grupo.horario}
                                    </p>
                                    <p class="mb-2">
                                        <i class="fas fa-clock text-info"></i>
                                        <strong>Hora:</strong> ${grupo.hora}
                                    </p>
                                    <p class="mb-2">
                                        <i class="fas fa-user text-success"></i>
                                        <strong>Profesor:</strong> ${grupo.profesor}
                                    </p>
                                </div>
                            </div>
                            <div class="card-footer text-center bg-light">
                                <small class="text-muted">
                                    <i class="fas fa-map-marker-alt"></i> Aula por asignar
                                </small>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>

        <!-- Descripción Completa -->
        <div class="calendar-container" style="margin-bottom: 30px;">
            <h4><i class="fas fa-file-text text-secondary"></i> Descripción del Curso</h4>
            <div class="descripcion-completa">
                <p>${curso.descripcion}</p>
                
                <h6>Objetivos del Curso:</h6>
                <ul>
                    <li>Proporcionar conocimientos fundamentales en el área de estudio</li>
                    <li>Desarrollar habilidades prácticas aplicables en el campo profesional</li>
                    <li>Fomentar el pensamiento crítico y analítico</li>
                    <li>Preparar a los estudiantes para cursos avanzados en la materia</li>
                </ul>

                <h6>Metodología:</h6>
                <p>El curso combina clases magistrales con actividades prácticas, talleres y proyectos grupales. 
                Se enfatiza la participación activa del estudiante y el aprendizaje colaborativo.</p>

                <h6>Evaluación:</h6>
                <ul>
                    <li><strong>Parciales:</strong> 40% (2 exámenes)</li>
                    <li><strong>Talleres y Tareas:</strong> 30%</li>
                    <li><strong>Proyecto Final:</strong> 20%</li>
                    <li><strong>Participación:</strong> 10%</li>
                </ul>
            </div>
        </div>

        <!-- Acciones -->
        <div class="d-flex justify-content-between">
            <a href="/estudiantes/cursos-disponibles" class="btn btn-secondary">
                <i class="fas fa-arrow-left"></i> Volver a Cursos
            </a>
            <a href="/estudiantes/seleccionar-grupo/${curso.id}" class="btn btn-success btn-lg">
                <i class="fas fa-plus"></i> Proceder a Inscripción
            </a>
        </div>
    </main>
</div>

<style>
.curso-badges .badge {
    font-size: 12px;
    padding: 8px 12px;
}

.horario-card {
    transition: transform 0.2s ease;
    border: 2px solid #dee2e6;
}

.horario-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 6px 15px rgba(0,0,0,0.15);
    border-color: #007bff;
}

.horario-info p {
    font-size: 14px;
    margin-bottom: 8px;
}

.horario-info i {
    width: 20px;
    margin-right: 8px;
}

.descripcion-completa h6 {
    color: #21465b;
    margin-top: 20px;
    margin-bottom: 10px;
    font-weight: 600;
}

.descripcion-completa ul {
    margin-bottom: 15px;
}

.table td {
    padding: 10px 0;
    border: none;
}

.breadcrumb {
    background-color: transparent;
    padding: 0;
}

.breadcrumb-item a {
    color: #007bff;
    text-decoration: none;
}

.breadcrumb-item a:hover {
    text-decoration: underline;
}

.lead {
    font-size: 1.1rem;
    line-height: 1.6;
}

.card-header h6 {
    margin-bottom: 0;
}

.list-group-item {
    border: none;
    padding: 8px 0;
}
</style>

</body>
</html> 