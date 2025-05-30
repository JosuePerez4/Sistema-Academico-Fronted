<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Ajustes de cuenta - Sistema Académico</title>
    <link rel="stylesheet" href="/css/profesor.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
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
                <li><a href="/profesor/dashboard">Inicio</a></li>
                <li><span>Mis Clases</span></li>
                <li><span>Calificaciones</span></li>
                <li><span>Mensajes <span class="badge">3</span></span></li>
                <li><span>Horario</span></li>
                <li><span>Asistencias</span></li>
                <li><span>Reportes</span></li>
                <li class="active"><a href="/profesor/ajustes">Ajustes</a></li>
            </ul>
        </nav>
        <div class="sidebar-footer">
            <a href="/ayuda">Ayuda</a>
            <a href="/profesor/contacto">Contáctenos</a>
            <a href="/logout">Cerrar sesión</a>
        </div>
    </aside>
    <main class="main-content">
        <header class="header">
            <div>
                <h2>Bienvenido de vuelta, <span class="highlight">${nombre}</span></h2>
                <div class="date">${fechaActual}</div>
            </div>
            <div class="header-actions">
                <input type="text" placeholder="Búsqueda" class="search">
                <div class="notification">
                    <span class="notif-badge">3</span>
                    <i class="fas fa-bell"></i>
                </div>
                <div class="profile">
                    <img src="/image/Perfil.png" alt="Perfil" />
                    <span>${nombre}</span>
                </div>
            </div>
        </header>
        <div style="background:white;border-radius:30px;padding:40px 50px;max-width:1100px;margin:0 auto;box-shadow:0 4px 24px rgba(0,0,0,0.07);">
            <h2 style="color:#54a7b9;margin-bottom:30px;">Ajustes de cuenta</h2>
            <h3 style="color:#54a7b9;margin-bottom:18px;">Actualizar información profesional:</h3>
            <c:if test="${sinDatosDocente}">
                <div style="background:white;border-radius:30px;padding:40px 50px;max-width:700px;margin:0 auto;box-shadow:0 4px 24px rgba(0,0,0,0.07);text-align:center;">
                    <h2 style="color:#e57373;">Aún no tienes datos profesionales registrados</h2>
                    <p>Por favor, contacta al administrador para completar tu registro como docente.</p>
                </div>
            </c:if>
            <c:if test="${not sinDatosDocente}">
                <c:choose>
                    <c:when test="${not empty docente}">
                        <form id="editForm" action="/profesor/ajustes/editar" method="post" style="display:none;">
                            <label>Especialidad: <input type="text" name="especialidad" value="${docente.especialidad}" required></label><br>
                            <label>Carga Horaria: <input type="number" name="cargaHoraria" value="${docente.cargaHoraria}" required></label><br>
                            <label>Título Profesional: <input type="text" name="tituloProfesional" value="${docente.tituloProfesional}" required></label><br>
                            <label>Años de Experiencia: <input type="text" name="aniosExperiencia" value="${docente.aniosExperiencia}" required></label><br>
                            <label>Tipo de Contrato: <input type="text" name="tipoContrato" value="${docente.tipoContrato}" required></label><br>
                            <button type="submit">Guardar</button>
                            <button type="button" onclick="toggleEdit(false)">Cancelar</button>
                        </form>
                        <div id="viewData">
                            <p style="font-size:22px;font-weight:700;margin-bottom:10px;">Especialidad: <span style="font-weight:400;">${docente.especialidad}</span></p>
                            <p style="font-size:22px;font-weight:700;margin-bottom:10px;">Carga Horaria: <span style="font-weight:400;">${docente.cargaHoraria} Horas</span></p>
                            <p style="font-size:22px;font-weight:700;margin-bottom:10px;">Título Profesional: <span style="font-weight:400;">${docente.tituloProfesional}</span></p>
                            <p style="font-size:22px;font-weight:700;margin-bottom:10px;">Años de Experiencia: <span style="font-weight:400;">${docente.aniosExperiencia}</span></p>
                            <p style="font-size:22px;font-weight:700;margin-bottom:30px;">Tipo de Contrato: <span style="font-weight:400;">${docente.tipoContrato}</span></p>
                            <button type="button" onclick="toggleEdit(true)" style="float:right;">Editar</button>
                        </div>
                        <script>
                            function toggleEdit(edit) {
                                document.getElementById('editForm').style.display = edit ? 'block' : 'none';
                                document.getElementById('viewData').style.display = edit ? 'none' : 'block';
                            }
                        </script>
                    </c:when>
                    <c:otherwise>
                        <p>No se encontraron datos del docente.</p>
                    </c:otherwise>
                </c:choose>
            </c:if>
            <h3 style="color:#54a7b9;margin-bottom:18px;">Preferencias</h3>
            <p style="font-size:22px;font-weight:700;margin-bottom:10px;">Idioma</p>
            <p style="font-size:22px;font-weight:700;margin-bottom:10px;">Tema</p>
            <p style="font-size:22px;font-weight:700;margin-bottom:10px;">Información legal</p>
        </div>
    </main>
</div>
</body>
</html> 