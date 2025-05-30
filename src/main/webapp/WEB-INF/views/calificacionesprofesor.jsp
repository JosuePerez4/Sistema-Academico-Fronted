<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="es">

        <head>
            <meta charset="UTF-8" />
            <title>Gestión de Calificaciones - Sistema Académico</title>
            <link rel="stylesheet" href="/css/profesor.css" />
            <link rel="preconnect" href="https://fonts.googleapis.com" />
            <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
            <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap"
                rel="stylesheet" />
            <link rel="stylesheet"
                href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" />
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
                            <li>
                                <a href="/profesor/dashboard"
                                    class="${currentPage == 'dashboard' ? 'active' : ''}">Inicio</a>
                            </li>
                            <li>
                                <a href="/profesor/clases" class="${currentPage == 'clases' ? 'active' : ''}">Mis
                                    Clases</a>
                            </li>
                            <li>
                                <a href="/profesor/calificaciones"
                                    class="${currentPage == 'calificaciones' ? 'active' : ''}">Calificaciones</a>
                            </li>
                            <li>
                                <a href="/mensajes" class="${currentPage == 'mensajes' ? 'active' : ''}">Mensajes <span
                                        class="badge">3</span></a>
                            </li>
                            <li>
                                <a href="/profesor/horario"
                                    class="${currentPage == 'horario' ? 'active' : ''}">Horario</a>
                            </li>
                            <li>
                                <a href="/profesor/asistencias"
                                    class="${currentPage == 'asistencias' ? 'active' : ''}">Asistencias</a>
                            </li>
                            <li>
                                <a href="/profesor/evaluaciones"
                                    class="${currentPage == 'evaluaciones' ? 'active' : ''}">Evaluaciones</a>
                            </li>
                            <li>
                                <a href="/profesor/ajustes"
                                    class="${currentPage == 'ajustes' ? 'active' : ''}">Ajustes</a>
                            </li>
                            <li>
                                <a href="/profesor/recursos"
                                    class="${currentPage == 'recursos' ? 'active' : ''}">Recursos Académicos</a>
                            </li>
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
                            <h2>
                                Bienvenido de vuelta, <span class="highlight">${nombre}</span>
                            </h2>
                            <div class="date">${fechaActual}</div>
                        </div>
                        <div class="header-actions">
                            <input type="text" placeholder="Búsqueda" class="search" />
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

                    <div class="grade-management-container">
                        <h2 class="section-title">Gestión de Calificaciones</h2>

                        <div class="filters-actions">
                            <label for="course-select">Curso:</label>
                            <select id="course-select">
                                <option value="">Seleccionar Curso</option>
                                <option value="matematicas">Matemáticas Discretas</option>
                                <option value="programacion">
                                    Programación Orientada a Objetos
                                </option>
                                <option value="fisica">Física II</option>
                            </select>

                            <label for="evaluation-type">Tipo de Evaluación:</label>
                            <select id="evaluation-type">
                                <option value="">Todos</option>
                                <option value="parcial">Parcial</option>
                                <option value="quiz">Quiz</option>
                                <option value="proyecto">Proyecto</option>
                                <option value="trabajo">Trabajo</option>
                                <option value="examen">Examen</option>
                            </select>
                            <button class="btn-primary">
                                <i class="fas fa-filter"></i> Filtrar
                            </button>
                            <button class="btn-primary add-new-grade-btn">
                                <i class="fas fa-plus"></i> Ingresar Nueva Calificación
                            </button>
                        </div>

                        <div class="light-table-wrapper">
                            <%-- CLASE CAMBIADA A light-table-wrapper --%>
                                <table class="grades-table">
                                    <thead>
                                        <tr>
                                            <th class="header-eval-cal">Evaluación y Calificaciones</th>
                                            <th class="header-registro">Registro de Calificaciones</th>
                                            <th class="header-descripcion">
                                                Permitir el ingreso, modificación y consulta de
                                                calificaciones de evaluaciones, exámenes y trabajos.
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td class="cell-eval-cal">
                                                <div class="grade-item-info">
                                                    <span class="grade-evaluation-name">Parcial 1</span>
                                                    <span class="grade-student-name">Juan Pérez (115001)</span>
                                                    <span class="grade-course-name">Matemáticas Discretas</span>
                                                </div>
                                            </td>
                                            <td class="cell-registro">
                                                <input type="number" class="grade-input" value="2.0" min="0.0" max="5.0"
                                                    step="0.1" />
                                                <%-- Valor inicial ajustado a 2.0 --%>
                                                    <button class="btn-action edit-btn" title="Editar">
                                                        <i class="fas fa-edit"></i>
                                                    </button>
                                                    <button class="btn-action save-btn" title="Guardar"
                                                        style="display: none">
                                                        <i class="fas fa-save"></i>
                                                    </button>
                                            </td>
                                            <td class="cell-descripcion">
                                                Primer examen parcial del curso. Abordó los temas de lógica
                                                proposicional y conjuntos.
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="cell-eval-cal">
                                                <div class="grade-item-info">
                                                    <span class="grade-evaluation-name">Proyecto Final</span>
                                                    <span class="grade-student-name">María López (115002)</span>
                                                    <span class="grade-course-name">Programación Orientada a
                                                        Objetos</span>
                                                </div>
                                            </td>
                                            <td class="cell-registro">
                                                <input type="number" class="grade-input" value="4.8" min="0.0" max="5.0"
                                                    step="0.1" />
                                                <button class="btn-action edit-btn" title="Editar">
                                                    <i class="fas fa-edit"></i>
                                                </button>
                                                <button class="btn-action save-btn" title="Guardar"
                                                    style="display: none">
                                                    <i class="fas fa-save"></i>
                                                </button>
                                            </td>
                                            <td class="cell-descripcion">
                                                Desarrollo de una aplicación CRUD con Spring Boot y React.
                                                Calidad de código y funcionalidad.
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="cell-eval-cal">
                                                <div class="grade-item-info">
                                                    <span class="grade-evaluation-name">Quiz 3</span>
                                                    <span class="grade-student-name">Carlos Ruiz (115003)</span>
                                                    <span class="grade-course-name">Física II</span>
                                                </div>
                                            </td>
                                            <td class="cell-registro">
                                                <input type="number" class="grade-input" value="3.0" min="0.0" max="5.0"
                                                    step="0.1" />
                                                <button class="btn-action edit-btn" title="Editar">
                                                    <i class="fas fa-edit"></i>
                                                </button>
                                                <button class="btn-action save-btn" title="Guardar"
                                                    style="display: none">
                                                    <i class="fas fa-save"></i>
                                                </button>
                                            </td>
                                            <td class="cell-descripcion">
                                                Prueba corta sobre leyes de Newton y energía. Se requiere
                                                refuerzo en problemas de fricción.
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                        </div>
                    </div>
                </main>
            </div>

            <div id="newGradeModal" class="modal">
                <div class="modal-content">
                    <h3>Ingresar Nueva Calificación</h3>
                    <form id="newGradeForm">
                        <div class="form-group">
                            <label for="modalCourse">Curso:</label>
                            <select id="modalCourse" required>
                                <option value="">Seleccionar Curso</option>
                                <option value="matematicas">Matemáticas Discretas</option>
                                <option value="programacion">
                                    Programación Orientada a Objetos
                                </option>
                                <option value="fisica">Física II</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="modalStudent">Estudiante (Nombre o Código):</label>
                            <input type="text" id="modalStudent" placeholder="Ej: Juan Pérez o 115001" required />
                        </div>
                        <div class="form-group">
                            <label for="modalEvaluationType">Tipo de Evaluación:</label>
                            <select id="modalEvaluationType" required>
                                <option value="">Seleccionar Tipo</option>
                                <option value="parcial">Parcial</option>
                                <option value="quiz">Quiz</option>
                                <option value="proyecto">Proyecto</option>
                                <option value="trabajo">Trabajo</option>
                                <option value="examen">Examen</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="modalEvaluationName">Nombre de la Evaluación:</label>
                            <input type="text" id="modalEvaluationName" placeholder="Ej: Parcial 1, Taller #5"
                                required />
                        </div>
                        <div class="form-group">
                            <label for="modalGrade">Calificación (0.0 - 5.0):</label>
                            <input type="number" id="modalGrade" min="0.0" max="5.0" step="0.1" required />
                        </div>
                        <div class="form-group">
                            <label for="modalDescription">Descripción:</label>
                            <textarea id="modalDescription" rows="3"
                                placeholder="Descripción breve de la evaluación o trabajo"></textarea>
                        </div>
                        <div class="form-actions-modal">
                            <button type="button" class="btn-secondary close-button">
                                Cancelar
                            </button>
                            <button type="submit" class="btn-primary">
                                Guardar Calificación
                            </button>
                        </div>
                    </form>
                </div>
            </div>

            <script>
                document.addEventListener("DOMContentLoaded", function () {
                    // Manejar la edición de calificaciones (se mantiene)
                    document.querySelectorAll(".edit-btn").forEach((button) => {
                        button.addEventListener("click", function () {
                            const row = this.closest("tr");
                            const gradeInput = row.querySelector(".grade-input");
                            gradeInput.readOnly = false;
                            gradeInput.focus();
                            this.style.display = "none"; // Ocultar botón de editar
                            row.querySelector(".save-btn").style.display = "inline-block"; // Mostrar botón de guardar
                        });
                    });

                    document.querySelectorAll(".save-btn").forEach((button) => {
                        button.addEventListener("click", function () {
                            const row = this.closest("tr");
                            const gradeInput = row.querySelector(".grade-input");
                            gradeInput.readOnly = true;
                            // Aquí deberías enviar la calificación actualizada al servidor (AJAX)
                            alert(
                                "Calificación de " +
                                row.querySelector(".grade-student-name").textContent +
                                " para " +
                                row.querySelector(".grade-evaluation-name").textContent +
                                " guardada: " +
                                gradeInput.value
                            );
                            this.style.display = "none"; // Ocultar botón de guardar
                            row.querySelector(".edit-btn").style.display = "inline-block"; // Mostrar botón de editar
                        });
                    });

                    // Inicializar inputs como readOnly y mostrar solo el botón de editar
                    document.querySelectorAll(".grade-input").forEach((input) => {
                        input.readOnly = true;
                        // Ocultar guardar al inicio ya está en el HTML, pero lo dejamos por si acaso.
                        // input.closest('td').querySelector('.save-btn').style.display = 'none';
                    });

                    // --- Funcionalidad del Modal de Nueva Calificación ---
                    const newGradeModal = document.getElementById("newGradeModal");
                    const addNewGradeBtn = document.querySelector(".add-new-grade-btn");
                    const closeButtons = document.querySelectorAll(".close-button");
                    const newGradeForm = document.getElementById("newGradeForm");

                    addNewGradeBtn.addEventListener("click", function () {
                        newGradeModal.style.display = "block";
                    });

                    closeButtons.forEach((button) => {
                        button.addEventListener("click", function () {
                            newGradeModal.style.display = "none";
                            newGradeForm.reset(); // Limpiar el formulario al cerrar
                        });
                    });

                    window.addEventListener("click", function (event) {
                        if (event.target == newGradeModal) {
                            newGradeModal.style.display = "none";
                            newGradeForm.reset(); // Limpiar el formulario al hacer clic fuera
                        }
                    });

                    newGradeForm.addEventListener("submit", function (event) {
                        event.preventDefault(); // Evitar el envío por defecto del formulario

                        const course = document.getElementById("modalCourse").value;
                        const student = document.getElementById("modalStudent").value;
                        const evaluationType = document.getElementById(
                            "modalEvaluationType"
                        ).value;
                        const evaluationName = document.getElementById(
                            "modalEvaluationName"
                        ).value;
                        const grade = document.getElementById("modalGrade").value;
                        const description = document.getElementById("modalDescription").value;

                        // Aquí enviarías estos datos a tu backend (AJAX o envío de formulario)
                        console.log("Nueva Calificación:", {
                            course,
                            student,
                            evaluationType,
                            evaluationName,
                            grade,
                            description,
                        });
                        alert(
                            "Nueva calificación para " +
                            student +
                            " (" +
                            evaluationName +
                            ") guardada: " +
                            grade +
                            "\n(Esta es solo una simulación)"
                        );

                        // Cerrar modal y limpiar formulario
                        newGradeModal.style.display = "none";
                        newGradeForm.reset();
                    });
                });
            </script>
        </body>

        </html>