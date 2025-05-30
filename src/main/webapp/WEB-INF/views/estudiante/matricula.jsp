<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Matrícula - Sistema Académico</title>
    <link rel="stylesheet" href="/css/profesor.css">
    <link rel="stylesheet" href="/css/matricula.css">
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
                <li class="active"><a href="/estudiantes/matricula" style="text-decoration: none; color: inherit;"><span>Matrícula</span></a></li>
                <li><span>Inclusiones</span></li>
                <li><a href="/estudiantes/materias" style="text-decoration: none; color: inherit;"><span>Materias</span></a></li>
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
                <h2>Matrícula de Semestre, <span class="highlight">${nombre}</span></h2>
                <div class="date">Proceso de matrícula académica</div>
            </div>
            <div class="header-actions">
                <input type="text" placeholder="Buscar curso" class="search">
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

        <!-- Información del Estudiante -->
        <div class="dashboard-summary" style="margin-bottom: 30px;">
            <section class="next-class-section">
                <h3>Información del Estudiante</h3>
                <div class="next-class-info">
                    <span><strong>Nombre:</strong> ${estudiante.nombre != null ? estudiante.nombre : nombre}</span>
                    <span class="class-code">Código: ${estudiante.codigo != null ? estudiante.codigo : 'N/A'}</span>
                    <span class="class-code">Semestre: ${estudiante.semestreActual != null ? estudiante.semestreActual : 'N/A'}</span>
                </div>
            </section>
            <section class="teacher-rating-section">
                <h3>Créditos</h3>
                <div class="teacher-rating-info">
                    <span class="rating-value">15</span>
                    <span style="font-size:14px;color:var(--dark-gray);">Disponibles</span>
                </div>
            </section>
            <section class="workload-section">
                <h3>Estado</h3>
                <div class="workload-info">
                    <span class="workload-hours" style="color: #28a745;">Activo</span>
                    <span style="font-size:14px;color:var(--dark-gray);">Para matrícula</span>
                </div>
            </section>
        </div>

        <!-- Selector de Semestre -->
        <div class="calendar-container" style="margin-bottom: 30px; padding: 20px;">
            <h3 style="margin-bottom: 20px;">Seleccionar Semestre</h3>
            <div class="row g-3">
                <div class="col-md-6">
                    <label for="semestre" class="form-label" style="font-weight: 600;">Semestre a Matricular</label>
                    <select class="form-select" id="semestre" name="semestre" onchange="cargarMaterias()">
                        <option value="">Seleccione un semestre</option>
                        <c:forEach var="sem" items="${semestres}">
                            <option value="${sem.id}">${sem.nombre != null ? sem.nombre : 'Semestre ' += sem.id}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-6">
                    <label class="form-label" style="font-weight: 600;">Período Académico</label>
                    <input type="text" class="form-control" value="2025-1" readonly>
                </div>
            </div>
        </div>

        <!-- Materias Disponibles -->
        <div class="calendar-container">
            <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:20px;">
                <h3>Materias Disponibles</h3>
                <button class="search" onclick="procesarMatricula()" style="padding:8px 16px; background-color: #28a745;">
                    <i class="fas fa-check"></i> Matricular Seleccionadas
                </button>
            </div>

            <div id="materiasContainer">
                <div style="text-align: center; padding: 40px; color: #6c757d;">
                    <i class="fas fa-graduation-cap" style="font-size: 48px; margin-bottom: 20px; color: #dee2e6;"></i>
                    <h4>Selecciona un semestre</h4>
                    <p>Primero selecciona el semestre para ver las materias disponibles</p>
                </div>
            </div>

            <!-- Template para materias (oculto) -->
            <div id="materiaTemplate" style="display: none;">
                <div class="row g-3 materias-container">
                    <!-- Materias se cargarán aquí dinámicamente -->
                </div>
            </div>
        </div>

        <!-- Resumen de Matrícula -->
        <div class="calendar-container" style="margin-top: 30px; display: none;" id="resumenMatricula">
            <h3 style="margin-bottom: 20px;">Resumen de Matrícula</h3>
            <div class="row">
                <div class="col-md-8">
                    <div id="materiasSeleccionadas">
                        <!-- Materias seleccionadas aparecerán aquí -->
                    </div>
                </div>
                <div class="col-md-4">
                    <div style="background-color: #f8f9fa; padding: 20px; border-radius: 8px;">
                        <h5>Total</h5>
                        <p><strong>Materias:</strong> <span id="totalMaterias">0</span></p>
                        <p><strong>Créditos:</strong> <span id="totalCreditos">0</span></p>
                        <hr>
                        <button class="btn btn-success w-100" onclick="confirmarMatricula()">
                            <i class="fas fa-save"></i> Confirmar Matrícula
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </main>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
let materiasSeleccionadas = new Set();
let materiasData = [];

function cargarMaterias() {
    const semestreId = document.getElementById('semestre').value;
    const container = document.getElementById('materiasContainer');
    
    if (!semestreId) {
        container.innerHTML = `
            <div style="text-align: center; padding: 40px; color: #6c757d;">
                <i class="fas fa-graduation-cap" style="font-size: 48px; margin-bottom: 20px; color: #dee2e6;"></i>
                <h4>Selecciona un semestre</h4>
                <p>Primero selecciona el semestre para ver las materias disponibles</p>
            </div>
        `;
        return;
    }

    // Simular carga de materias (reemplazar con llamada real al backend)
    const materiasMock = [
        {id: 1, nombre: 'Cálculo I', codigo: 'MAT001', creditos: 4, cupos: 30, profesor: 'Dr. García'},
        {id: 2, nombre: 'Programación I', codigo: 'SIS001', creditos: 3, cupos: 25, profesor: 'Ing. López'},
        {id: 3, nombre: 'Física I', codigo: 'FIS001', creditos: 4, cupos: 20, profesor: 'Dr. Martínez'},
        {id: 4, nombre: 'Inglés I', codigo: 'ING001', creditos: 2, cupos: 35, profesor: 'Prof. Smith'}
    ];

    materiasData = materiasMock;
    mostrarMaterias(materiasMock);
}

function mostrarMaterias(materias) {
    const container = document.getElementById('materiasContainer');
    
    let html = '<div class="row g-3 materias-container">';
    
    materias.forEach(materia => {
        html += `
            <div class="col-md-6">
                <div class="card course-card materia-card" onclick="toggleMateria(${materia.id})" id="materia-${materia.id}">
                    <div class="card-body">
                        <div style="display: flex; justify-content: space-between; align-items: start;">
                            <h6 class="card-title">${materia.nombre}</h6>
                            <i class="fas fa-check-circle" style="color: #28a745; display: none;" id="check-${materia.id}"></i>
                        </div>
                        <div class="materia-info">
                            <p class="mb-1"><i class="fas fa-code"></i> Código: ${materia.codigo}</p>
                            <p class="mb-1"><i class="fas fa-credit-card"></i> Créditos: ${materia.creditos}</p>
                            <p class="mb-1"><i class="fas fa-users"></i> Cupos: ${materia.cupos}</p>
                            <p class="mb-1"><i class="fas fa-user"></i> Profesor: ${materia.profesor}</p>
                        </div>
                    </div>
                </div>
            </div>
        `;
    });
    
    html += '</div>';
    container.innerHTML = html;
}

function toggleMateria(materiaId) {
    const card = document.getElementById(`materia-${materiaId}`);
    const check = document.getElementById(`check-${materiaId}`);
    
    if (materiasSeleccionadas.has(materiaId)) {
        // Deseleccionar
        materiasSeleccionadas.delete(materiaId);
        card.classList.remove('selected');
        check.style.display = 'none';
    } else {
        // Seleccionar
        materiasSeleccionadas.add(materiaId);
        card.classList.add('selected');
        check.style.display = 'block';
    }
    
    actualizarResumen();
}

function actualizarResumen() {
    const resumen = document.getElementById('resumenMatricula');
    const totalMaterias = document.getElementById('totalMaterias');
    const totalCreditos = document.getElementById('totalCreditos');
    
    if (materiasSeleccionadas.size > 0) {
        resumen.style.display = 'block';
        
        let creditos = 0;
        materiasSeleccionadas.forEach(id => {
            const materia = materiasData.find(m => m.id === id);
            if (materia) creditos += materia.creditos;
        });
        
        totalMaterias.textContent = materiasSeleccionadas.size;
        totalCreditos.textContent = creditos;
    } else {
        resumen.style.display = 'none';
    }
}

function procesarMatricula() {
    if (materiasSeleccionadas.size === 0) {
        alert('Debe seleccionar al menos una materia');
        return;
    }
    
    const semestreId = document.getElementById('semestre').value;
    if (!semestreId) {
        alert('Debe seleccionar un semestre');
        return;
    }
    
    // Mostrar confirmación
    const materiasNombres = Array.from(materiasSeleccionadas).map(id => {
        const materia = materiasData.find(m => m.id === id);
        return materia ? materia.nombre : '';
    }).join(', ');
    
    if (confirm(`¿Está seguro de matricular las siguientes materias?\n\n${materiasNombres}`)) {
        confirmarMatricula();
    }
}

function confirmarMatricula() {
    // Aquí se haría la llamada al backend
    const datos = {
        semestreId: document.getElementById('semestre').value,
        materias: Array.from(materiasSeleccionadas)
    };
    
    console.log('Datos a enviar:', datos);
    
    // Simular éxito
    alert('¡Matrícula procesada exitosamente!');
    window.location.href = '/estudiantes/materias';
}
</script>

<style>
.materia-card {
    cursor: pointer;
    transition: all 0.3s ease;
    border: 2px solid #dee2e6;
}

.materia-card:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 8px rgba(0,0,0,0.1);
}

.materia-card.selected {
    border-color: #28a745;
    background-color: #f8fff9;
}

.materia-info p {
    font-size: 14px;
    color: #6c757d;
    margin-bottom: 5px;
}

.materia-info i {
    width: 16px;
    margin-right: 8px;
}
</style>

</body>
</html> 