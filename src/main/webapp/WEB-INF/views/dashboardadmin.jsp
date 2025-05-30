<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Dashboard Administrador - Sistema Académico</title>
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
                <li class="active"><a href="/admin/dashboard"><span><i class="fas fa-home"></i> Inicio</span></a></li>
                <li><a href="/cursos"><span><i class="fas fa-book"></i> Gestión de Cursos</span></a></li>
                <li><a href="/materias"><span><i class="fas fa-graduation-cap"></i> Gestión de Materias</span></a></li>
                <li><a href="/horarios"><span><i class="fas fa-clock"></i> Horarios</span></a></li>
                <li><a href="/inscripciones"><span><i class="fas fa-user-plus"></i> Inscripciones</span></a></li>
                <li><a href="/mensajes"><span><i class="fas fa-envelope"></i> Mensajes <span class="badge">5</span></span></a></li>
                <li><a href="/reportes"><span><i class="fas fa-chart-bar"></i> Reportes</span></a></li>
                <li><a href="/ajustes"><span><i class="fas fa-cog"></i> Ajustes</span></a></li>
            </ul>
        </nav>
        <div class="sidebar-footer">
            <a href="#"><i class="fas fa-question-circle"></i> Ayuda</a>
            <a href="/contacto"><i class="fas fa-envelope"></i> Contáctenos</a>
            <a href="/logout"><i class="fas fa-sign-out-alt"></i> Cerrar sesión</a>
        </div>
    </aside>
    <main class="main-content">
        <header class="header">
            <div>
                <h2>Bienvenido, <span class="highlight">${nombre}</span></h2>
                <div class="date">${fechaActual}</div>
            </div>
            <div class="header-actions">
                <input type="text" placeholder="Búsqueda" class="search">
                <div class="notification">
                    <span class="notif-badge">${notificacionesPendientes}</span>
                    <i class="fas fa-bell"></i>
                </div>
                <div class="profile">
                    <img src="/image/Perfil.png" alt="Perfil" />
                    <span>${nombre}</span>
                </div>
            </div>
        </header>

        <div class="dashboard-summary">
            <section class="next-class-section">
                <h3>Total de Cursos</h3>
                <div class="next-class-info">
                    <span class="class-name"><strong>${totalCursos}</strong></span>
                    <span class="class-code">Cursos Activos</span>
                    <button class="action-button" onclick="location.href='/admin/cursos/nuevo'">
                        <i class="fas fa-plus"></i> Nuevo Curso
                    </button>
                </div>
            </section>

            <section class="teacher-rating-section">
                <h3>Profesores</h3>
                <div class="teacher-rating-info">
                    <span class="rating-value">${totalProfesores}</span>
                    <span>Profesores Registrados</span>
                </div>
            </section>

            <section class="workload-section">
                <h3>Estudiantes</h3>
                <div class="workload-info">
                    <span class="workload-hours">${totalEstudiantes}</span>
                    <span>Estudiantes Activos</span>
                </div>
            </section>
        </div>

        <div style="display:flex;gap:30px;">
            <div class="calendar-container" style="flex:2;">
                <h3>Cursos Recientes</h3>
                <div class="cursos-list">
                    <c:forEach items="${cursosRecientes}" var="curso">
                        <div class="curso-item">
                            <div class="curso-header">
                                <h4>${curso.nombre}</h4>
                                <span class="curso-codigo">${curso.codigo}</span>
                            </div>
                            <div class="curso-info">
                                <p><strong>Horario:</strong> ${curso.horario}</p>
                                <p><strong>Cupos:</strong> ${curso.cuposDisponibles}</p>
                            </div>
                            <div class="curso-actions">
                                <button class="btn-edit" onclick="location.href='/admin/cursos/editar/${curso.id}'">
                                    <i class="fas fa-edit"></i> Editar
                                </button>
                                <button class="btn-delete" onclick="confirmarEliminar(${curso.id})">
                                    <i class="fas fa-trash"></i> Eliminar
                                </button>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
            <div class="calendar-container" style="flex:1;">
                <h3>Actividad Reciente</h3>
                <div class="activity-feed">
                    <c:forEach items="${actividadesRecientes}" var="actividad">
                        <div class="activity-item">
                            <i class="fas fa-${actividad.icono}"></i>
                            <div class="activity-content">
                                <span class="activity-title">${actividad.titulo}</span>
                                <span class="activity-time">${actividad.tiempo}</span>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </main>
</div>

<style>
.action-button {
    background-color: var(--secondary-color);
    color: white;
    border: none;
    padding: 8px 16px;
    border-radius: 4px;
    cursor: pointer;
    font-size: 14px;
    display: flex;
    align-items: center;
    gap: 8px;
    margin-top: 10px;
}

.cursos-list {
    display: flex;
    flex-direction: column;
    gap: 15px;
    margin-top: 20px;
}

.curso-item {
    background-color: white;
    border: 1px solid var(--light-gray);
    border-radius: 8px;
    padding: 15px;
}

.curso-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 10px;
}

.curso-header h4 {
    margin: 0;
    color: var(--primary-color);
}

.curso-codigo {
    background-color: var(--light-gray);
    padding: 4px 8px;
    border-radius: 4px;
    font-size: 14px;
}

.curso-info {
    margin-bottom: 15px;
}

.curso-info p {
    margin: 5px 0;
    font-size: 14px;
}

.curso-actions {
    display: flex;
    gap: 10px;
}

.btn-edit, .btn-delete {
    padding: 6px 12px;
    border-radius: 4px;
    border: none;
    cursor: pointer;
    font-size: 14px;
    display: flex;
    align-items: center;
    gap: 5px;
}

.btn-edit {
    background-color: var(--secondary-color);
    color: white;
}

.btn-delete {
    background-color: #dc3545;
    color: white;
}

.activity-feed {
    display: flex;
    flex-direction: column;
    gap: 15px;
}

.activity-item {
    display: flex;
    align-items: center;
    gap: 15px;
    padding: 10px;
    border-radius: 8px;
    background-color: #f8f9fa;
}

.activity-item i {
    color: var(--secondary-color);
    font-size: 20px;
}

.activity-content {
    display: flex;
    flex-direction: column;
}

.activity-title {
    font-weight: 600;
    color: var(--text-color);
}

.activity-time {
    font-size: 12px;
    color: var(--dark-gray);
}

/* Estilos adicionales para el sidebar */
.sidebar nav ul li a {
    text-decoration: none;
    color: inherit;
    display: block;
    width: 100%;
    padding: 12px 20px;
}

.sidebar nav ul li a span {
    display: flex;
    align-items: center;
    gap: 10px;
}

.sidebar nav ul li a i {
    width: 20px;
    text-align: center;
}

.sidebar nav ul li:hover {
    background-color: rgba(255, 255, 255, 0.1);
}

.sidebar nav ul li.active {
    background-color: var(--secondary-color);
}

.sidebar-footer a {
    display: flex;
    align-items: center;
    gap: 8px;
    padding: 8px 0;
}

.sidebar-footer a i {
    width: 20px;
    text-align: center;
}
</style>

<script>
function confirmarEliminar(cursoId) {
    if (confirm('¿Estás seguro de que deseas eliminar este curso?')) {
        window.location.href = '/cursos/eliminar/' + cursoId;
    }
}

// Marcar el ítem activo en el sidebar
document.addEventListener('DOMContentLoaded', function() {
    const currentPath = window.location.pathname;
    const sidebarItems = document.querySelectorAll('.sidebar nav ul li');
    
    sidebarItems.forEach(item => {
        const link = item.querySelector('a');
        if (link && currentPath === link.getAttribute('href')) {
            item.classList.add('active');
        } else {
            item.classList.remove('active');
        }
    });
});
</script>
</body>
</html> 
</html> 