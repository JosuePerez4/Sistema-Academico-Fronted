<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Registrar Asistencia - Sistema Académico</title>
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
                <h2>Registrar Asistencia, <span class="highlight">${nombre}</span></h2>
                <div class="date">Control diario de asistencia</div>
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
                    <li class="breadcrumb-item"><a href="/estudiantes/asistencias">Asistencias</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Registrar Asistencia</li>
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

        <!-- Información de la Materia -->
        <div class="calendar-container" style="margin-bottom: 30px;">
            <h3 style="margin-bottom: 20px;">
                <i class="fas fa-book text-primary"></i> 
                ${inscripcion.nombreMateria != null ? inscripcion.nombreMateria : 'Materia'}
            </h3>
            <div class="row">
                <div class="col-md-6">
                    <p><strong>ID Inscripción:</strong> ${inscripcionId}</p>
                    <p><strong>Fecha:</strong> ${fechaHoy}</p>
                    <p><strong>Profesor:</strong> ${inscripcion.nombreProfesor != null ? inscripcion.nombreProfesor : 'Por asignar'}</p>
                </div>
                <div class="col-md-6">
                    <div class="alert alert-info">
                        <i class="fas fa-calendar-day"></i>
                        <strong>Fecha de hoy:</strong> ${fechaHoy}
                        <br>
                        <small>Tu asistencia será registrada para esta fecha</small>
                    </div>
                </div>
            </div>
        </div>

        <!-- Verificación si ya fue registrada -->
        <c:if test="${yaRegistradaHoy}">
            <div class="alert alert-warning">
                <i class="fas fa-exclamation-triangle"></i>
                <strong>¡Atención!</strong> Ya has registrado tu asistencia para el día de hoy en esta materia.
                <br>
                <small>Si necesitas modificarla, contacta a tu profesor o administrador.</small>
            </div>
        </c:if>

        <!-- Formulario de Registro de Asistencia -->
        <c:if test="${!yaRegistradaHoy}">
            <form method="POST" action="/estudiantes/confirmar-asistencia">
                <input type="hidden" name="inscripcionId" value="${inscripcionId}">
                <input type="hidden" name="fecha" value="${fechaHoy}">
                
                <div class="calendar-container">
                    <h3 style="margin-bottom: 20px;">
                        <i class="fas fa-check-circle text-success"></i> 
                        Registra tu Asistencia
                    </h3>
                    
                    <div class="row g-3">
                        <!-- Opción PRESENTE -->
                        <div class="col-md-12">
                            <div class="card estado-card presente-card">
                                <div class="card-body">
                                    <div class="row align-items-center">
                                        <div class="col-md-1">
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" 
                                                       name="estado" value="PRESENTE" 
                                                       id="presente" required>
                                            </div>
                                        </div>
                                        <div class="col-md-8">
                                            <label class="form-check-label w-100" for="presente" style="cursor: pointer;">
                                                <h5 class="card-title d-flex align-items-center mb-2">
                                                    <i class="fas fa-check-circle text-success me-3"></i>
                                                    Presente
                                                </h5>
                                                <p class="mb-0 text-muted">
                                                    Asistí a la clase de hoy correctamente.
                                                </p>
                                            </label>
                                        </div>
                                        <div class="col-md-3 text-end">
                                            <span class="badge bg-success" style="font-size: 14px;">
                                                <i class="fas fa-star"></i> Recomendado
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Opción AUSENTE -->
                        <div class="col-md-12">
                            <div class="card estado-card ausente-card">
                                <div class="card-body">
                                    <div class="row align-items-center">
                                        <div class="col-md-1">
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" 
                                                       name="estado" value="AUSENTE" 
                                                       id="ausente">
                                            </div>
                                        </div>
                                        <div class="col-md-8">
                                            <label class="form-check-label w-100" for="ausente" style="cursor: pointer;">
                                                <h5 class="card-title d-flex align-items-center mb-2">
                                                    <i class="fas fa-times-circle text-danger me-3"></i>
                                                    Ausente
                                                </h5>
                                                <p class="mb-0 text-muted">
                                                    No asistí a la clase sin justificación.
                                                </p>
                                            </label>
                                        </div>
                                        <div class="col-md-3 text-end">
                                            <span class="badge bg-danger" style="font-size: 12px;">
                                                <i class="fas fa-exclamation-triangle"></i> Afecta calificación
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Opción JUSTIFICADO -->
                        <div class="col-md-12">
                            <div class="card estado-card justificado-card">
                                <div class="card-body">
                                    <div class="row align-items-center">
                                        <div class="col-md-1">
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" 
                                                       name="estado" value="JUSTIFICADO" 
                                                       id="justificado">
                                            </div>
                                        </div>
                                        <div class="col-md-8">
                                            <label class="form-check-label w-100" for="justificado" style="cursor: pointer;">
                                                <h5 class="card-title d-flex align-items-center mb-2">
                                                    <i class="fas fa-exclamation-circle text-warning me-3"></i>
                                                    Justificado
                                                </h5>
                                                <p class="mb-0 text-muted">
                                                    No asistí pero tengo una justificación válida.
                                                </p>
                                            </label>
                                        </div>
                                        <div class="col-md-3 text-end">
                                            <span class="badge bg-warning text-dark" style="font-size: 12px;">
                                                <i class="fas fa-file-alt"></i> Requiere justificación
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Campo de Justificación -->
                    <div class="justificacion-section" style="margin-top: 20px; display: none;">
                        <div class="card">
                            <div class="card-header bg-warning text-dark">
                                <h6 class="mb-0">
                                    <i class="fas fa-edit"></i> 
                                    Justificación Requerida
                                </h6>
                            </div>
                            <div class="card-body">
                                <label for="justificacion" class="form-label">
                                    <strong>Explica el motivo de tu ausencia:</strong>
                                </label>
                                <textarea class="form-control" id="justificacion" name="justificacion" 
                                          rows="3" placeholder="Describe brevemente el motivo de tu ausencia..."></textarea>
                                <small class="form-text text-muted mt-2">
                                    <i class="fas fa-info-circle"></i>
                                    Esta justificación será revisada por tu profesor.
                                </small>
                            </div>
                        </div>
                    </div>

                    <!-- Botones de Acción -->
                    <div class="d-flex justify-content-between mt-4">
                        <a href="/estudiantes/asistencias" class="btn btn-secondary">
                            <i class="fas fa-arrow-left"></i> Volver a Asistencias
                        </a>
                        <button type="submit" class="btn btn-success btn-lg">
                            <i class="fas fa-save"></i> Confirmar Asistencia
                        </button>
                    </div>
                </div>
            </form>
        </c:if>

        <!-- Si ya fue registrada, mostrar opciones -->
        <c:if test="${yaRegistradaHoy}">
            <div class="calendar-container">
                <h4>Opciones Disponibles</h4>
                <div class="row">
                    <div class="col-md-6">
                        <a href="/estudiantes/historial-asistencia/${inscripcionId}" class="btn btn-outline-primary w-100">
                            <i class="fas fa-history"></i> Ver Historial de Asistencias
                        </a>
                    </div>
                    <div class="col-md-6">
                        <a href="/estudiantes/asistencias" class="btn btn-primary w-100">
                            <i class="fas fa-arrow-left"></i> Volver a Asistencias
                        </a>
                    </div>
                </div>
            </div>
        </c:if>
    </main>
</div>

<style>
.estado-card {
    transition: all 0.3s ease;
    border: 2px solid #dee2e6;
    cursor: pointer;
    margin-bottom: 15px;
}

.estado-card:hover {
    border-color: #007bff;
    box-shadow: 0 4px 8px rgba(0,0,0,0.1);
}

.estado-card:has(input:checked) {
    box-shadow: 0 4px 12px rgba(0,0,0,0.15);
}

.presente-card:has(input:checked) {
    border-color: #28a745;
    background-color: #f8fff9;
}

.ausente-card:has(input:checked) {
    border-color: #dc3545;
    background-color: #fff5f5;
}

.justificado-card:has(input:checked) {
    border-color: #ffc107;
    background-color: #fffbf0;
}

.form-check-input:checked {
    background-color: #28a745;
    border-color: #28a745;
}

.form-check-input {
    transform: scale(1.3);
}

.justificacion-section {
    animation: slideDown 0.3s ease;
}

@keyframes slideDown {
    from {
        opacity: 0;
        transform: translateY(-10px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
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

.card-title {
    margin-bottom: 8px;
    font-size: 18px;
}
</style>

<script>
// Mostrar/ocultar campo de justificación
document.addEventListener('DOMContentLoaded', function() {
    const justificadoRadio = document.getElementById('justificado');
    const otrosRadios = document.querySelectorAll('input[name="estado"]:not(#justificado)');
    const justificacionSection = document.querySelector('.justificacion-section');
    const justificacionTextarea = document.getElementById('justificacion');

    function toggleJustificacion() {
        if (justificadoRadio.checked) {
            justificacionSection.style.display = 'block';
            justificacionTextarea.required = true;
        } else {
            justificacionSection.style.display = 'none';
            justificacionTextarea.required = false;
            justificacionTextarea.value = '';
        }
    }

    justificadoRadio.addEventListener('change', toggleJustificacion);
    otrosRadios.forEach(radio => {
        radio.addEventListener('change', toggleJustificacion);
    });
});
</script>

</body>
</html> 