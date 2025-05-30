<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Cursos Disponibles - Sistema Académico</title>
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
                <h2>Cursos Disponibles, <span class="highlight">${nombre}</span></h2>
                <div class="date">Catálogo de cursos académicos</div>
            </div>
            <div class="header-actions">
                <form method="GET" action="/estudiantes/cursos-disponibles" style="display: inline;">
                    <input type="text" name="buscar" placeholder="Buscar curso" class="search" value="${param.buscar}">
                    <button type="submit" class="btn btn-sm btn-outline-primary">
                        <i class="fas fa-search"></i>
                    </button>
                </form>
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

        <!-- Mensajes de confirmación/error -->
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

        <!-- Filtros y Estadísticas -->
        <div class="dashboard-summary" style="margin-bottom: 30px;">
            <section class="next-class-section">
                <h3>Total Cursos</h3>
                <div class="next-class-info">
                    <span class="rating-value" style="font-size: 28px; color: #21465b;">${cursosDisponibles != null ? cursosDisponibles.size() : 0}</span>
                    <span class="class-code">Disponibles este semestre</span>
                </div>
            </section>
            <section class="teacher-rating-section">
                <h3>Filtros</h3>
                <div class="teacher-rating-info">
                    <form method="GET" action="/estudiantes/cursos-disponibles">
                        <input type="hidden" name="buscar" value="${param.buscar}">
                        <select name="creditos" class="form-select form-select-sm" onchange="this.form.submit()">
                            <option value="">Todos los créditos</option>
                            <option value="2" ${param.creditos == '2' ? 'selected' : ''}>2 créditos</option>
                            <option value="3" ${param.creditos == '3' ? 'selected' : ''}>3 créditos</option>
                            <option value="4" ${param.creditos == '4' ? 'selected' : ''}>4 créditos</option>
                            <option value="5" ${param.creditos == '5' ? 'selected' : ''}>5 créditos</option>
                        </select>
                    </form>
                </div>
            </section>
            <section class="workload-section">
                <h3>Estado</h3>
                <div class="workload-info">
                    <span class="workload-hours" style="color: #007bff;">Abierto</span>
                    <span style="font-size:14px;color:var(--dark-gray);">Período de inscripción</span>
                </div>
            </section>
        </div>

        <!-- Lista de Cursos -->
        <div class="calendar-container">
            <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:20px;">
                <h3>Catálogo de Cursos</h3>
                <div>
                    <a href="/estudiantes/cursos-disponibles?vista=grid${not empty param.buscar ? '&buscar=' + param.buscar : ''}${not empty param.creditos ? '&creditos=' + param.creditos : ''}" 
                       class="search ${param.vista != 'list' ? 'active' : ''}" style="margin-right: 10px;">
                        <i class="fas fa-th"></i> Cuadrícula
                    </a>
                    <a href="/estudiantes/cursos-disponibles?vista=list${not empty param.buscar ? '&buscar=' + param.buscar : ''}${not empty param.creditos ? '&creditos=' + param.creditos : ''}" 
                       class="search ${param.vista == 'list' ? 'active' : ''}">
                        <i class="fas fa-list"></i> Lista
                    </a>
                </div>
            </div>

            <!-- Vista en Cuadrícula -->
            <c:if test="${param.vista != 'list'}">
                <div style="display: grid; grid-template-columns: repeat(auto-fill, minmax(350px, 1fr)); gap: 20px;">
                    <c:choose>
                        <c:when test="${not empty cursosDisponibles}">
                            <c:forEach items="${cursosDisponibles}" var="curso" varStatus="status">
                                <div class="curso-card">
                                    <div class="calendar-container" style="padding: 20px; border: 1px solid #dee2e6; border-radius: 10px; height: 100%;">
                                        <div style="display: flex; justify-content: space-between; align-items: start; margin-bottom: 15px;">
                                            <h4 style="margin: 0; color: #21465b; font-size: 16px;">${curso.nombre != null ? curso.nombre : 'Curso ' += (status.index + 1)}</h4>
                                            <span class="badge" style="background-color: #007bff; color: white; padding: 4px 8px; border-radius: 4px; font-size: 12px;">
                                                ${curso.creditos != null ? curso.creditos : '3'} Créditos
                                            </span>
                                        </div>
                                        
                                        <div style="margin-bottom: 15px;">
                                            <p style="margin: 5px 0; color: #6c757d; font-size: 14px;">
                                                <i class="fas fa-code"></i> Código: ${curso.codigo != null ? curso.codigo : 'N/A'}
                                            </p>
                                            <p style="margin: 5px 0; color: #6c757d; font-size: 14px;">
                                                <i class="fas fa-user"></i> Profesor: ${curso.profesor != null ? curso.profesor : 'Por asignar'}
                                            </p>
                                            <p style="margin: 5px 0; color: #6c757d; font-size: 14px;">
                                                <i class="fas fa-clock"></i> Horarios disponibles: 3 grupos
                                            </p>
                                            <p style="margin: 5px 0; color: #6c757d; font-size: 14px;">
                                                <i class="fas fa-users"></i> Cupos: ${curso.cuposDisponibles != null ? curso.cuposDisponibles : '30'} disponibles
                                            </p>
                                        </div>

                                        <div style="margin-top: auto;">
                                            <div style="display: flex; gap: 10px;">
                                                <a href="/estudiantes/curso-detalle/${curso.id != null ? curso.id : status.index + 1}" 
                                                   class="btn btn-outline-primary btn-sm" style="flex: 1; text-decoration: none;">
                                                    <i class="fas fa-info-circle"></i> Detalles
                                                </a>
                                                <a href="/estudiantes/seleccionar-grupo/${curso.id != null ? curso.id : status.index + 1}" 
                                                   class="btn btn-success btn-sm" style="flex: 1; text-decoration: none;">
                                                    <i class="fas fa-plus"></i> Inscribir
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div style="grid-column: 1 / -1; text-align: center; padding: 40px; color: #6c757d;">
                                <i class="fas fa-graduation-cap" style="font-size: 48px; margin-bottom: 20px; color: #dee2e6;"></i>
                                <h3>No hay cursos disponibles</h3>
                                <p>No se encontraron cursos disponibles en este momento.</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </c:if>

            <!-- Vista en Lista -->
            <c:if test="${param.vista == 'list'}">
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead class="table-light">
                            <tr>
                                <th>Código</th>
                                <th>Nombre del Curso</th>
                                <th>Créditos</th>
                                <th>Profesor</th>
                                <th>Grupos</th>
                                <th>Cupos</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${cursosDisponibles}" var="curso" varStatus="status">
                                <tr>
                                    <td><code>${curso.codigo != null ? curso.codigo : 'CUR00' += (status.index + 1)}</code></td>
                                    <td><strong>${curso.nombre != null ? curso.nombre : 'Curso ' += (status.index + 1)}</strong></td>
                                    <td>
                                        <span class="badge bg-primary">${curso.creditos != null ? curso.creditos : '3'}</span>
                                    </td>
                                    <td>${curso.profesor != null ? curso.profesor : 'Por asignar'}</td>
                                    <td><small class="text-muted">3 horarios disponibles</small></td>
                                    <td>
                                        <span class="badge bg-success">${curso.cuposDisponibles != null ? curso.cuposDisponibles : '30'}</span>
                                    </td>
                                    <td>
                                        <div class="btn-group" role="group">
                                            <a href="/estudiantes/curso-detalle/${curso.id != null ? curso.id : status.index + 1}" 
                                               class="btn btn-outline-primary btn-sm">
                                                <i class="fas fa-info-circle"></i>
                                            </a>
                                            <a href="/estudiantes/seleccionar-grupo/${curso.id != null ? curso.id : status.index + 1}" 
                                               class="btn btn-success btn-sm">
                                                <i class="fas fa-plus"></i>
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:if>
        </div>
    </main>
</div>

<style>
.curso-card {
    transition: transform 0.2s ease;
}

.curso-card:hover {
    transform: translateY(-2px);
}

.table th {
    border-top: none;
    font-weight: 600;
    color: #495057;
}

.btn-group .btn {
    border-radius: 4px;
    margin-right: 2px;
}

.badge {
    font-size: 11px;
}

.search.active {
    background-color: #007bff;
    color: white;
}

.alert {
    margin-bottom: 20px;
}
</style>

</body>
</html> 