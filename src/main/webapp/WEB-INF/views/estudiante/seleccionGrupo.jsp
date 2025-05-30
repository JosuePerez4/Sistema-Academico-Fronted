<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Seleccionar Grupo - Sistema Académico</title>
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
                <h2>Seleccionar Grupo - <span class="highlight">${curso.nombre}</span></h2>
                <div class="date">Código: ${curso.codigo} | Créditos: ${curso.creditos}</div>
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
                    <li class="breadcrumb-item active" aria-current="page">Seleccionar Grupo</li>
                </ol>
            </nav>
        </div>

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

        <!-- Información del Curso -->
        <div class="calendar-container" style="margin-bottom: 30px;">
            <h3 style="margin-bottom: 20px;">Información del Curso</h3>
            <div class="row">
                <div class="col-md-8">
                    <h4 style="color: #21465b;">${curso.nombre}</h4>
                    <p class="text-muted">${curso.descripcion}</p>
                    <div class="row">
                        <div class="col-md-4">
                            <p><strong>Código:</strong> ${curso.codigo}</p>
                        </div>
                        <div class="col-md-4">
                            <p><strong>Créditos:</strong> ${curso.creditos}</p>
                        </div>
                        <div class="col-md-4">
                            <p><strong>Grupos disponibles:</strong> ${grupos.size()}</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 text-end">
                    <a href="/estudiantes/curso-detalle/${curso.id}" class="btn btn-outline-primary">
                        <i class="fas fa-info-circle"></i> Ver Detalles Completos
                    </a>
                </div>
            </div>
        </div>

        <!-- Instrucciones -->
        <div class="alert alert-info">
            <i class="fas fa-info-circle"></i> 
            <strong>Selecciona un grupo:</strong> Elige el horario que mejor se adapte a tu disponibilidad académica.
        </div>

        <!-- Formulario de Selección de Grupos -->
        <form method="POST" action="/estudiantes/confirmar-inscripcion">
            <input type="hidden" name="cursoId" value="${curso.id}">
            
            <div class="calendar-container">
                <h3 style="margin-bottom: 20px;">Grupos Disponibles</h3>
                
                <div class="row g-3">
                    <c:forEach items="${grupos}" var="grupo" varStatus="status">
                        <div class="col-md-12">
                            <div class="card grupo-card">
                                <div class="card-body">
                                    <div class="row align-items-center">
                                        <div class="col-md-1">
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" 
                                                       name="grupoId" value="${grupo.id}" 
                                                       id="grupo${status.index}" required>
                                            </div>
                                        </div>
                                        <div class="col-md-7">
                                            <label class="form-check-label w-100" for="grupo${status.index}" style="cursor: pointer;">
                                                <h5 class="card-title d-flex align-items-center mb-2">
                                                    ${grupo.nombre}
                                                    <span class="badge bg-success ms-2">${grupo.cupos} cupos disponibles</span>
                                                </h5>
                                                <div class="grupo-info">
                                                    <p class="mb-1">
                                                        <i class="fas fa-calendar-alt text-primary me-2"></i>
                                                        <strong>Días:</strong> ${grupo.horario}
                                                    </p>
                                                    <p class="mb-1">
                                                        <i class="fas fa-clock text-info me-2"></i>
                                                        <strong>Horario:</strong> ${grupo.hora}
                                                    </p>
                                                    <p class="mb-1">
                                                        <i class="fas fa-user text-success me-2"></i>
                                                        <strong>Profesor:</strong> ${grupo.profesor}
                                                    </p>
                                                    <p class="mb-0">
                                                        <i class="fas fa-map-marker-alt text-warning me-2"></i>
                                                        <strong>Aula:</strong> ${grupo.salon}
                                                    </p>
                                                </div>
                                            </label>
                                        </div>
                                        <div class="col-md-4 text-end">
                                            <div class="horario-resumen">
                                                <h6 class="text-muted">Horario Semanal</h6>
                                                <div style="font-size: 14px;">
                                                    <strong>${grupo.horario}</strong><br>
                                                    ${grupo.hora}
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <!-- Botones de Acción -->
                <div class="d-flex justify-content-between mt-4">
                    <a href="/estudiantes/cursos-disponibles" class="btn btn-secondary">
                        <i class="fas fa-arrow-left"></i> Volver a Cursos
                    </a>
                    <button type="submit" class="btn btn-success btn-lg">
                        <i class="fas fa-check"></i> Confirmar Inscripción
                    </button>
                </div>
            </div>
        </form>

        <!-- Información Adicional -->
        <div class="calendar-container" style="margin-top: 30px;">
            <h4>Información Importante</h4>
            <div class="row">
                <div class="col-md-6">
                    <h6><i class="fas fa-exclamation-triangle text-warning"></i> Antes de inscribirte</h6>
                    <ul class="list-unstyled">
                        <li><i class="fas fa-check text-success"></i> Verifica que no tengas conflictos de horario</li>
                        <li><i class="fas fa-check text-success"></i> Confirma que cumples los prerrequisitos</li>
                        <li><i class="fas fa-check text-success"></i> Revisa la disponibilidad de cupos</li>
                    </ul>
                </div>
                <div class="col-md-6">
                    <h6><i class="fas fa-info-circle text-info"></i> Después de la inscripción</h6>
                    <ul class="list-unstyled">
                        <li><i class="fas fa-arrow-right text-primary"></i> Podrás ver el curso en "Mis Materias"</li>
                        <li><i class="fas fa-arrow-right text-primary"></i> El horario se agregará automáticamente</li>
                        <li><i class="fas fa-arrow-right text-primary"></i> Recibirás confirmación por correo</li>
                    </ul>
                </div>
            </div>
        </div>
    </main>
</div>

<style>
.grupo-card {
    transition: all 0.3s ease;
    border: 2px solid #dee2e6;
    cursor: pointer;
}

.grupo-card:hover {
    border-color: #007bff;
    box-shadow: 0 4px 8px rgba(0,0,0,0.1);
}

.grupo-card:has(input:checked) {
    border-color: #28a745;
    background-color: #f8fff9;
    box-shadow: 0 4px 12px rgba(40, 167, 69, 0.2);
}

.grupo-info p {
    font-size: 14px;
    color: #6c757d;
}

.form-check-input:checked {
    background-color: #28a745;
    border-color: #28a745;
}

.form-check-input {
    transform: scale(1.3);
}

.horario-resumen {
    background-color: #f8f9fa;
    padding: 15px;
    border-radius: 8px;
    border-left: 4px solid #007bff;
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

.badge {
    font-size: 11px;
}

.alert {
    margin-bottom: 20px;
}
</style>

</body>
</html> 