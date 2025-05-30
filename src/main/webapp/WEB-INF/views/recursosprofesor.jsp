<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="es">

        <head>
            <meta charset="UTF-8">
            <title>Recursos Académicos - Sistema Académico</title>
            <link rel="stylesheet" href="/css/profesor.css">
            <link rel="preconnect" href="https://fonts.googleapis.com">
            <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
            <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
            <script>
                let recursosDisponibles = [];
            </script>
            <script>
                // usuarioId viene del backend
                const usuarioId = <c:out value='${usuarioId}' />;
                document.addEventListener('DOMContentLoaded', function () {
                    // Cargar recursos disponibles
                    fetch('/api/recursos')
                        .then(res => res.json())
                        .then(data => {
                            recursosDisponibles = data;
                            const select = document.getElementById('recurso-select');
                            select.innerHTML = '';
                            data.forEach(r => {
                                const opt = document.createElement('option');
                                opt.value = r.id;
                                opt.textContent = r.nombre;
                                select.appendChild(opt);
                            });
                        });

                    // Registrar movimiento
                    document.getElementById('movimiento-form').addEventListener('submit', function (e) {
                        e.preventDefault();
                        const recursoId = document.getElementById('recurso-select').value;
                        const tipoMovimiento = document.getElementById('accion-select').value;
                        const fechaMovimiento = document.getElementById('fecha-input').value;
                        const observacion = document.getElementById('observacion-input').value;
                        if (!recursoId || !tipoMovimiento || !fechaMovimiento) {
                            alert('Por favor complete todos los campos.');
                            return;
                        }
                        fetch('/api/recursos/movimientos', {
                            method: 'POST',
                            headers: { 'Content-Type': 'application/json' },
                            body: JSON.stringify({
                                recursoId: parseInt(recursoId),
                                usuarioId: usuarioId,
                                tipoMovimiento: tipoMovimiento,
                                observacion: observacion,
                                fechaMovimiento: fechaMovimiento
                            })
                        })
                            .then(res => {
                                if (res.ok) {
                                    alert('Movimiento registrado correctamente');
                                    document.getElementById('movimiento-form').reset();
                                } else {
                                    alert('Error al registrar el movimiento');
                                }
                            });
                    });
                });
            </script>
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
                            <li><a href="/profesor/dashboard"
                                    class="${currentPage == 'dashboard' ? 'active' : ''}">Inicio</a></li>
                            <li><a href="/profesor/clases" class="${currentPage == 'clases' ? 'active' : ''}">Mis
                                    Clases</a></li>
                            <li><a href="/profesor/calificaciones"
                                    class="${currentPage == 'calificaciones' ? 'active' : ''}">Calificaciones</a></li>
                            <li><a href="/mensajes" class="${currentPage == 'mensajes' ? 'active' : ''}">Mensajes <span
                                        class="badge">3</span></a></li>
                            <li><a href="/profesor/horario"
                                    class="${currentPage == 'horario' ? 'active' : ''}">Horario</a></li>
                            <li><a href="/profesor/asistencias"
                                    class="${currentPage == 'asistencias' ? 'active' : ''}">Asistencias</a></li>
                            <li><a href="/profesor/evaluaciones"
                                    class="${currentPage == 'evaluaciones' ? 'active' : ''}">Evaluaciones</a></li>
                            <li><a href="/profesor/ajustes"
                                    class="${currentPage == 'ajustes' ? 'active' : ''}">Ajustes</a></li>
                            <li><a href="/profesor/recursos"
                                    class="${currentPage == 'recursos' ? 'active' : ''}">Recursos Académicos</a></li>
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
                    <div
                        style="background:white;border-radius:30px;padding:40px 50px;max-width:1100px;margin:0 auto;box-shadow:0 4px 24px rgba(0,0,0,0.07);">
                        <h2 style="color:#54a7b9;margin-bottom:30px;">Administrar el préstamo, devolución y
                            mantenimiento de recursos educativos, como libros y equipos.</h2>
                        <form id="movimiento-form" style="display:flex;flex-direction:column;gap:20px;max-width:500px;">
                            <label style="font-size:18px;font-weight:600;">Recurso disponible
                                <select id="recurso-select"
                                    style="margin-top:8px;padding:8px 12px;border-radius:8px;border:1px solid #e7e9ed;width:100%;">
                                    <option value="">Cargando...</option>
                                </select>
                            </label>
                            <label style="font-size:18px;font-weight:600;">Acción
                                <select id="accion-select"
                                    style="margin-top:8px;padding:8px 12px;border-radius:8px;border:1px solid #e7e9ed;width:100%;">
                                    <option value="">Seleccione</option>
                                    <option value="PRESTAMO">Préstamo</option>
                                    <option value="DEVOLUCION">Devolución</option>
                                    <option value="MANTENIMIENTO">Mantenimiento</option>
                                </select>
                            </label>
                            <label style="font-size:18px;font-weight:600;">Fecha
                                <input id="fecha-input" type="date"
                                    style="margin-top:8px;padding:8px 12px;border-radius:8px;border:1px solid #e7e9ed;width:100%;" />
                            </label>
                            <label style="font-size:18px;font-weight:600;">Observación (opcional)
                                <input id="observacion-input" type="text"
                                    style="margin-top:8px;padding:8px 12px;border-radius:8px;border:1px solid #e7e9ed;width:100%;"
                                    placeholder="Observaciones sobre el movimiento" />
                            </label>
                            <button type="submit"
                                style="margin-top:20px;padding:12px 0;background:#54a7b9;color:white;font-size:18px;font-weight:700;border:none;border-radius:8px;">Registrar</button>
                        </form>
                    </div>
                </main>
            </div>
        </body>

        </html>