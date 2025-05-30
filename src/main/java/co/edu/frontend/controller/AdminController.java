package co.edu.frontend.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import co.edu.frontend.model.Curso;
import co.edu.frontend.model.LoginResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import java.time.format.DateTimeFormatter;
import java.time.LocalDateTime;
import java.util.Arrays;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @GetMapping("/dashboard")
    public String showDashboard(HttpSession session, Model model) {
        // Crear usuario predeterminado si no hay sesión
        LoginResponse user = (LoginResponse) session.getAttribute("usuario");
        if (user == null) {
            user = new LoginResponse();
            user.setNombre("Administrador Demo");
            user.setCorreo("admin@ufps.edu.co");
            user.setRol("admin");
            session.setAttribute("usuario", user);
        }

        // Fecha actual formateada
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MMMM d, yyyy h:mm:ss a");
        model.addAttribute("fechaActual", LocalDateTime.now().format(formatter));
        
        // Datos del administrador
        model.addAttribute("nombre", user.getNombre());
        model.addAttribute("correo", user.getCorreo());
        model.addAttribute("notificacionesPendientes", 5);

        // Estadísticas del sistema
        model.addAttribute("totalCursos", 45);
        model.addAttribute("totalProfesores", 28);
        model.addAttribute("totalEstudiantes", 850);

        // Cursos recientes
        model.addAttribute("cursosRecientes", generarCursosRecientes());
        
        // Actividades recientes
        model.addAttribute("actividadesRecientes", generarActividadesRecientes());
        
        return "dashboardadmin";
    }

    private List<Curso> generarCursosRecientes() {
        List<Curso> cursos = new ArrayList<>();
        
        Curso curso1 = new Curso();
        curso1.setId(1L);
        curso1.setNombre("Cálculo Diferencial");
        curso1.setCodigo("MAT101");
        curso1.setDescripcion("Fundamentos de cálculo");
        curso1.setObjetivos("Comprender límites y derivadas");
        curso1.setCompetencias("Pensamiento matemático");
        curso1.setCuposDisponibles(30);
        curso1.setHorario("Lunes y Miércoles 8:00-10:00");
        curso1.setProfesor("Dr. Juan Pérez");
        curso1.setPeriodoAcademico(20241);
        curso1.setActivo(true);
        curso1.setPrerrequisitos(Arrays.asList("Matemáticas Básicas"));
        
        Curso curso2 = new Curso();
        curso2.setId(2L);
        curso2.setNombre("Programación I");
        curso2.setCodigo("CSC202");
        curso2.setDescripcion("Fundamentos de programación");
        curso2.setObjetivos("Aprender lógica de programación");
        curso2.setCompetencias("Desarrollo de software");
        curso2.setCuposDisponibles(25);
        curso2.setHorario("Martes y Jueves 10:00-12:00");
        curso2.setProfesor("Ing. María Rodríguez");
        curso2.setPeriodoAcademico(20241);
        curso2.setActivo(true);
        curso2.setPrerrequisitos(new ArrayList<>());
        
        cursos.add(curso1);
        cursos.add(curso2);
        return cursos;
    }

    private List<ActividadReciente> generarActividadesRecientes() {
        List<ActividadReciente> actividades = new ArrayList<>();
        actividades.add(new ActividadReciente("Nuevo curso creado", "Hace 2 horas", "plus-circle"));
        actividades.add(new ActividadReciente("Horario modificado", "Hace 3 horas", "edit"));
        actividades.add(new ActividadReciente("Nueva inscripción", "Hace 5 horas", "user-plus"));
        return actividades;
    }

    // Clase interna para manejar actividades recientes
    public static class ActividadReciente {
        private String titulo;
        private String tiempo;
        private String icono;

        public ActividadReciente(String titulo, String tiempo, String icono) {
            this.titulo = titulo;
            this.tiempo = tiempo;
            this.icono = icono;
        }

        public String getTitulo() { return titulo; }
        public String getTiempo() { return tiempo; }
        public String getIcono() { return icono; }
    }
} 