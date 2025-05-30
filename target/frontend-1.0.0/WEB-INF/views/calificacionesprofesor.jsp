<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Calificaciones - Sistema Académico</title>
    <link rel="stylesheet" href="/css/profesor.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
    <style>
        .tabs { display: flex; gap: 20px; margin-top: 30px; }
        .tab-btn { padding: 10px 30px; border: none; border-radius: 8px 8px 0 0; background: #e7e9ed; color: #21465b; font-weight: 600; cursor: pointer; }
        .tab-btn.active { background: #54a7b9; color: #fff; }
        .tab-content { background: #fff; border-radius: 0 0 12px 12px; box-shadow: 0 4px 24px rgba(0,0,0,0.07); padding: 30px; min-height: 120px; }
    </style>
    <script>
        function showTab(tab) {
            document.getElementById('feedback-estudiante').style.display = tab === 'estudiante' ? 'block' : 'none';
            document.getElementById('feedback-profesor').style.display = tab === 'profesor' ? 'block' : 'none';
            document.getElementById('btn-estudiante').classList.toggle('active', tab === 'estudiante');
            document.getElementById('btn-profesor').classList.toggle('active', tab === 'profesor');
        }
    </script>
</head>
<body onload="showTab('estudiante')">
<div class="container">
    <aside class="sidebar">
        <div class="logo">
            <img src="/image/logoufps.png" alt="Logo UFPS" class="logo-img" />
            <div class="version">Divisist 3.0</div>
        </div>
        <nav>
            <ul>
                <li><a href="/profesor/dashboard">Inicio</a></li>
                <li><a href="/profesor/clases">Mis Clases</a></li>
                <li class="active"><a href="/profesor/calificaciones">Calificaciones</a></li>
                <li><span>Mensajes <span class="badge">3</span></span></li>
                <li><span>Horario</span></li>
                <li><span>Asistencias</span></li>
                <li><a href="/profesor/evaluaciones">Evaluaciones</a></li>
                <li><a href="/profesor/ajustes">Ajustes</a></li>
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
            <h2 style="color:#54a7b9;margin-bottom:30px;">Ver comentarios de Evaluaciones</h2>
            <label style="font-size:18px;font-weight:600;">Seleccionar evaluación
                <select style="margin-top:8px;padding:8px 12px;border-radius:8px;border:1px solid #e7e9ed;width:100%;max-width:400px;">
                    <option>Parcial 1</option>
                    <option>Quiz 1</option>
                    <option>Trabajo Final</option>
                </select>
            </label>
            <div class="tabs">
                <button id="btn-estudiante" class="tab-btn" onclick="showTab('estudiante')">Feedback Estudiante</button>
                <button id="btn-profesor" class="tab-btn" onclick="showTab('profesor')">Feedback Profesor</button>
            </div>
            <div id="feedback-estudiante" class="tab-content">
                <strong>Feedback del estudiante:</strong>
                <p>Aquí aparecerán los comentarios y solicitudes del estudiante sobre la evaluación seleccionada.</p>
            </div>
            <div id="feedback-profesor" class="tab-content" style="display:none;">
                <strong>Feedback del profesor:</strong>
                <p>Aquí aparecerán tus respuestas, aclaraciones o comentarios sobre la evaluación seleccionada.</p>
            </div>
        </div>
    </main>
</div>
</body>
</html> 