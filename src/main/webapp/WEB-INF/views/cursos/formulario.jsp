<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>${curso.id == null ? 'Nuevo Curso' : 'Editar Curso'} - Sistema Académico</title>
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
                <h2>${curso.id == null ? 'Nuevo Curso' : 'Editar Curso'}</h2>
                <div class="date">${fechaActual}</div>
            </div>
            <div class="header-actions">
                <a href="/cursos" class="btn-secondary">
                    <i class="fas fa-arrow-left"></i> Volver a la lista
                </a>
            </div>
        </header>

        <div class="form-container">
            <form:form action="${curso.id == null ? '/cursos' : '/cursos/editar/'.concat(curso.id)}" 
                      method="post" modelAttribute="curso" class="curso-form">
                
                <div class="form-group">
                    <form:label path="nombre">Nombre del Curso</form:label>
                    <form:input path="nombre" required="true" class="form-control"/>
                    <form:errors path="nombre" class="error-message"/>
                </div>

                <div class="form-group">
                    <form:label path="codigo">Código del Curso</form:label>
                    <form:input path="codigo" required="true" class="form-control"/>
                    <form:errors path="codigo" class="error-message"/>
                </div>

                <div class="form-group">
                    <form:label path="descripcion">Descripción</form:label>
                    <form:textarea path="descripcion" rows="4" class="form-control"/>
                    <form:errors path="descripcion" class="error-message"/>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <form:label path="objetivos">Objetivos</form:label>
                        <form:textarea path="objetivos" rows="4" class="form-control"/>
                        <form:errors path="objetivos" class="error-message"/>
                    </div>

                    <div class="form-group">
                        <form:label path="competencias">Competencias</form:label>
                        <form:textarea path="competencias" rows="4" class="form-control"/>
                        <form:errors path="competencias" class="error-message"/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <form:label path="cuposDisponibles">Cupos Disponibles</form:label>
                        <form:input path="cuposDisponibles" type="number" min="1" required="true" class="form-control"/>
                        <form:errors path="cuposDisponibles" class="error-message"/>
                    </div>

                    <div class="form-group">
                        <form:label path="horario">Horario</form:label>
                        <form:input path="horario" required="true" class="form-control"/>
                        <form:errors path="horario" class="error-message"/>
                    </div>
                </div>

                <div class="form-group">
                    <form:label path="profesor">Profesor</form:label>
                    <form:input path="profesor" required="true" class="form-control"/>
                    <form:errors path="profesor" class="error-message"/>
                </div>

                <div class="form-group">
                    <form:label path="periodoAcademico">Período Académico</form:label>
                    <form:select path="periodoAcademico" class="form-control">
                        <form:option value="2024-1">2024-1</form:option>
                        <form:option value="2023-2">2023-2</form:option>
                    </form:select>
                    <form:errors path="periodoAcademico" class="error-message"/>
                </div>

                <div class="form-actions">
                    <button type="submit" class="btn-primary">
                        <i class="fas fa-save"></i> Guardar Curso
                    </button>
                    <a href="/cursos" class="btn-secondary">
                        <i class="fas fa-times"></i> Cancelar
                    </a>
                </div>
            </form:form>
        </div>
    </main>
</div>

<style>
.form-container {
    background: white;
    border-radius: 12px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
    padding: 30px;
    margin: 20px;
}

.curso-form {
    max-width: 800px;
    margin: 0 auto;
}

.form-group {
    margin-bottom: 20px;
}

.form-row {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 20px;
    margin-bottom: 20px;
}

.form-control {
    width: 100%;
    padding: 10px;
    border: 1px solid var(--light-gray);
    border-radius: 8px;
    font-size: 14px;
    transition: border-color 0.3s;
}

.form-control:focus {
    border-color: var(--secondary-color);
    outline: none;
}

textarea.form-control {
    resize: vertical;
}

label {
    display: block;
    margin-bottom: 8px;
    font-weight: 600;
    color: var(--text-color);
}

.error-message {
    color: #dc3545;
    font-size: 12px;
    margin-top: 4px;
}

.form-actions {
    display: flex;
    gap: 10px;
    margin-top: 30px;
}

.btn-secondary {
    background: var(--light-gray);
    color: var(--text-color);
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

.btn-secondary:hover {
    background: #d1d5db;
}
</style>
</body>
</html> 