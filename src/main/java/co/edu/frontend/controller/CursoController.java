package co.edu.frontend.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import co.edu.frontend.model.Curso;
import org.springframework.http.*;
import org.springframework.web.client.RestTemplate;
import java.util.List;
import java.util.Arrays;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/cursos")
public class CursoController {
    
    private final String API_URL = "http://localhost:8081/api/cursos";
    private final RestTemplate restTemplate = new RestTemplate();

    @GetMapping
    public String listarCursos(Model model) {
        ResponseEntity<Curso[]> response = restTemplate.getForEntity(API_URL, Curso[].class);
        List<Curso> cursos = Arrays.asList(response.getBody());
        model.addAttribute("cursos", cursos);
        return "cursos/lista";
    }

    @GetMapping("/nuevo")
    public String mostrarFormularioNuevo(Model model) {
        model.addAttribute("curso", new Curso());
        return "cursos/formulario";
    }

    @PostMapping
    public String crearCurso(@ModelAttribute Curso curso) {
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        HttpEntity<Curso> request = new HttpEntity<>(curso, headers);
        
        restTemplate.postForObject(API_URL, request, Curso.class);
        return "redirect:/cursos";
    }

    @GetMapping("/editar/{id}")
    public String mostrarFormularioEditar(@PathVariable Long id, Model model) {
        Curso curso = restTemplate.getForObject(API_URL + "/{id}", Curso.class, id);
        model.addAttribute("curso", curso);
        return "cursos/formulario";
    }

    @PostMapping("/editar/{id}")
    public String actualizarCurso(@PathVariable Long id, @ModelAttribute Curso curso) {
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        HttpEntity<Curso> request = new HttpEntity<>(curso, headers);
        
        restTemplate.put(API_URL + "/{id}", request, id);
        return "redirect:/cursos";
    }

    @GetMapping("/eliminar/{id}")
    public String eliminarCurso(@PathVariable Long id) {
        restTemplate.delete(API_URL + "/{id}", id);
        return "redirect:/cursos";
    }

    @GetMapping("/inscribir/{id}")
    public String inscribirEnCurso(@PathVariable Long id, HttpSession session) {
        // Obtener el ID del estudiante de la sesión
        Long estudianteId = (Long) session.getAttribute("estudianteId");
        
        if (estudianteId == null) {
            return "redirect:/login";
        }

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        HttpEntity<?> request = new HttpEntity<>(headers);
        
        restTemplate.postForObject(
            API_URL + "/{cursoId}/inscribir/{estudianteId}", 
            request, 
            Void.class, 
            id, 
            estudianteId
        );
        
        return "redirect:/cursos";
    }

    @GetMapping("/cancelar/{id}")
    public String cancelarInscripcion(@PathVariable Long id, HttpSession session) {
        Long estudianteId = (Long) session.getAttribute("estudianteId");
        
        if (estudianteId == null) {
            return "redirect:/login";
        }

        restTemplate.delete(
            API_URL + "/{cursoId}/cancelar/{estudianteId}", 
            id, 
            estudianteId
        );
        
        return "redirect:/cursos";
    }
} 