package co.edu.frontend.controller;

import co.edu.frontend.model.EstudianteRequestDTO;
import co.edu.frontend.model.EstudianteUpdateDTO;
import co.edu.frontend.model.LoginResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.ResourceAccessException;
import org.springframework.web.client.RestTemplate;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import org.springframework.core.ParameterizedTypeReference;
import java.util.HashMap;
import java.util.ArrayList;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/estudiantes")
public class EstudianteController {
    @Value("${backend.api.url:http://localhost:8081}")
    private String backendUrl;
    
    private final RestTemplate restTemplate = new RestTemplate();

    @GetMapping("/registro")
    public String mostrarFormularioRegistro(Model model) {
        return "registroEstudiante";
    }

    @GetMapping("/actualizar/{codigo}")
    public String mostrarFormularioActualizacion(@PathVariable String codigo, Model model) {
        try {
            // Primero verificamos si existe el estudiante
            ResponseEntity<EstudianteRequestDTO> response = restTemplate.getForEntity(
                    backendUrl + "/api/estudiante/codigo/" + codigo,
                    EstudianteRequestDTO.class);

            if (response.getStatusCode() == HttpStatus.OK && response.getBody() != null) {
                // Si existe, guardamos los datos básicos necesarios
                EstudianteRequestDTO estudiante = response.getBody();
                model.addAttribute("estudiante", estudiante);
                model.addAttribute("codigo", codigo);
                model.addAttribute("encontrado", true);
                model.addAttribute("message", "Estudiante encontrado. Puede proceder con la actualización.");
                model.addAttribute("activeTab", "actualizar");
                return "registroEstudiante";
            } else {
                model.addAttribute("error", "No se encontró el estudiante con el código " + codigo);
                model.addAttribute("activeTab", "actualizar");
                return "registroEstudiante";
            }
        } catch (HttpClientErrorException.NotFound e) {
            // Manejo específico para cuando no se encuentra el estudiante
            model.addAttribute("error", "No existe un estudiante con el código " + codigo);
            model.addAttribute("activeTab", "actualizar");
            return "registroEstudiante";
        } catch (Exception e) {
            model.addAttribute("error", "Error al buscar el estudiante: " + e.getMessage());
            model.addAttribute("activeTab", "actualizar");
            return "registroEstudiante";
        }
    }

    @PostMapping("/actualizar/{codigo}")
    public String actualizarEstudiante(@PathVariable String codigo, 
                                     @ModelAttribute EstudianteUpdateDTO estudiante,
                                     Model model) {
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));

        HttpEntity<EstudianteUpdateDTO> requestEntity = new HttpEntity<>(estudiante, headers);

        try {
            ResponseEntity<String> response = restTemplate.exchange(
                    backendUrl + "/api/estudiante/actualizar/" + codigo,
                    HttpMethod.PUT,
                    requestEntity,
                    String.class);

            if (response.getStatusCode() == HttpStatus.OK) {
                model.addAttribute("message", "Estudiante actualizado exitosamente");
                model.addAttribute("activeTab", "actualizar");
                return "registroEstudiante";
            } else {
                model.addAttribute("error", "Error al actualizar el estudiante");
                model.addAttribute("activeTab", "actualizar");
                model.addAttribute("codigo", codigo);
                return "registroEstudiante";
            }
        } catch (HttpClientErrorException e) {
            model.addAttribute("error", "Error al actualizar: " + e.getResponseBodyAsString());
            model.addAttribute("activeTab", "actualizar");
            model.addAttribute("codigo", codigo);
            return "registroEstudiante";
        } catch (Exception e) {
            model.addAttribute("error", "Error al actualizar el estudiante");
            model.addAttribute("activeTab", "actualizar");
            model.addAttribute("codigo", codigo);
            return "registroEstudiante";
        }
    }

    @PostMapping("/registro")
    public String procesarRegistro(@ModelAttribute EstudianteRequestDTO estudiante, Model model) {
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));

        HttpEntity<EstudianteRequestDTO> requestEntity = new HttpEntity<>(estudiante, headers);

        try {
            ResponseEntity<String> response = restTemplate.exchange(
                    backendUrl + "/api/estudiante/registrar",
                    HttpMethod.POST,
                    requestEntity,
                    String.class);

            if (response.getStatusCode() == HttpStatus.OK || 
                response.getStatusCode() == HttpStatus.CREATED) {
                // Redirigir al login con mensaje de éxito
                return "redirect:/login?registered=true";
            } else {
                model.addAttribute("error", "Hubo un problema al procesar tu registro. Por favor, intenta nuevamente.");
                return "registroEstudiante";
            }
        } catch (HttpClientErrorException e) {
            String errorMessage;
            if (e.getStatusCode() == HttpStatus.BAD_REQUEST) {
                // Intenta extraer el mensaje de error del backend
                errorMessage = e.getResponseBodyAsString();
                // Si el mensaje es muy técnico o largo, usa uno más amigable
                if (errorMessage.length() > 100) {
                    errorMessage = "Los datos ingresados no son válidos. Por favor, verifica la información.";
                }
            } else if (e.getStatusCode() == HttpStatus.CONFLICT) {
                errorMessage = "Ya existe un usuario registrado con ese correo o documento.";
            } else {
                errorMessage = "No se pudo completar el registro. Por favor, intenta nuevamente.";
            }
            model.addAttribute("error", errorMessage);
            // Mantener los datos del formulario
            model.addAttribute("estudiante", estudiante);
            return "registroEstudiante";
        } catch (ResourceAccessException e) {
            model.addAttribute("error", "No se pudo conectar al servidor. Por favor, intenta más tarde.");
            model.addAttribute("estudiante", estudiante);
            return "registroEstudiante";
        } catch (Exception e) {
            model.addAttribute("error", "Ocurrió un error inesperado. Por favor, intenta más tarde.");
            model.addAttribute("estudiante", estudiante);
            return "registroEstudiante";
        }
    }

    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        LoginResponse user = (LoginResponse) session.getAttribute("usuario");
        if (user == null || !"estudiante".equalsIgnoreCase(user.getRol())) {
            System.out.println("Usuario no autorizado o no es estudiante");
            return "redirect:/login";
        }

        try {
            System.out.println("Intentando cargar información del estudiante con ID: " + user.getId());
            
            // Obtener información del estudiante
            String estudianteUrl = backendUrl + "/api/estudiante/obtener/" + user.getId();
            System.out.println("URL para info estudiante: " + estudianteUrl);
            
            ResponseEntity<Map> estudianteResponse = restTemplate.getForEntity(
                estudianteUrl,
                Map.class
            );
            
            if (estudianteResponse.getStatusCode() == HttpStatus.OK && estudianteResponse.getBody() != null) {
                model.addAttribute("estudiante", estudianteResponse.getBody());
                System.out.println("Información del estudiante cargada correctamente");
            }

            // Obtener materias matriculadas
            String materiasUrl = backendUrl + "/api/materias/listar";
            System.out.println("URL para materias: " + materiasUrl);
            
            ResponseEntity<List<Map<String, Object>>> materiasResponse = restTemplate.exchange(
                materiasUrl,
                HttpMethod.GET,
                null,
                new ParameterizedTypeReference<List<Map<String, Object>>>() {}
            );
            
            if (materiasResponse.getStatusCode() == HttpStatus.OK && materiasResponse.getBody() != null) {
                model.addAttribute("materias", materiasResponse.getBody());
                System.out.println("Materias cargadas correctamente: " + materiasResponse.getBody().size() + " registros");
            }

            // Agregar datos básicos del usuario
            model.addAttribute("nombre", user.getNombre());
            model.addAttribute("correo", user.getCorreo());
            model.addAttribute("rol", user.getRol());

            System.out.println("Cargando dashboard de estudiante para: " + user.getNombre());
            return "dashboardestudiante";
            
        } catch (Exception e) {
            System.err.println("Error al cargar dashboard de estudiante: " + e.getMessage());
            e.printStackTrace();
            model.addAttribute("error", "Error al cargar la información del estudiante");
            return "redirect:/login";
        }
    }

    @GetMapping("/calificaciones")
    public String verCalificaciones(HttpSession session, Model model) {
        LoginResponse user = (LoginResponse) session.getAttribute("usuario");
        if (user == null || !"estudiante".equalsIgnoreCase(user.getRol())) {
            return "redirect:/login";
        }

        try {
            ResponseEntity<Map> calificacionesResponse = restTemplate.getForEntity(
                backendUrl + "/api/calificaciones/estudiante/" + user.getId(),
                Map.class
            );
            
            if (calificacionesResponse.getStatusCode() == HttpStatus.OK && calificacionesResponse.getBody() != null) {
                model.addAttribute("calificaciones", calificacionesResponse.getBody());
            }

            return "calificacionesestudiante";
        } catch (Exception e) {
            model.addAttribute("error", "Error al cargar las calificaciones");
            return "dashboardestudiante";
        }
    }

    @GetMapping("/materias")
    public String verMaterias(HttpSession session, Model model) {
        LoginResponse user = (LoginResponse) session.getAttribute("usuario");
        if (user == null || !"estudiante".equalsIgnoreCase(user.getRol())) {
            return "redirect:/login";
        }

        try {
            // Obtener materias matriculadas del estudiante
            ResponseEntity<List<Map<String, Object>>> materiasResponse = restTemplate.exchange(
                backendUrl + "/api/matricula/obtenerPorEstudiante/" + user.getId(),
                HttpMethod.GET,
                null,
                new ParameterizedTypeReference<List<Map<String, Object>>>() {}
            );
            
            if (materiasResponse.getStatusCode() == HttpStatus.OK && materiasResponse.getBody() != null) {
                model.addAttribute("materiasMatriculadas", materiasResponse.getBody());
            }

            // Agregar información del usuario
            model.addAttribute("nombre", user.getNombre());
            model.addAttribute("correo", user.getCorreo());
            
            return "estudiante/materias";
        } catch (Exception e) {
            model.addAttribute("error", "Error al cargar las materias");
            return "dashboardestudiante";
        }
    }

    @GetMapping("/matricula")
    public String mostrarMatricula(HttpSession session, Model model) {
        LoginResponse user = (LoginResponse) session.getAttribute("usuario");
        if (user == null || !"estudiante".equalsIgnoreCase(user.getRol())) {
            return "redirect:/login";
        }

        try {
            // Obtener información del estudiante
            ResponseEntity<Map> estudianteResponse = restTemplate.getForEntity(
                backendUrl + "/api/estudiante/obtener/" + user.getId(),
                Map.class
            );
            
            if (estudianteResponse.getStatusCode() == HttpStatus.OK && estudianteResponse.getBody() != null) {
                model.addAttribute("estudiante", estudianteResponse.getBody());
            }

            // Obtener semestres disponibles
            ResponseEntity<List<Map<String, Object>>> semestresResponse = restTemplate.exchange(
                backendUrl + "/api/semestres/listar",
                HttpMethod.GET,
                null,
                new ParameterizedTypeReference<List<Map<String, Object>>>() {}
            );
            
            if (semestresResponse.getStatusCode() == HttpStatus.OK && semestresResponse.getBody() != null) {
                model.addAttribute("semestres", semestresResponse.getBody());
            }

            model.addAttribute("nombre", user.getNombre());
            return "estudiante/matricula";
        } catch (Exception e) {
            model.addAttribute("error", "Error al cargar información de matrícula");
            return "dashboardestudiante";
        }
    }

    @GetMapping("/cursos-disponibles")
    public String mostrarCursosDisponibles(HttpSession session, Model model,
                                         @RequestParam(required = false) String buscar,
                                         @RequestParam(required = false) String creditos,
                                         @RequestParam(required = false) String vista) {
        LoginResponse user = (LoginResponse) session.getAttribute("usuario");
        if (user == null || !"estudiante".equalsIgnoreCase(user.getRol())) {
            return "redirect:/login";
        }

        try {
            // Obtener cursos disponibles
            ResponseEntity<List<Map<String, Object>>> cursosResponse = restTemplate.exchange(
                backendUrl + "/api/materias/listar",
                HttpMethod.GET,
                null,
                new ParameterizedTypeReference<List<Map<String, Object>>>() {}
            );
            
            List<Map<String, Object>> cursos = cursosResponse.getBody();
            
            // Aplicar filtros si están presentes
            if (cursos != null) {
                if (buscar != null && !buscar.trim().isEmpty()) {
                    cursos = cursos.stream()
                            .filter(curso -> {
                                String nombre = (String) curso.get("nombre");
                                return nombre != null && nombre.toLowerCase().contains(buscar.toLowerCase());
                            })
                            .collect(java.util.stream.Collectors.toList());
                }
                
                if (creditos != null && !creditos.trim().isEmpty()) {
                    cursos = cursos.stream()
                            .filter(curso -> {
                                Object creditosObj = curso.get("creditos");
                                return creditosObj != null && creditosObj.toString().equals(creditos);
                            })
                            .collect(java.util.stream.Collectors.toList());
                }
            }
            
            model.addAttribute("cursosDisponibles", cursos);
            model.addAttribute("nombre", user.getNombre());
            
            return "estudiante/cursosDisponibles";
        } catch (Exception e) {
            model.addAttribute("error", "Error al cargar cursos disponibles");
            return "estudiante/cursosDisponibles";
        }
    }

    @GetMapping("/seleccionar-grupo/{cursoId}")
    public String mostrarSeleccionGrupo(@PathVariable Long cursoId, HttpSession session, Model model) {
        LoginResponse user = (LoginResponse) session.getAttribute("usuario");
        if (user == null || !"estudiante".equalsIgnoreCase(user.getRol())) {
            return "redirect:/login";
        }

        try {
            // Simular información del curso y grupos (reemplazar con llamada real al backend)
            Map<String, Object> curso = new HashMap<>();
            curso.put("id", cursoId);
            curso.put("nombre", "Curso " + cursoId);
            curso.put("codigo", "CUR" + String.format("%03d", cursoId));
            curso.put("creditos", 3);
            curso.put("descripcion", "Descripción del curso " + cursoId);

            // Simular grupos disponibles
            List<Map<String, Object>> grupos = new ArrayList<>();
            
            Map<String, Object> grupoA = new HashMap<>();
            grupoA.put("id", cursoId + "-A");
            grupoA.put("nombre", "Grupo A");
            grupoA.put("horario", "Lunes, Miércoles, Viernes");
            grupoA.put("hora", "8:00 AM - 10:00 AM");
            grupoA.put("profesor", "Dr. García");
            grupoA.put("cupos", 25);
            grupoA.put("salon", "Aula 201");
            grupos.add(grupoA);

            Map<String, Object> grupoB = new HashMap<>();
            grupoB.put("id", cursoId + "-B");
            grupoB.put("nombre", "Grupo B");
            grupoB.put("horario", "Martes, Jueves");
            grupoB.put("hora", "2:00 PM - 4:00 PM");
            grupoB.put("profesor", "Ing. López");
            grupoB.put("cupos", 20);
            grupoB.put("salon", "Aula 305");
            grupos.add(grupoB);

            Map<String, Object> grupoC = new HashMap<>();
            grupoC.put("id", cursoId + "-C");
            grupoC.put("nombre", "Grupo C");
            grupoC.put("horario", "Sábados");
            grupoC.put("hora", "8:00 AM - 12:00 PM");
            grupoC.put("profesor", "Dr. Martínez");
            grupoC.put("cupos", 30);
            grupoC.put("salon", "Aula 101");
            grupos.add(grupoC);

            model.addAttribute("curso", curso);
            model.addAttribute("grupos", grupos);
            model.addAttribute("nombre", user.getNombre());

            return "estudiante/seleccionGrupo";
        } catch (Exception e) {
            model.addAttribute("error", "Error al cargar información del curso");
            return "redirect:/estudiantes/cursos-disponibles";
        }
    }

    @GetMapping("/curso-detalle/{cursoId}")
    public String mostrarDetalleCurso(@PathVariable Long cursoId, HttpSession session, Model model) {
        LoginResponse user = (LoginResponse) session.getAttribute("usuario");
        if (user == null || !"estudiante".equalsIgnoreCase(user.getRol())) {
            return "redirect:/login";
        }

        try {
            // Simular información detallada del curso
            Map<String, Object> curso = new HashMap<>();
            curso.put("id", cursoId);
            curso.put("nombre", "Curso " + cursoId);
            curso.put("codigo", "CUR" + String.format("%03d", cursoId));
            curso.put("creditos", 3);
            curso.put("duracion", "16 semanas");
            curso.put("modalidad", "Presencial");
            curso.put("descripcion", "Este curso proporciona una introducción completa a los conceptos fundamentales de la materia, incluyendo teoría y práctica aplicada.");
            
            List<String> prerrequisitos = new ArrayList<>();
            prerrequisitos.add("Conocimientos básicos de matemáticas");
            prerrequisitos.add("Curso introductorio aprobado");
            curso.put("prerrequisitos", prerrequisitos);

            // Grupos disponibles (mismo que en selección)
            List<Map<String, Object>> grupos = new ArrayList<>();
            
            Map<String, Object> grupoA = new HashMap<>();
            grupoA.put("nombre", "Grupo A");
            grupoA.put("horario", "Lunes, Miércoles, Viernes");
            grupoA.put("hora", "8:00 AM - 10:00 AM");
            grupoA.put("profesor", "Dr. García");
            grupos.add(grupoA);

            Map<String, Object> grupoB = new HashMap<>();
            grupoB.put("nombre", "Grupo B");
            grupoB.put("horario", "Martes, Jueves");
            grupoB.put("hora", "2:00 PM - 4:00 PM");
            grupoB.put("profesor", "Ing. López");
            grupos.add(grupoB);

            Map<String, Object> grupoC = new HashMap<>();
            grupoC.put("nombre", "Grupo C");
            grupoC.put("horario", "Sábados");
            grupoC.put("hora", "8:00 AM - 12:00 PM");
            grupoC.put("profesor", "Dr. Martínez");
            grupos.add(grupoC);

            curso.put("grupos", grupos);

            model.addAttribute("curso", curso);
            model.addAttribute("nombre", user.getNombre());

            return "estudiante/cursoDetalle";
        } catch (Exception e) {
            model.addAttribute("error", "Error al cargar detalles del curso");
            return "redirect:/estudiantes/cursos-disponibles";
        }
    }

    @PostMapping("/confirmar-inscripcion")
    public String confirmarInscripcion(@RequestParam Long cursoId,
                                     @RequestParam String grupoId,
                                     HttpSession session,
                                     RedirectAttributes redirectAttributes) {
        LoginResponse user = (LoginResponse) session.getAttribute("usuario");
        if (user == null || !"estudiante".equalsIgnoreCase(user.getRol())) {
            return "redirect:/login";
        }

        try {
            // Preparar datos para el backend
            MatriculaEstudianteExistenteRequestDTO matriculaRequest = new MatriculaEstudianteExistenteRequestDTO();
            matriculaRequest.setEstudianteId(user.getId());
            matriculaRequest.setSemestreId(1L); // Semestre actual fijo por ahora
            matriculaRequest.setCursos(cursoId.toString());

            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);
            HttpEntity<MatriculaEstudianteExistenteRequestDTO> requestEntity = 
                    new HttpEntity<>(matriculaRequest, headers);

            // Llamar al backend
            ResponseEntity<Map> response = restTemplate.exchange(
                    backendUrl + "/api/matricula/registrar",
                    HttpMethod.POST,
                    requestEntity,
                    Map.class
            );

            if (response.getStatusCode() == HttpStatus.OK) {
                redirectAttributes.addFlashAttribute("mensaje", 
                    "¡Inscripción exitosa! Te has inscrito al curso en el " + grupoId.split("-")[1]);
                return "redirect:/estudiantes/materias";
            } else {
                redirectAttributes.addFlashAttribute("error", "Error al procesar la inscripción");
                return "redirect:/estudiantes/seleccionar-grupo/" + cursoId;
            }

        } catch (HttpClientErrorException e) {
            redirectAttributes.addFlashAttribute("error", 
                "Error del servidor: " + e.getResponseBodyAsString());
            return "redirect:/estudiantes/seleccionar-grupo/" + cursoId;

        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", 
                "Error interno: " + e.getMessage());
            return "redirect:/estudiantes/seleccionar-grupo/" + cursoId;
        }
    }

    // DTO para la inscripción de cursos
    public static class InscripcionCursoRequestDTO {
        private Long estudianteId;
        private Long cursoId;
        private String grupoId;
        private Long semestreId;

        // Getters y setters
        public Long getEstudianteId() { return estudianteId; }
        public void setEstudianteId(Long estudianteId) { this.estudianteId = estudianteId; }
        
        public Long getCursoId() { return cursoId; }
        public void setCursoId(Long cursoId) { this.cursoId = cursoId; }
        
        public String getGrupoId() { return grupoId; }
        public void setGrupoId(String grupoId) { this.grupoId = grupoId; }
        
        public Long getSemestreId() { return semestreId; }
        public void setSemestreId(Long semestreId) { this.semestreId = semestreId; }

        @Override
        public String toString() {
            return "InscripcionCursoRequestDTO{" +
                    "estudianteId=" + estudianteId +
                    ", cursoId=" + cursoId +
                    ", grupoId='" + grupoId + '\'' +
                    ", semestreId=" + semestreId +
                    '}';
        }
    }

    // DTO para comunicación con el backend (debe coincidir con el backend)
    public static class MatriculaEstudianteExistenteRequestDTO {
        private Long estudianteId;
        private Long semestreId;
        private String cursos; // Lista de IDs de cursos separados por coma

        // Getters y setters
        public Long getEstudianteId() { return estudianteId; }
        public void setEstudianteId(Long estudianteId) { this.estudianteId = estudianteId; }
        
        public Long getSemestreId() { return semestreId; }
        public void setSemestreId(Long semestreId) { this.semestreId = semestreId; }
        
        public String getCursos() { return cursos; }
        public void setCursos(String cursos) { this.cursos = cursos; }
    }

    @GetMapping("/asistencias")
    public String mostrarAsistencias(HttpSession session, Model model) {
        LoginResponse user = (LoginResponse) session.getAttribute("usuario");
        if (user == null || !"estudiante".equalsIgnoreCase(user.getRol())) {
            return "redirect:/login";
        }

        try {
            // Obtener materias matriculadas con sus IDs de inscripción
            ResponseEntity<List<Map<String, Object>>> materiasResponse = restTemplate.exchange(
                backendUrl + "/api/matricula/obtenerPorEstudiante/" + user.getId(),
                HttpMethod.GET,
                null,
                new ParameterizedTypeReference<List<Map<String, Object>>>() {}
            );
            
            if (materiasResponse.getStatusCode() == HttpStatus.OK && materiasResponse.getBody() != null) {
                List<Map<String, Object>> materias = materiasResponse.getBody();
                
                // Para cada materia, obtener estadísticas de asistencia
                for (Map<String, Object> materia : materias) {
                    Long inscripcionId = ((Number) materia.get("id")).longValue();
                    try {
                        ResponseEntity<Map> estadisticasResponse = restTemplate.getForEntity(
                            backendUrl + "/api/asistencia/contar-por-estado/" + inscripcionId,
                            Map.class
                        );
                        
                        if (estadisticasResponse.getStatusCode() == HttpStatus.OK) {
                            materia.put("estadisticasAsistencia", estadisticasResponse.getBody());
                        }
                    } catch (Exception e) {
                        // Si falla, poner estadísticas vacías
                        materia.put("estadisticasAsistencia", new HashMap<>());
                    }
                }
                
                model.addAttribute("materiasConAsistencia", materias);
            }

            model.addAttribute("nombre", user.getNombre());
            return "estudiante/asistencias";
        } catch (Exception e) {
            model.addAttribute("error", "Error al cargar información de asistencias");
            return "estudiante/asistencias";
        }
    }

    @GetMapping("/registrar-asistencia/{inscripcionId}")
    public String mostrarRegistroAsistencia(@PathVariable Long inscripcionId, 
                                          HttpSession session, Model model) {
        LoginResponse user = (LoginResponse) session.getAttribute("usuario");
        if (user == null || !"estudiante".equalsIgnoreCase(user.getRol())) {
            return "redirect:/login";
        }

        try {
            // Obtener información de la inscripción/materia
            ResponseEntity<Map> inscripcionResponse = restTemplate.getForEntity(
                backendUrl + "/api/inscripciones/obtenerInscripcion/" + inscripcionId,
                Map.class
            );
            
            if (inscripcionResponse.getStatusCode() == HttpStatus.OK && inscripcionResponse.getBody() != null) {
                model.addAttribute("inscripcion", inscripcionResponse.getBody());
            }

            // Verificar si ya existe asistencia para hoy
            String fechaHoy = java.time.LocalDate.now().toString();
            ResponseEntity<Boolean> existeResponse = restTemplate.getForEntity(
                backendUrl + "/api/asistencia/existe?inscripcionId=" + inscripcionId + "&fecha=" + fechaHoy,
                Boolean.class
            );
            
            boolean yaRegistradaHoy = existeResponse.getStatusCode() == HttpStatus.OK && 
                                    Boolean.TRUE.equals(existeResponse.getBody());
            
            model.addAttribute("inscripcionId", inscripcionId);
            model.addAttribute("fechaHoy", fechaHoy);
            model.addAttribute("yaRegistradaHoy", yaRegistradaHoy);
            model.addAttribute("nombre", user.getNombre());
            
            return "estudiante/registrarAsistencia";
        } catch (Exception e) {
            model.addAttribute("error", "Error al cargar información de la materia");
            return "redirect:/estudiantes/asistencias";
        }
    }

    @PostMapping("/confirmar-asistencia")
    public String confirmarAsistencia(@RequestParam Long inscripcionId,
                                    @RequestParam String estado,
                                    @RequestParam(required = false) String justificacion,
                                    @RequestParam(required = false) String fecha,
                                    HttpSession session,
                                    RedirectAttributes redirectAttributes) {
        LoginResponse user = (LoginResponse) session.getAttribute("usuario");
        if (user == null || !"estudiante".equalsIgnoreCase(user.getRol())) {
            return "redirect:/login";
        }

        try {
            // Preparar datos para el backend
            Map<String, Object> asistenciaRequest = new HashMap<>();
            asistenciaRequest.put("inscripcionId", inscripcionId);
            asistenciaRequest.put("fecha", fecha != null ? fecha : java.time.LocalDate.now().toString());
            asistenciaRequest.put("estado", estado);
            
            if (justificacion != null && !justificacion.trim().isEmpty()) {
                asistenciaRequest.put("justificacion", justificacion);
            }

            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);
            HttpEntity<Map<String, Object>> requestEntity = new HttpEntity<>(asistenciaRequest, headers);

            // Llamar al backend
            ResponseEntity<Map> response = restTemplate.exchange(
                backendUrl + "/api/asistencia/registrar",
                HttpMethod.POST,
                requestEntity,
                Map.class
            );

            if (response.getStatusCode() == HttpStatus.OK) {
                String estadoTexto = "";
                switch (estado) {
                    case "PRESENTE": estadoTexto = "Presente"; break;
                    case "AUSENTE": estadoTexto = "Ausente"; break;
                    case "JUSTIFICADO": estadoTexto = "Justificado"; break;
                }
                
                redirectAttributes.addFlashAttribute("mensaje", 
                    "¡Asistencia registrada exitosamente! Estado: " + estadoTexto);
            } else {
                redirectAttributes.addFlashAttribute("error", "Error al registrar asistencia");
            }

        } catch (HttpClientErrorException e) {
            redirectAttributes.addFlashAttribute("error", 
                "Error del servidor: " + e.getResponseBodyAsString());
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", 
                "Error interno: " + e.getMessage());
        }

        return "redirect:/estudiantes/asistencias";
    }

    @GetMapping("/historial-asistencia/{inscripcionId}")
    public String mostrarHistorialAsistencia(@PathVariable Long inscripcionId,
                                           HttpSession session, Model model) {
        LoginResponse user = (LoginResponse) session.getAttribute("usuario");
        if (user == null || !"estudiante".equalsIgnoreCase(user.getRol())) {
            return "redirect:/login";
        }

        try {
            // Obtener información de la inscripción/materia
            ResponseEntity<Map> inscripcionResponse = restTemplate.getForEntity(
                backendUrl + "/api/inscripciones/obtenerInscripcion/" + inscripcionId,
                Map.class
            );
            
            if (inscripcionResponse.getStatusCode() == HttpStatus.OK && inscripcionResponse.getBody() != null) {
                model.addAttribute("inscripcion", inscripcionResponse.getBody());
            }

            // Obtener historial de asistencias
            ResponseEntity<List<Map<String, Object>>> historialResponse = restTemplate.exchange(
                backendUrl + "/api/asistencia/asistenciaPorInscripcion/" + inscripcionId,
                HttpMethod.GET,
                null,
                new ParameterizedTypeReference<List<Map<String, Object>>>() {}
            );
            
            if (historialResponse.getStatusCode() == HttpStatus.OK && historialResponse.getBody() != null) {
                model.addAttribute("historialAsistencias", historialResponse.getBody());
            }

            // Obtener estadísticas
            ResponseEntity<Map> estadisticasResponse = restTemplate.getForEntity(
                backendUrl + "/api/asistencia/contar-por-estado/" + inscripcionId,
                Map.class
            );
            
            if (estadisticasResponse.getStatusCode() == HttpStatus.OK && estadisticasResponse.getBody() != null) {
                model.addAttribute("estadisticas", estadisticasResponse.getBody());
            }

            model.addAttribute("inscripcionId", inscripcionId);
            model.addAttribute("nombre", user.getNombre());
            
            return "estudiante/historialAsistencia";
        } catch (Exception e) {
            model.addAttribute("error", "Error al cargar historial de asistencias");
            return "redirect:/estudiantes/asistencias";
        }
    }
}