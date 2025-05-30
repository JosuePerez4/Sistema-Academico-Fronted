<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Gestión de Estudiantes</title>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@800&family=Source+Sans+3:wght@400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<c:url value='/css/registroEstudiante.css' />">
</head>
<body>
    <div class="container">
        <div class="left-section">
            <h1 class="registro-title">GESTIÓN DE ESTUDIANTES</h1>
            <h2 class="estudia-title">Estudia con nosotros</h2>
            <p class="description">Gestiona la información de los estudiantes de manera fácil y eficiente.<br>
                Si tienes dudas o un inconveniente, no dudes en contactarnos.</p>
            
            <div class="contact-info">
                <div class="contact-item">
                    <img src="<c:url value='/image/email.png' />" alt="Email">
                    <span>contact@university.edu.co</span>
                </div>
                <div class="contact-item">
                    <img src="<c:url value='/image/phone.png' />" alt="Teléfono">
                    <span>(+57) 123-4567</span>
                </div>
            </div>

            <div class="social-links">
                <h3>Contáctanos:</h3>
                <div class="social-icons">
                    <a href="#"><img src="<c:url value='/image/facebook.png' />" alt="Facebook"></a>
                    <a href="#"><img src="<c:url value='/image/twitter.png' />" alt="Twitter"></a>
                    <a href="#"><img src="<c:url value='/image/instagram.png' />" alt="Instagram"></a>
                    <a href="#"><img src="<c:url value='/image/linkedin.png' />" alt="LinkedIn"></a>
                </div>
            </div>
        </div>

        <div class="right-section">
            <div class="tabs">
                <button class="tab-btn ${activeTab != 'actualizar' ? 'active' : ''}" onclick="showTab('registro')">Registro</button>
                <button class="tab-btn ${activeTab == 'actualizar' ? 'active' : ''}" onclick="showTab('actualizar')">Actualizar</button>
            </div>

            <c:if test="${not empty error}">
                <div class="error-message">${error}</div>
            </c:if>
            <c:if test="${not empty message}">
                <div class="success-message">${message}</div>
            </c:if>

            <!-- Formulario de Registro -->
            <form action="<c:url value='/estudiantes/registro' />" method="post" 
                  class="registro-form ${activeTab == 'actualizar' ? 'hidden' : ''}" id="registroForm">
                <div class="form-row">
                    <div class="form-group">
                        <label for="nombre">Nombre</label>
                        <input type="text" id="nombre" name="nombre" required placeholder="Tu nombre">
                    </div>
                    <div class="form-group">
                        <label for="apellido">Apellido</label>
                        <input type="text" id="apellido" name="apellido" required placeholder="Tu apellido">
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="cedula">Documento</label>
                        <input type="text" id="cedula" name="cedula" required placeholder="Número de documento">
                    </div>
                    <div class="form-group">
                        <label for="codigo">Código</label>
                        <input type="text" id="codigo" name="codigo" required placeholder="Código estudiantil">
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="correo">Correo</label>
                        <input type="email" id="correo" name="correo" required placeholder="Tu correo electrónico">
                    </div>
                    <div class="form-group">
                        <label for="telefono">Teléfono</label>
                        <input type="tel" id="telefono" name="telefono" required placeholder="Tu número de teléfono">
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="genero">Género</label>
                        <select id="genero" name="genero" required>
                            <option value="">Selecciona un género</option>
                            <option value="M">Masculino</option>
                            <option value="F">Femenino</option>
                            <option value="O">Otro</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="fechaNacimiento">Fecha de nacimiento</label>
                        <input type="date" id="fechaNacimiento" name="fechaNacimiento" required>
                    </div>
                </div>

                <div class="form-group full-width">
                    <label for="direccion">Dirección</label>
                    <input type="text" id="direccion" name="direccion" required placeholder="Tu dirección completa">
                </div>

                <div class="form-group full-width">
                    <label for="programaAcademicoId">Programa académico</label>
                    <select id="programaAcademicoId" name="programaAcademicoId" required>
                        <option value="">Selecciona un programa</option>
                        <option value="1">Ingeniería de Sistemas</option>
                        <option value="2">Ingeniería Civil</option>
                        <option value="3">Ingeniería Industrial</option>
                    </select>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="contrasena">Contraseña</label>
                        <input type="password" id="contrasena" name="contrasena" required placeholder="Tu contraseña">
                    </div>
                    <div class="form-group">
                        <label for="confirmarContrasena">Confirmar contraseña</label>
                        <input type="password" id="confirmarContrasena" name="confirmarContrasena" required placeholder="Confirma tu contraseña">
                    </div>
                </div>

                <button type="submit" class="submit-btn">Registrarme</button>
            </form>

            <!-- Formulario de Actualización -->
            <form action="<c:url value='/estudiantes/actualizar/${codigo}' />" method="post" 
                  class="registro-form ${activeTab != 'actualizar' ? 'hidden' : ''}" id="actualizarForm">
                <div class="form-row">
                    <div class="form-group">
                        <label for="codigoBusqueda">Código del Estudiante</label>
                        <div class="search-container">
                            <input type="text" id="codigoBusqueda" placeholder="Ingrese el código" 
                                   value="${codigo}" ${encontrado ? 'readonly' : ''}>
                            <button type="button" class="search-btn" onclick="buscarEstudiante()" 
                                    ${encontrado ? 'disabled' : ''}>
                                ${encontrado ? 'Encontrado' : 'Buscar'}
                            </button>
                        </div>
                    </div>
                </div>

                <c:if test="${encontrado}">
                    <div class="form-row">
                        <div class="form-group">
                            <label for="nombre">Nombre</label>
                            <input type="text" id="nombre" name="nombre" value="${estudiante.nombre}" required>
                        </div>
                        <div class="form-group">
                            <label for="apellido">Apellido</label>
                            <input type="text" id="apellido" name="apellido" value="${estudiante.apellido}" required>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="correo">Correo</label>
                            <input type="email" id="correo" name="correo" value="${estudiante.correo}" required>
                        </div>
                        <div class="form-group">
                            <label for="telefono">Teléfono</label>
                            <input type="tel" id="telefono" name="telefono" value="${estudiante.telefono}" required>
                        </div>
                    </div>

                    <div class="form-group full-width">
                        <label for="direccion">Dirección</label>
                        <input type="text" id="direccion" name="direccion" value="${estudiante.direccion}" required>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="estado">Estado</label>
                            <select id="estado" name="estado" required>
                                <option value="true" ${estudiante.estado ? 'selected' : ''}>Activo</option>
                                <option value="false" ${!estudiante.estado ? 'selected' : ''}>Inactivo</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="beca">Beca</label>
                            <select id="beca" name="beca" required>
                                <option value="true" ${estudiante.beca ? 'selected' : ''}>Sí</option>
                                <option value="false" ${!estudiante.beca ? 'selected' : ''}>No</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group full-width">
                        <label for="fechaEgreso">Fecha de Egreso</label>
                        <input type="date" id="fechaEgreso" name="fechaEgreso" value="${estudiante.fechaEgreso}">
                    </div>

                    <button type="submit" class="submit-btn">Actualizar Estudiante</button>
                </c:if>
            </form>
        </div>
    </div>

    <script>
        function showTab(tabName) {
            const registroForm = document.getElementById('registroForm');
            const actualizarForm = document.getElementById('actualizarForm');
            const tabs = document.querySelectorAll('.tab-btn');

            if (tabName === 'registro') {
                registroForm.classList.remove('hidden');
                actualizarForm.classList.add('hidden');
                tabs[0].classList.add('active');
                tabs[1].classList.remove('active');
            } else {
                registroForm.classList.add('hidden');
                actualizarForm.classList.remove('hidden');
                tabs[0].classList.remove('active');
                tabs[1].classList.add('active');
            }
        }

        function buscarEstudiante() {
            const codigo = document.getElementById('codigoBusqueda').value;
            if (codigo) {
                window.location.href = '/estudiantes/actualizar/' + codigo;
            }
        }

        // Si hay un activeTab definido, mostrar la pestaña correspondiente
        document.addEventListener('DOMContentLoaded', function() {
            const activeTab = '${activeTab}';
            if (activeTab === 'actualizar') {
                showTab('actualizar');
            }
        });
    </script>
</body>
</html> 