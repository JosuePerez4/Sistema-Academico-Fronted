package co.edu.frontend.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.http.*;
import org.springframework.web.client.RestTemplate;
import co.edu.frontend.model.Materia;
import java.util.List;
import java.util.Arrays;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/materias")
public class MateriaController {
    
    private final String API_URL = "http://localhost:8081/api/materias";
    private final RestTemplate restTemplate = new RestTemplate();

    @GetMapping
    public String listarMaterias(Model model) {
        try {
            ResponseEntity<Materia[]> response = restTemplate.getForEntity(API_URL, Materia[].class);
            List<Materia> materias = Arrays.asList(response.getBody());
            model.addAttribute("materias", materias);
            return "materias/lista";
        } catch (Exception e) {
            model.addAttribute("error", "Error al cargar las materias: " + e.getMessage());
            return "error";
        }
    }

    @GetMapping("/nuevo")
    public String mostrarFormularioNuevo(Model model) {
        model.addAttribute("materia", new Materia());
        return "materias/formulario";
    }

    @PostMapping
    public String crearMateria(@ModelAttribute Materia materia, Model model) {
        try {
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);
            HttpEntity<Materia> request = new HttpEntity<>(materia, headers);
            
            restTemplate.postForObject(API_URL, request, Materia.class);
            return "redirect:/materias";
        } catch (Exception e) {
            model.addAttribute("error", "Error al crear la materia: " + e.getMessage());
            return "error";
        }
    }

    @GetMapping("/editar/{id}")
    public String mostrarFormularioEditar(@PathVariable Long id, Model model) {
        try {
            Materia materia = restTemplate.getForObject(API_URL + "/{id}", Materia.class, id);
            model.addAttribute("materia", materia);
            return "materias/formulario";
        } catch (Exception e) {
            model.addAttribute("error", "Error al cargar la materia: " + e.getMessage());
            return "error";
        }
    }

    @PostMapping("/editar/{id}")
    public String actualizarMateria(@PathVariable Long id, @ModelAttribute Materia materia, Model model) {
        try {
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);
            HttpEntity<Materia> request = new HttpEntity<>(materia, headers);
            
            restTemplate.put(API_URL + "/{id}", request, id);
            return "redirect:/materias";
        } catch (Exception e) {
            model.addAttribute("error", "Error al actualizar la materia: " + e.getMessage());
            return "error";
        }
    }

    @GetMapping("/eliminar/{id}")
    public String eliminarMateria(@PathVariable Long id, Model model) {
        try {
            restTemplate.delete(API_URL + "/{id}", id);
            return "redirect:/materias";
        } catch (Exception e) {
            model.addAttribute("error", "Error al eliminar la materia: " + e.getMessage());
            return "error";
        }
    }

    @GetMapping("/detalles/{id}")
    @ResponseBody
    public ResponseEntity<?> obtenerDetalles(@PathVariable Long id) {
        try {
            Materia materia = restTemplate.getForObject(API_URL + "/{id}", Materia.class, id);
            return ResponseEntity.ok(materia);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                .body(new ErrorResponse("Error al obtener los detalles de la materia: " + e.getMessage()));
        }
    }
}

class ErrorResponse {
    private String message;

    public ErrorResponse(String message) {
        this.message = message;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
} 