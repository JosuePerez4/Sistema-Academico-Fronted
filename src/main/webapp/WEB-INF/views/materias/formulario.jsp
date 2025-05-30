<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>${materia.id == null ? 'Nueva Materia' : 'Editar Materia'} - Sistema Académico</title>
    <link rel="stylesheet" href="/css/profesor.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
<div class="container">
    <%@ include file="../common/sidebar.jsp" %>
    <main class="main-content">
        <header class="header">
            <div>
                <h2>${materia.id == null ? 'Nueva Materia' : 'Editar Materia'}</h2>
            </div>
            <div class="header-actions">
                <a href="/materias" class="btn-secondary">
                    <i class="fas fa-arrow-left"></i> Volver
                </a>
            </div>
        </header>

        <div class="content-wrapper">
            <div class="form-container">
                <form:form action="${materia.id == null ? '/materias' : '/materias/editar/'.concat(materia.id)}" 
                         method="POST" modelAttribute="materia">
                    <div class="form-group">
                        <form:label path="codigo">Código</form:label>
                        <form:input path="codigo" required="true" class="form-control"/>
                        <form:errors path="codigo" class="error-message"/>
                    </div>

                    <div class="form-group">
                        <form:label path="nombre">Nombre</form:label>
                        <form:input path="nombre" required="true" class="form-control"/>
                        <form:errors path="nombre" class="error-message"/>
                    </div>

                    <div class="form-group">
                        <form:label path="descripcion">Descripción</form:label>
                        <form:textarea path="descripcion" class="form-control"/>
                        <form:errors path="descripcion" class="error-message"/>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <form:label path="creditos">Créditos</form:label>
                            <form:input path="creditos" type="number" required="true" class="form-control"/>
                            <form:errors path="creditos" class="error-message"/>
                        </div>

                        <div class="form-group">
                            <form:label path="nivel">Nivel</form:label>
                            <form:input path="nivel" type="number" required="true" class="form-control"/>
                            <form:errors path="nivel" class="error-message"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <form:label path="departamento">Departamento</form:label>
                        <form:input path="departamento" required="true" class="form-control"/>
                        <form:errors path="departamento" class="error-message"/>
                    </div>

                    <div class="form-group">
                        <form:label path="prerequisitos">Prerequisitos</form:label>
                        <form:input path="prerequisitos" class="form-control"/>
                        <form:errors path="prerequisitos" class="error-message"/>
                    </div>

                    <div class="form-group">
                        <form:label path="corequisitos">Correquisitos</form:label>
                        <form:input path="corequisitos" class="form-control"/>
                        <form:errors path="corequisitos" class="error-message"/>
                    </div>

                    <div class="form-group">
                        <div class="checkbox-wrapper">
                            <form:checkbox path="activa" id="activa"/>
                            <form:label path="activa">Materia Activa</form:label>
                        </div>
                        <form:errors path="activa" class="error-message"/>
                    </div>

                    <div class="form-actions">
                        <button type="submit" class="btn-primary">
                            <i class="fas fa-save"></i> Guardar
                        </button>
                        <a href="/materias" class="btn-secondary">Cancelar</a>
                    </div>
                </form:form>
            </div>
        </div>
    </main>
</div>

<style>
.content-wrapper {
    padding: 20px;
}

.form-container {
    background: white;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    padding: 20px;
    max-width: 800px;
    margin: 0 auto;
}

.form-group {
    margin-bottom: 20px;
}

.form-row {
    display: flex;
    gap: 20px;
}

.form-row .form-group {
    flex: 1;
}

.form-control {
    width: 100%;
    padding: 8px 12px;
    border: 1px solid #ddd;
    border-radius: 4px;
    font-size: 14px;
}

textarea.form-control {
    min-height: 100px;
    resize: vertical;
}

.checkbox-wrapper {
    display: flex;
    align-items: center;
    gap: 8px;
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

.btn-primary,
.btn-secondary {
    padding: 8px 16px;
    border-radius: 4px;
    border: none;
    cursor: pointer;
    display: inline-flex;
    align-items: center;
    gap: 8px;
    text-decoration: none;
}

.btn-primary {
    background-color: #007bff;
    color: white;
}

.btn-secondary {
    background-color: #6c757d;
    color: white;
}
</style>
</body>
</html> 