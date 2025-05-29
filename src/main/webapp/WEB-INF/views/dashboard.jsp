<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Dashboard - Sistema Académico</title>
    <link rel="stylesheet" href="<c:url value='/css/styles.css' />">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
</head>
<body>
<div class="container">
    <!-- Sidebar -->
    <aside class="sidebar">
        <div class="logo">
            <div class="logo-text">UF<br>PS</div>
            <div class="version">Divisist 3.0</div>
        </div>
        <nav>
            <ul>
                <li class="active"><span>Inicio</span></li>
                <li><span>Inclusiones</span></li>
                <li><span>Materias</span></li>
                <li><span>Mensajes <span class="badge">2</span></span></li>
                <li><span>Horario</span></li>
                <li><span>Evaluaciones</span></li>
                <li><span>Cursos disponibles</span></li>
                <li><span>Ajustes</span></li>
            </ul>
        </nav>
        <div class="sidebar-footer">
            <a href="#">Ayuda</a>
            <a href="#">Contáctenos</a>
            <a href="/login">Cerrar sesión</a>
        </div>
    </aside>

    <!-- Main Content -->
    <main class="main-content">
        <!-- Header -->
        <header class="header">
            <div>
                <h2>Bienvenido de vuelta, <span class="highlight">Estudiante #12</span></h2>
                <div class="date">Mayo 15, 2025.</div>
            </div>
            <div class="header-actions">
                <input type="text" placeholder="Búsqueda" class="search">
                <div class="notification">
                    <span class="notif-badge">4</span>
                    <img src="https://img.icons8.com/ios-filled/24/000000/bell.png" alt="Notificaciones"/>
                </div>
                <div class="profile">
                    <img src="https://randomuser.me/api/portraits/men/12.jpg" alt="Perfil"/>
                    <span>Estudiante #12</span>
                </div>
            </div>
        </header>

        <!-- Dashboard Cards -->
        <section class="dashboard-cards">
            <div class="card tasks">
                <div class="card-title">Tareas cercanas</div>
                <div class="card-subtitle">1 Pendiente</div>
                <div class="task-detail">
                    Seminario Investigador 1<br>
                    <span class="task-date">Tarea #15 - 17/5/25 8:00 AM</span>
                </div>
            </div>
            <div class="card student">
                <div class="card-title">Estudiante #12</div>
                <div class="card-subtitle">Días para previos</div>
                <div class="card-value">32 días</div>
            </div>
            <div class="card history">
                <div class="card-title">Historial</div>
                <div class="card-subtitle">Créditos aprobados</div>
                <div class="card-value">85</div>
            </div>
        </section>

        <!-- Calendar and Progress -->
        <section class="calendar-progress">
            <div class="calendar-container">
                <div class="calendar-header">
                    <span>Calendario</span>
                    <span>Mayo</span>
                </div>
                <table class="calendar">
                    <thead>
                    <tr>
                        <th>Lunes</th><th>Martes</th><th>Miércoles</th><th>Jueves</th><th>Viernes</th><th>Sábado</th><th>Domingo</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr><td>28</td><td>29</td><td>30</td><td>1 <span class="holiday">Día del Trabajo</span></td><td>2</td><td>3</td><td class="sunday">4</td></tr>
                    <tr><td>5</td><td>6</td><td>7</td><td>8</td><td>9</td><td>10</td><td class="sunday">11</td></tr>
                    <tr><td>12 <span class="moon"></span></td><td>13</td><td>14</td><td>15 <span class="holiday">Día del Maestro</span></td><td>16</td><td>17</td><td class="sunday">18</td></tr>
                    <tr><td>19</td><td>20</td><td>21 <span class="moon"></span></td><td>22</td><td>23</td><td>24</td><td class="sunday">25</td></tr>
                    <tr><td>26</td><td>27 <span class="moon"></span></td><td>28</td><td>29</td><td>30</td><td>31</td><td class="sunday">1</td></tr>
                    </tbody>
                </table>
            </div>
            <div class="progress-container">
                <div class="progress-title">Trabajos entregados</div>
                <div class="progress-circle">
                    <svg width="100" height="100">
                        <circle cx="50" cy="50" r="40" stroke="#e5e7eb" stroke-width="10" fill="none"/>
                        <circle cx="50" cy="50" r="40" stroke="#222" stroke-width="10" fill="none"
                                stroke-dasharray="251.2" stroke-dashoffset="95" stroke-linecap="round"/>
                        <text x="50%" y="54%" text-anchor="middle" fill="#222" font-size="22" font-family="Inter" dy=".3em">62%</text>
                    </svg>
                </div>
                <div class="progress-legend">
                    <span class="legend quizzes"></span> Quizzes
                    <span class="legend trabajos"></span> Trabajos
                    <span class="legend ejercicios"></span> Ejercicios
                </div>
            </div>
        </section>
    </main>
</div>
</body>
</html>