package co.edu.frontend.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Arrays;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.http.ResponseEntity;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.RequestParam;

import co.edu.frontend.model.LoginResponse;
import jakarta.servlet.http.HttpSession;
import co.edu.frontend.model.CursoResponseDTO;
import co.edu.frontend.model.DocenteResponseDTO;
import co.edu.frontend.model.DocenteUpdateDTO;
import co.edu.frontend.model.RecursoResponseDTO;
import co.edu.frontend.model.EvaluacionCreateDTO;

@Controller
@RequestMapping("/profesor")
public class ProfesorController {

    @GetMapping("/dashboard")
    public String showDashboard(Model model) {
        // Datos del profesor
        model.addAttribute("profesor", new Profesor(123, "Juan Pérez", 4.36f));

        /*  Fecha actual formateada
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MMMM d, yyyy h:mm:ss a");
        model.addAttribute("fechaActual", LocalDateTime.now().format(formatter));
        */
        
        // Notificaciones
        model.addAttribute("notificacionesPendientes", 3);

        // Clase actual
        model.addAttribute("claseActual", new Clase(
                "Matemáticas Discretas",
                "SA402",
                "8:00 - 10:00 A.M",
                4.36f,
                "12 horas semanales"));

        // Calendario
        model.addAttribute("calendario", generarCalendario());

        // Progreso del semestre
        model.addAttribute("progresoSemestre", 75);

        return "dashboardprofesor";
    }

    @GetMapping("/ayuda")
    public String ayuda(Model model) {
        // Aquí deberías obtener el nombre real del profesor y la fecha actual
        model.addAttribute("nombre", "Profesor"); // Reemplaza por el nombre real si lo tienes
        model.addAttribute("fechaActual", java.time.LocalDate.now().toString());
        return "ayuda";
    }

    @GetMapping("/contacto")
    public String contacto(Model model) {
        Profesor profesor = new Profesor(123, "Juan Pérez", 4.36f); // Simula obtener el profesor real
        model.addAttribute("nombre", profesor.getNombre());
        model.addAttribute("fechaActual", java.time.LocalDate.now().toString());
        return "contacto";
    }

    @GetMapping("/ajustes")
    public String ajustes(Model model, HttpSession session) {
        LoginResponse user = (LoginResponse) session.getAttribute("usuario");
        if (user == null) {
            return "redirect:/login";
        }
        RestTemplate restTemplate = new RestTemplate();
        String url = "http://localhost:8081/docentes/ObtenerDocente/" + user.getId();
        try {
            DocenteResponseDTO docente = restTemplate.getForObject(url, DocenteResponseDTO.class);
            model.addAttribute("docente", docente);
        } catch (Exception e) {
            model.addAttribute("sinDatosDocente", true);
        }
        model.addAttribute("fechaActual", java.time.LocalDate.now().toString());
        return "ajustesprofesor";
    }

    @PostMapping("/ajustes/editar")
    public String editarAjustes(@ModelAttribute DocenteUpdateDTO docenteUpdateDTO, HttpSession session, Model model) {
        LoginResponse user = (LoginResponse) session.getAttribute("usuario");
        if (user == null) {
            return "redirect:/login";
        }
        RestTemplate restTemplate = new RestTemplate();
        String url = "http://localhost:8081/docentes/ActualizarDatosProfesionales/" + user.getId();
        restTemplate.put(url, docenteUpdateDTO);
        return "redirect:/profesor/ajustes";
    }

    @GetMapping("/clases")
    public String clases(Model model, HttpSession session) {
        LoginResponse user = (LoginResponse) session.getAttribute("usuario");
        if (user == null) {
            return "redirect:/login";
        }
        RestTemplate restTemplate = new RestTemplate();
        String url = "http://localhost:8081/api/cursos/listar/todos";
        ResponseEntity<CursoResponseDTO[]> response = restTemplate.exchange(
            url,
            HttpMethod.GET,
            new HttpEntity<>(new HttpHeaders()),
            CursoResponseDTO[].class
        );
        CursoResponseDTO[] cursos = response.getBody();
        // Filtrar cursos no asignados (simulando que docenteId == null o 0)
        // Si el backend no trae docenteId, aquí solo mostramos todos
        // Si sí lo trae, habría que ajustar el DTO y el filtro
        model.addAttribute("cursosDisponibles", Arrays.asList(cursos));
        model.addAttribute("nombre", user.getNombre());
        model.addAttribute("fechaActual", java.time.LocalDate.now().toString());
        return "clasesprofesor";
    }

    @GetMapping("/evaluaciones")
    public String evaluaciones(Model model, HttpSession session) {
        LoginResponse user = (LoginResponse) session.getAttribute("usuario");
        if (user == null) {
            return "redirect:/login";
        }
        RestTemplate restTemplate = new RestTemplate();
        // Obtener cursos asignados al profesor usando el nuevo endpoint
        String url = "http://localhost:8081/api/cursos/docente/" + user.getId();
        CursoResponseDTO[] cursos = restTemplate.getForObject(url, CursoResponseDTO[].class);
        model.addAttribute("cursosAsignados", cursos);
        model.addAttribute("nombre", user.getNombre());
        model.addAttribute("fechaActual", java.time.LocalDate.now().toString());
        model.addAttribute("evaluacionCreateDTO", new EvaluacionCreateDTO());
        return "evaluacionesprofesor";
    }

    @PostMapping("/evaluaciones/crear")
    public String crearEvaluacion(@ModelAttribute EvaluacionCreateDTO evaluacionCreateDTO, HttpSession session, Model model) {
        LoginResponse user = (LoginResponse) session.getAttribute("usuario");
        if (user == null) {
            return "redirect:/login";
        }
        RestTemplate restTemplate = new RestTemplate();
        String url = "http://localhost:8081/api/evaluaciones/crear";
        restTemplate.postForObject(url, evaluacionCreateDTO, String.class);
        return "redirect:/profesor/evaluaciones";
    }

    @GetMapping("/calificaciones")
    public String calificaciones(Model model) {
        Profesor profesor = new Profesor(123, "Juan Pérez", 4.36f); // Simula obtener el profesor real
        model.addAttribute("nombre", profesor.getNombre());
        model.addAttribute("fechaActual", java.time.LocalDate.now().toString());
        return "calificacionesprofesor";
    }

    @GetMapping("/recursos")
    public String recursos(HttpSession session, Model model) {
        LoginResponse user = (LoginResponse) session.getAttribute("usuario");
        if (user == null) {
            return "redirect:/login";
        }
        RestTemplate restTemplate = new RestTemplate();
        String url = "http://localhost:8081/api/recursos";
        RecursoResponseDTO[] recursos = restTemplate.getForObject(url, RecursoResponseDTO[].class);
        model.addAttribute("recursosDisponibles", recursos);
        model.addAttribute("nombre", user.getNombre());
        model.addAttribute("fechaActual", java.time.LocalDate.now().toString());
        model.addAttribute("usuarioId", user.getId());
        return "recursosprofesor";
    }

    @PostMapping("/asignar-curso")
    public String asignarCurso(@RequestParam("cursoId") Long cursoId,
                               @RequestParam("horasAsignadas") int horasAsignadas,
                               HttpSession session,
                               Model model) {
        LoginResponse user = (LoginResponse) session.getAttribute("usuario");
        if (user == null) {
            return "redirect:/login";
        }
        RestTemplate restTemplate = new RestTemplate();
        String url = "http://localhost:8081/api/asignacion";
        // Crear el DTO para la asignación
        java.util.Map<String, Object> asignacion = new java.util.HashMap<>();
        asignacion.put("docenteId", user.getId());
        asignacion.put("cursoId", cursoId);
        asignacion.put("horasAsignadas", horasAsignadas);
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        HttpEntity<java.util.Map<String, Object>> request = new HttpEntity<>(asignacion, headers);
        restTemplate.postForObject(url, request, String.class);
        // Redirigir de nuevo a la página de clases
        return "redirect:/profesor/clases";
    }

    private Calendario generarCalendario() {
        List<Semana> semanas = new ArrayList<>();

        // Semana 1
        List<Dia> semana1 = new ArrayList<>();
        semana1.add(new Dia(28, false, false, false));
        semana1.add(new Dia(29, false, false, false));
        semana1.add(new Dia(30, false, false, false));
        semana1.add(new Dia(1, false, false, true));
        semana1.add(new Dia(2, false, false, false));
        semana1.add(new Dia(3, false, true, false));
        semana1.add(new Dia(4, false, true, false));
        semanas.add(new Semana(semana1));

        // Semana 2
        List<Dia> semana2 = new ArrayList<>();
        semana2.add(new Dia(5, false, false, true));
        semana2.add(new Dia(6, false, false, false));
        semana2.add(new Dia(7, false, false, true));
        semana2.add(new Dia(8, false, false, false));
        semana2.add(new Dia(9, false, false, true));
        semana2.add(new Dia(10, false, true, false));
        semana2.add(new Dia(11, false, true, false));
        semanas.add(new Semana(semana2));

        return new Calendario(semanas);
    }

    // Clases internas con constructores y getters/setters
    public static class Profesor {
        private int id;
        private String nombre;
        private float calificacion;

        public Profesor(int id, String nombre, float calificacion) {
            this.id = id;
            this.nombre = nombre;
            this.calificacion = calificacion;
        }

        // Getters y Setters
        public int getId() {
            return id;
        }

        public String getNombre() {
            return nombre;
        }

        public float getCalificacion() {
            return calificacion;
        }

        public void setId(int id) {
            this.id = id;
        }

        public void setNombre(String nombre) {
            this.nombre = nombre;
        }

        public void setCalificacion(float calificacion) {
            this.calificacion = calificacion;
        }
    }

    public static class Clase {
        private String nombre;
        private String codigo;
        private String horario;
        private float intensidad;
        private String horasSemanales;

        public Clase(String nombre, String codigo, String horario, float intensidad, String horasSemanales) {
            this.nombre = nombre;
            this.codigo = codigo;
            this.horario = horario;
            this.intensidad = intensidad;
            this.horasSemanales = horasSemanales;
        }

        // Getters y Setters
        public String getNombre() {
            return nombre;
        }

        public String getCodigo() {
            return codigo;
        }

        public String getHorario() {
            return horario;
        }

        public float getIntensidad() {
            return intensidad;
        }

        public String getHorasSemanales() {
            return horasSemanales;
        }

        public void setNombre(String nombre) {
            this.nombre = nombre;
        }

        public void setCodigo(String codigo) {
            this.codigo = codigo;
        }

        public void setHorario(String horario) {
            this.horario = horario;
        }

        public void setIntensidad(float intensidad) {
            this.intensidad = intensidad;
        }

        public void setHorasSemanales(String horasSemanales) {
            this.horasSemanales = horasSemanales;
        }
    }

    public static class Calendario {
        private List<Semana> semanas;

        public Calendario(List<Semana> semanas) {
            this.semanas = semanas;
        }

        public List<Semana> getSemanas() {
            return semanas;
        }

        public void setSemanas(List<Semana> semanas) {
            this.semanas = semanas;
        }
    }

    public static class Semana {
        private List<Dia> dias;

        public Semana(List<Dia> dias) {
            this.dias = dias;
        }

        public List<Dia> getDias() {
            return dias;
        }

        public void setDias(List<Dia> dias) {
            this.dias = dias;
        }
    }

    public static class Dia {
        private int dia;
        private boolean esHoy;
        private boolean esFinDeSemana;
        private boolean tieneClase;

        public Dia(int dia, boolean esHoy, boolean esFinDeSemana, boolean tieneClase) {
            this.dia = dia;
            this.esHoy = esHoy;
            this.esFinDeSemana = esFinDeSemana;
            this.tieneClase = tieneClase;
        }

        // Getters y Setters
        public int getDia() {
            return dia;
        }

        public boolean isEsHoy() {
            return esHoy;
        }

        public boolean isEsFinDeSemana() {
            return esFinDeSemana;
        }

        public boolean isTieneClase() {
            return tieneClase;
        }

        public void setDia(int dia) {
            this.dia = dia;
        }

        public void setEsHoy(boolean esHoy) {
            this.esHoy = esHoy;
        }

        public void setEsFinDeSemana(boolean esFinDeSemana) {
            this.esFinDeSemana = esFinDeSemana;
        }

        public void setTieneClase(boolean tieneClase) {
            this.tieneClase = tieneClase;
        }
    }
}