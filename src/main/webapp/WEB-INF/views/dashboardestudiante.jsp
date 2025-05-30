<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Dashboard Estudiante - Sistema Académico</title>
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
                <li class="active"><a href="/estudiantes/dashboard" style="text-decoration: none; color: inherit;"><span>Inicio</span></a></li>
                <li><a href="/estudiantes/matricula" style="text-decoration: none; color: inherit;"><span>Matrícula</span></a></li>
                <li><span>Inclusiones</span></li>
                <li><a href="/estudiantes/materias" style="text-decoration: none; color: inherit;"><span>Materias</span></a></li>
                <li><a href="/estudiantes/asistencias" style="text-decoration: none; color: inherit;"><span>Asistencias</span></a></li>
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
                <h2>Bienvenido de vuelta, <span class="highlight">${nombre}</span></h2>
                <div class="date">${fechaActual}</div>
            </div>
            <div class="header-actions">
                <input type="text" placeholder="Búsqueda" class="search">
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
        <div class="dashboard-summary">
            <section class="next-class-section" style="flex:2;">
                <h3>Tareas cercanas</h3>
                <div class="next-class-info">
                    <span><strong>Seminario Investigador 1</strong></span>
                    <span class="class-code">Tarea #15 - 17/5/25 8:00 AM</span>
                </div>
            </section>
            <section class="teacher-rating-section">
                <h3>${nombre}</h3>
                <div class="teacher-rating-info">
                    <span class="rating-value">32 días</span>
                    <span style="font-size:14px;color:var(--dark-gray);">Días para previos</span>
                </div>
            </section>
            <section class="workload-section">
                <h3>Historial</h3>
                <div class="workload-info">
                    <span class="workload-hours">85</span>
                    <span style="font-size:14px;color:var(--dark-gray);">Créditos aprobados</span>
                </div>
            </section>
        </div>
        <div style="display:flex;gap:30px;">
            <div class="calendar-container" style="flex:2;">
                <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:10px;">
                    <div>
                        <button class="search" style="padding:4px 12px;font-size:14px;">Calendario</button>
                        <button class="search" style="padding:4px 12px;font-size:14px;">Mayo</button>
                    </div>
                </div>
                <table class="calendar">
                    <thead>
                        <tr>
                            <th>Lunes</th>
                            <th>Martes</th>
                            <th>Miércoles</th>
                            <th>Jueves</th>
                            <th>Viernes</th>
                            <th>Sábado</th>
                            <th>Domingo</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr><td>28</td><td>29</td><td>30</td><td>1</td><td>2</td><td>3</td><td>4</td></tr>
                        <tr><td>5</td><td>6</td><td>7</td><td>8</td><td>9</td><td>10</td><td>11</td></tr>
                        <tr><td>12</td><td>13</td><td>14</td><td>15</td><td>16</td><td>17</td><td>18</td></tr>
                        <tr><td>19</td><td>20</td><td>21</td><td>22</td><td>23</td><td>24</td><td>25</td></tr>
                        <tr><td>26</td><td>27</td><td>28</td><td>29</td><td>30</td><td>31</td><td>1</td></tr>
                    </tbody>
                </table>
            </div>
            <div class="calendar-container" style="flex:1;display:flex;flex-direction:column;align-items:center;justify-content:center;">
                <h3 style="margin-bottom:20px;">Trabajos entregados</h3>
                <svg width="120" height="120">
                    <circle cx="60" cy="60" r="50" stroke="#e7e9ed" stroke-width="12" fill="none" />
                    <circle cx="60" cy="60" r="50" stroke="#21465b" stroke-width="12" fill="none" stroke-dasharray="314" stroke-dashoffset="119" stroke-linecap="round"/>
                    <text x="60" y="68" text-anchor="middle" font-size="28" fill="#21465b">62%</text>
                </svg>
                <div style="margin-top:20px;">
                    <span style="display:inline-block;width:12px;height:12px;background:#343a40;margin-right:6px;"></span> Quizzes<br>
                    <span style="display:inline-block;width:12px;height:12px;background:#54a7b9;margin-right:6px;"></span> Trabajos<br>
                    <span style="display:inline-block;width:12px;height:12px;background:#e7e9ed;margin-right:6px;"></span> Ejercicios
                </div>
            </div>
        </div>
    </main>
</div>
</body>
</html> 