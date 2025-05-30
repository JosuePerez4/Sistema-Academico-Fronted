<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Lista de Cursos - Sistema Académico</title>
    <link rel="stylesheet" href="/css/styles.css">
    <link rel="stylesheet" href="/css/profesor.css">
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
                <li><a href="/dashboard"><span>Inicio</span></a></li>
                <li class="active"><a href="/cursos"><span>Gestión de Cursos</span></a></li>
                <li><a href="/materias"><span>Gestión de Materias</span></a></li>
                <li><a href="/horarios"><span>Horarios</span></a></li>
                <li><a href="/mensajes"><span>Mensajes</span></a></li>
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
                <h2>Gestión de Cursos</h2>
                <div class="date">${fechaActual}</div>
            </div>
            <div class="header-actions">
                <a href="/cursos/nuevo" class="btn-primary">
                    <i class="fas fa-plus"></i> Nuevo Curso
                </a>
            </div>
        </header>

        <div class="cursos-container">
            <div class="filters">
                <input type="text" id="searchInput" placeholder="Buscar cursos..." class="search-input">
                <select id="filterPeriodo" class="filter-select">
                    <option value="">Todos los períodos</option>
                    <option value="2024-1">2024-1</option>
                    <option value="2023-2">2023-2</option>
                </select>
            </div>

            <div class="cursos-grid">
                <c:forEach items="${cursos}" var="curso">
                    <div class="curso-card">
                        <div class="curso-header">
                            <h3>${curso.nombre}</h3>
                            <span class="codigo">${curso.codigo}</span>
                        </div>
                        <div class="curso-content">
                            <p><strong>Profesor:</strong> ${curso.profesor}</p>
                            <p><strong>Cupos:</strong> ${curso.cuposDisponibles}</p>
                            <p><strong>Horario:</strong> ${curso.horario}</p>
                        </div>
                        <div class="curso-actions">
                            <a href="/cursos/editar/${curso.id}" class="btn-edit">
                                <i class="fas fa-edit"></i> Editar
                            </a>
                            <button onclick="confirmarEliminar(${curso.id})" class="btn-delete">
                                <i class="fas fa-trash"></i> Eliminar
                            </button>
                            <a href="/cursos/detalles/${curso.id}" class="btn-view">
                                <i class="fas fa-eye"></i> Ver Detalles
                            </a>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </main>
</div>

<style>
.cursos-container {
    padding: 20px;
}

.filters {
    display: flex;
    gap: 20px;
    margin-bottom: 30px;
}

.search-input, .filter-select {
    padding: 10px;
    border: 1px solid var(--light-gray);
    border-radius: 8px;
    font-size: 14px;
}

.search-input {
    flex: 1;
    max-width: 300px;
}

.cursos-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
    gap: 30px;
}

.curso-card {
    background: white;
    border-radius: 12px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
    padding: 20px;
}

.curso-header {
    display: flex;
    justify-content: space-between;
    align-items: start;
    margin-bottom: 15px;
}

.curso-header h3 {
    margin: 0;
    font-size: 18px;
    color: var(--primary-color);
}

.codigo {
    background: var(--light-gray);
    padding: 4px 8px;
    border-radius: 4px;
    font-size: 14px;
    color: var(--dark-gray);
}

.curso-content {
    margin-bottom: 20px;
}

.curso-content p {
    margin: 8px 0;
    font-size: 14px;
}

.curso-actions {
    display: flex;
    gap: 10px;
}

.btn-primary, .btn-edit, .btn-delete, .btn-view {
    padding: 8px 16px;
    border-radius: 6px;
    border: none;
    cursor: pointer;
    font-size: 14px;
    display: inline-flex;
    align-items: center;
    gap: 5px;
    text-decoration: none;
}

.btn-primary {
    background: var(--secondary-color);
    color: white;
}

.btn-edit {
    background: var(--secondary-color);
    color: white;
}

.btn-delete {
    background: #dc3545;
    color: white;
}

.btn-view {
    background: var(--light-gray);
    color: var(--text-color);
}
</style>

<script>
function confirmarEliminar(cursoId) {
    if (confirm('¿Estás seguro de que deseas eliminar este curso?')) {
        window.location.href = '/cursos/eliminar/' + cursoId;
    }
}

document.getElementById('searchInput').addEventListener('input', function(e) {
    const searchTerm = e.target.value.toLowerCase();
    const cursoCards = document.querySelectorAll('.curso-card');
    
    cursoCards.forEach(card => {
        const nombre = card.querySelector('h3').textContent.toLowerCase();
        const codigo = card.querySelector('.codigo').textContent.toLowerCase();
        
        if (nombre.includes(searchTerm) || codigo.includes(searchTerm)) {
            card.style.display = '';
        } else {
            card.style.display = 'none';
        }
    });
});

document.getElementById('filterPeriodo').addEventListener('change', function(e) {
    const periodo = e.target.value;
    // Implementar filtrado por período
});
</script>
</body>
</html> 