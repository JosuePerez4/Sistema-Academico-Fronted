<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Matrícula de Semestre</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="/css/matricula.css">
</head>
<body>
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-10">
                <div class="custom-card">
                    <div class="card-body">
                        <h2 class="text-center mb-4">Matrícula de Semestre</h2>
                        
                        <!-- Información del Estudiante -->
                        <div class="student-info">
                            <h5>Información del Estudiante</h5>
                            <p><strong>Nombre:</strong> ${estudiante.nombre}</p>
                            <p><strong>Código:</strong> ${estudiante.codigo}</p>
                            <p><strong>Semestre Actual:</strong> ${estudiante.semestreActual}</p>
                        </div>

                        <!-- Selector de Semestre -->
                        <div class="semester-select">
                            <label for="semestre" class="form-label">Seleccionar Semestre a Matricular</label>
                            <select class="form-select" id="semestre" name="semestre">
                                <c:forEach var="sem" items="${semestresDisponibles}">
                                    <option value="${sem.id}">${sem.nombre}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <!-- Materias Disponibles -->
                        <h5 class="mb-3">Materias Disponibles</h5>
                        <div class="row g-3 materias-container">
                            <c:forEach var="materia" items="${materiasDisponibles}">
                                <div class="col-md-6">
                                    <div class="card course-card materia-card" onclick="toggleMateria(this, ${materia.id})">
                                        <div class="card-body">
                                            <h6 class="card-title">${materia.nombre}</h6>
                                            <div class="materia-info">
                                                <p class="mb-1">
                                                    <i class="bi bi-clock"></i>Créditos: ${materia.creditos}
                                                </p>
                                                <p class="mb-0">
                                                    <i class="bi bi-calendar3"></i>Horario: ${materia.horario}
                                                </p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>

                        <!-- Resumen de Matrícula -->
                        <div class="matricula-resumen">
                            <h5>Resumen de Matrícula</h5>
                            <p><strong>Total Materias Seleccionadas:</strong> <span id="totalMaterias">0</span></p>
                            <p class="mb-0"><strong>Total Créditos:</strong> <span id="totalCreditos">0</span></p>
                        </div>

                        <!-- Mensajes de Error/Éxito -->
                        <c:if test="${not empty mensaje}">
                            <div class="alert alert-custom alert-${tipoMensaje}">
                                ${mensaje}
                            </div>
                        </c:if>

                        <!-- Botones de Acción -->
                        <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                            <button type="button" class="btn btn-action btn-limpiar me-md-2" onclick="limpiarSeleccion()">
                                <i class="bi bi-x-circle"></i>Limpiar Selección
                            </button>
                            <button type="button" class="btn btn-action btn-confirmar" onclick="confirmarMatricula()">
                                <i class="bi bi-check2-circle"></i>Confirmar Matrícula
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        let materiasSeleccionadas = new Set();
        let creditosPorMateria = {};

        function toggleMateria(element, materiaId) {
            element.classList.toggle('selected-course');
            if (materiasSeleccionadas.has(materiaId)) {
                materiasSeleccionadas.delete(materiaId);
            } else {
                materiasSeleccionadas.add(materiaId);
            }
            actualizarResumen();
        }

        function actualizarResumen() {
            document.getElementById('totalMaterias').textContent = materiasSeleccionadas.size;
            // Aquí se actualizaría también el total de créditos cuando tengamos esa información
        }

        function limpiarSeleccion() {
            materiasSeleccionadas.clear();
            document.querySelectorAll('.course-card').forEach(card => {
                card.classList.remove('selected-course');
            });
            actualizarResumen();
        }

        function confirmarMatricula() {
            if (materiasSeleccionadas.size === 0) {
                alert('Por favor, selecciona al menos una materia.');
                return;
            }

            const data = {
                semestreId: document.getElementById('semestre').value,
                materias: Array.from(materiasSeleccionadas)
            };

            fetch('/matricula/registrar', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(data)
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert('Matrícula realizada con éxito');
                    window.location.reload();
                } else {
                    alert(data.mensaje || 'Error al realizar la matrícula');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('Error al procesar la matrícula');
            });
        }
    </script>
</body>
</html> 