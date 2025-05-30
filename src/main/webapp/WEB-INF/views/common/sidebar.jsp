<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<aside class="sidebar">
    <div class="sidebar-header">
        <img src="/images/logo.png" alt="Logo" class="logo">
        <h3>Sistema Académico</h3>
    </div>
    
    <nav class="sidebar-nav">
        <ul>
            <li>
                <a href="/admin/dashboard" class="${pageContext.request.servletPath == '/WEB-INF/views/dashboardadmin.jsp' ? 'active' : ''}">
                    <i class="fas fa-home"></i>
                    <span>Dashboard</span>
                </a>
            </li>
            <li>
                <a href="/materias" class="${pageContext.request.servletPath == '/WEB-INF/views/materias/lista.jsp' ? 'active' : ''}">
                    <i class="fas fa-book"></i>
                    <span>Materias</span>
                </a>
            </li>
            <li>
                <a href="/cursos" class="${pageContext.request.servletPath == '/WEB-INF/views/cursos/lista.jsp' ? 'active' : ''}">
                    <i class="fas fa-chalkboard-teacher"></i>
                    <span>Cursos</span>
                </a>
            </li>
            <li>
                <a href="/profesores" class="${pageContext.request.servletPath == '/WEB-INF/views/profesores/lista.jsp' ? 'active' : ''}">
                    <i class="fas fa-user-tie"></i>
                    <span>Profesores</span>
                </a>
            </li>
            <li>
                <a href="/estudiantes" class="${pageContext.request.servletPath == '/WEB-INF/views/estudiantes/lista.jsp' ? 'active' : ''}">
                    <i class="fas fa-user-graduate"></i>
                    <span>Estudiantes</span>
                </a>
            </li>
            <li>
                <a href="/horarios" class="${pageContext.request.servletPath == '/WEB-INF/views/horarios/lista.jsp' ? 'active' : ''}">
                    <i class="fas fa-calendar-alt"></i>
                    <span>Horarios</span>
                </a>
            </li>
        </ul>
    </nav>

    <div class="sidebar-footer">
        <a href="/logout" class="logout-btn">
            <i class="fas fa-sign-out-alt"></i>
            <span>Cerrar Sesión</span>
        </a>
    </div>
</aside>

<style>
.sidebar {
    width: 250px;
    height: 100vh;
    background: #2c3e50;
    color: white;
    display: flex;
    flex-direction: column;
    position: fixed;
    left: 0;
    top: 0;
}

.sidebar-header {
    padding: 20px;
    text-align: center;
    border-bottom: 1px solid #34495e;
}

.logo {
    width: 60px;
    height: 60px;
    margin-bottom: 10px;
}

.sidebar-nav {
    flex: 1;
    padding: 20px 0;
}

.sidebar-nav ul {
    list-style: none;
    padding: 0;
    margin: 0;
}

.sidebar-nav li {
    margin-bottom: 5px;
}

.sidebar-nav a {
    display: flex;
    align-items: center;
    padding: 12px 20px;
    color: #ecf0f1;
    text-decoration: none;
    transition: all 0.3s ease;
}

.sidebar-nav a:hover,
.sidebar-nav a.active {
    background: #34495e;
    color: #3498db;
}

.sidebar-nav i {
    width: 20px;
    margin-right: 10px;
}

.sidebar-footer {
    padding: 20px;
    border-top: 1px solid #34495e;
}

.logout-btn {
    display: flex;
    align-items: center;
    color: #e74c3c;
    text-decoration: none;
    padding: 10px;
    border-radius: 5px;
    transition: all 0.3s ease;
}

.logout-btn:hover {
    background: #34495e;
}

.logout-btn i {
    margin-right: 10px;
}
</style> 