<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de Materias - Sistema Académico</title>
    <link rel="stylesheet" href="/css/profesor.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
<div class="container">
    <%@ include file="../common/sidebar.jsp" %>
    <main class="main-content">
        <header class="header">
            <div class="header-title">
                <h1><i class="fas fa-book"></i> Gestión de Materias</h1>
                <p>Administra las materias del sistema académico</p>
            </div>
            <div class="header-actions">
                <div class="search-box">
                    <input type="text" id="searchInput" placeholder="Buscar materias..." onkeyup="filterTable()">
                    <i class="fas fa-search"></i>
                </div>
                <a href="/materias/nuevo" class="btn-primary">
                    <i class="fas fa-plus"></i> Nueva Materia
                </a>
            </div>
        </header>

        <div class="content-wrapper">
            <div class="table-container">
                <table class="data-table" id="materiasTable">
                    <thead>
                        <tr>
                            <th onclick="sortTable(0)">Código <i class="fas fa-sort"></i></th>
                            <th onclick="sortTable(1)">Nombre <i class="fas fa-sort"></i></th>
                            <th onclick="sortTable(2)">Créditos <i class="fas fa-sort"></i></th>
                            <th onclick="sortTable(3)">Departamento <i class="fas fa-sort"></i></th>
                            <th onclick="sortTable(4)">Nivel <i class="fas fa-sort"></i></th>
                            <th onclick="sortTable(5)">Estado <i class="fas fa-sort"></i></th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${materias}" var="materia">
                            <tr>
                                <td><strong>${materia.codigo}</strong></td>
                                <td>
                                    <div class="materia-info">
                                        <span class="materia-nombre">${materia.nombre}</span>
                                        <c:if test="${not empty materia.descripcion}">
                                            <span class="materia-descripcion">${materia.descripcion}</span>
                                        </c:if>
                                    </div>
                                </td>
                                <td class="text-center">${materia.creditos}</td>
                                <td>${materia.departamento}</td>
                                <td class="text-center">
                                    <span class="nivel-badge">Nivel ${materia.nivel}</span>
                                </td>
                                <td>
                                    <span class="status ${materia.activa ? 'active' : 'inactive'}">
                                        ${materia.activa ? 'Activa' : 'Inactiva'}
                                    </span>
                                </td>
                                <td class="actions">
                                    <a href="/materias/editar/${materia.id}" class="btn-icon btn-edit" title="Editar">
                                        <i class="fas fa-edit"></i>
                                    </a>
                                    <a href="javascript:void(0)" onclick="confirmarEliminar('${materia.id}')" class="btn-icon btn-delete" title="Eliminar">
                                        <i class="fas fa-trash"></i>
                                    </a>
                                    <a href="javascript:void(0)" onclick="verDetalles('${materia.id}')" class="btn-icon btn-info" title="Ver detalles">
                                        <i class="fas fa-info-circle"></i>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </main>
</div>

<!-- Modal de Detalles -->
<div id="detallesModal" class="modal">
    <div class="modal-content">
        <span class="close">&times;</span>
        <h2>Detalles de la Materia</h2>
        <div id="detallesContent"></div>
    </div>
</div>

<style>
.content-wrapper {
    padding: 20px;
    background-color: #f8f9fa;
}

.header {
    margin-bottom: 20px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 20px;
    background-color: white;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.header-title h1 {
    font-size: 24px;
    color: #2c3e50;
    margin: 0;
    display: flex;
    align-items: center;
    gap: 10px;
}

.header-title p {
    margin: 5px 0 0;
    color: #6c757d;
    font-size: 14px;
}

.header-actions {
    display: flex;
    gap: 15px;
    align-items: center;
}

.search-box {
    position: relative;
}

.search-box input {
    padding: 8px 32px 8px 12px;
    border: 1px solid #ddd;
    border-radius: 4px;
    width: 200px;
}

.search-box i {
    position: absolute;
    right: 10px;
    top: 50%;
    transform: translateY(-50%);
    color: #6c757d;
}

.table-container {
    background: white;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    overflow: hidden;
}

.data-table {
    width: 100%;
    border-collapse: collapse;
}

.data-table th {
    background-color: #f8f9fa;
    font-weight: 600;
    color: #2c3e50;
    cursor: pointer;
    transition: background-color 0.3s;
}

.data-table th:hover {
    background-color: #e9ecef;
}

.data-table th,
.data-table td {
    padding: 12px 15px;
    text-align: left;
    border-bottom: 1px solid #eee;
}

.text-center {
    text-align: center;
}

.materia-info {
    display: flex;
    flex-direction: column;
}

.materia-nombre {
    font-weight: 500;
}

.materia-descripcion {
    font-size: 12px;
    color: #6c757d;
    margin-top: 4px;
}

.nivel-badge {
    background-color: #e9ecef;
    padding: 4px 8px;
    border-radius: 12px;
    font-size: 12px;
    color: #495057;
}

.status {
    padding: 4px 8px;
    border-radius: 4px;
    font-size: 12px;
    font-weight: 500;
}

.status.active {
    background-color: #d4edda;
    color: #155724;
}

.status.inactive {
    background-color: #f8d7da;
    color: #721c24;
}

.actions {
    display: flex;
    gap: 8px;
}

.btn-icon {
    padding: 6px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    color: white;
    width: 28px;
    height: 28px;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: transform 0.2s;
    text-decoration: none;
}

.btn-icon:hover {
    transform: scale(1.1);
}

.btn-edit {
    background-color: #007bff;
}

.btn-delete {
    background-color: #dc3545;
}

.btn-info {
    background-color: #17a2b8;
}

.btn-primary {
    background-color: #007bff;
    color: white;
    padding: 8px 16px;
    border-radius: 4px;
    text-decoration: none;
    display: inline-flex;
    align-items: center;
    gap: 8px;
    transition: background-color 0.3s;
}

.btn-primary:hover {
    background-color: #0056b3;
}

/* Modal Styles */
.modal {
    display: none;
    position: fixed;
    z-index: 1000;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0,0,0,0.5);
}

.modal-content {
    background-color: white;
    margin: 15% auto;
    padding: 20px;
    border-radius: 8px;
    width: 80%;
    max-width: 500px;
    position: relative;
}

.close {
    position: absolute;
    right: 20px;
    top: 10px;
    font-size: 28px;
    font-weight: bold;
    cursor: pointer;
    color: #aaa;
}

.close:hover {
    color: #333;
}

.detalles-grid {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: 15px;
    margin-top: 20px;
}

.detalle-item {
    padding: 10px;
    background-color: #f8f9fa;
    border-radius: 4px;
}
</style>

<script>
function confirmarEliminar(id) {
    if (confirm('¿Está seguro que desea eliminar esta materia?')) {
        window.location.href = '/materias/eliminar/' + id;
    }
}

function filterTable() {
    var input = document.getElementById("searchInput");
    var filter = input.value.toLowerCase();
    var table = document.getElementById("materiasTable");
    var tr = table.getElementsByTagName("tr");

    for (var i = 1; i < tr.length; i++) {
        var td = tr[i].getElementsByTagName("td");
        var found = false;
        
        for (var j = 0; j < td.length; j++) {
            if (td[j]) {
                var txtValue = td[j].textContent || td[j].innerText;
                if (txtValue.toLowerCase().indexOf(filter) > -1) {
                    found = true;
                    break;
                }
            }
        }
        
        tr[i].style.display = found ? "" : "none";
    }
}

function sortTable(n) {
    var table = document.getElementById("materiasTable");
    var switching = true;
    var dir = "asc";
    var switchcount = 0;
    
    while (switching) {
        switching = false;
        var rows = table.rows;
        
        for (var i = 1; i < (rows.length - 1); i++) {
            var shouldSwitch = false;
            var x = rows[i].getElementsByTagName("TD")[n];
            var y = rows[i + 1].getElementsByTagName("TD")[n];
            
            if (dir === "asc") {
                if (x.textContent.toLowerCase() > y.textContent.toLowerCase()) {
                    shouldSwitch = true;
                    break;
                }
            } else if (dir === "desc") {
                if (x.textContent.toLowerCase() < y.textContent.toLowerCase()) {
                    shouldSwitch = true;
                    break;
                }
            }
        }
        
        if (shouldSwitch) {
            rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
            switching = true;
            switchcount++;
        } else {
            if (switchcount === 0 && dir === "asc") {
                dir = "desc";
                switching = true;
            }
        }
    }
    
    // Actualizar iconos de ordenamiento
    var headers = table.getElementsByTagName("TH");
    for (var i = 0; i < headers.length; i++) {
        var icon = headers[i].getElementsByTagName("I")[0];
        if (i === n) {
            icon.className = dir === "asc" ? "fas fa-sort-up" : "fas fa-sort-down";
        } else {
            icon.className = "fas fa-sort";
        }
    }
}

function verDetalles(id) {
    var modal = document.getElementById("detallesModal");
    var content = document.getElementById("detallesContent");
    
    // Hacer una petición AJAX para obtener los detalles de la materia
    fetch('/materias/detalles/' + id)
        .then(response => response.json())
        .then(materia => {
            content.innerHTML = `
                <div class="detalles-grid">
                    <div class="detalle-item">
                        <strong>Código:</strong> ${materia.codigo}
                    </div>
                    <div class="detalle-item">
                        <strong>Nombre:</strong> ${materia.nombre}
                    </div>
                    <div class="detalle-item">
                        <strong>Créditos:</strong> ${materia.creditos}
                    </div>
                    <div class="detalle-item">
                        <strong>Departamento:</strong> ${materia.departamento}
                    </div>
                    <div class="detalle-item">
                        <strong>Nivel:</strong> ${materia.nivel}
                    </div>
                    <div class="detalle-item">
                        <strong>Estado:</strong> ${materia.activa ? 'Activa' : 'Inactiva'}
                    </div>
                    <div class="detalle-item">
                        <strong>Prerequisitos:</strong> ${materia.prerequisitos || 'Ninguno'}
                    </div>
                    <div class="detalle-item">
                        <strong>Corequisitos:</strong> ${materia.corequisitos || 'Ninguno'}
                    </div>
                </div>
            `;
        })
        .catch(error => {
            content.innerHTML = '<p class="error">Error al cargar los detalles de la materia</p>';
        });
    
    modal.style.display = "block";
}

// Cerrar modal
var modal = document.getElementById("detallesModal");
var span = document.getElementsByClassName("close")[0];

span.onclick = function() {
    modal.style.display = "none";
}

window.onclick = function(event) {
    if (event.target == modal) {
        modal.style.display = "none";
    }
}
</script>
</body>
</html>