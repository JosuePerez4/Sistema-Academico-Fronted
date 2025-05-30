package co.edu.frontend.controller;

import co.edu.frontend.model.LoginResponse;
import co.edu.frontend.model.MatriculaRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/matricula")
public class MatriculaController {
    
    @Value("${backend.api.url:http://localhost:8081}")
    private String backendUrl;
    
    private final RestTemplate restTemplate = new RestTemplate();

    @GetMapping("/matricula")
    public String mostrarFormularioMatricula(HttpSession session, Model model) {
        LoginResponse user = (LoginResponse) session.getAttribute("usuario");
        if (user == null) {
            return "redirect:/login";
        }

        try {
            // Obtener información del estudiante
            ResponseEntity<Map> estudianteResponse = restTemplate.getForEntity(
                backendUrl + "/estudiantes/" + user.getId(),
                Map.class
            );
            model.addAttribute("estudiante", estudianteResponse.getBody());

            // Obtener semestres disponibles
            ResponseEntity<List> semestresResponse = restTemplate.getForEntity(
                backendUrl + "/semestres/disponibles",
                List.class
            );
            model.addAttribute("semestresDisponibles", semestresResponse.getBody());

            // Obtener materias disponibles para el estudiante
            ResponseEntity<List> materiasResponse = restTemplate.getForEntity(
                backendUrl + "/materias/disponibles/" + user.getId(),
                List.class
            );
            model.addAttribute("materiasDisponibles", materiasResponse.getBody());

            return "matricula";
        } catch (Exception e) {
            model.addAttribute("error", "Error al cargar la información de matrícula");
            return "redirect:/dashboard";
        }
    }

    @PostMapping("/registrar")
    @ResponseBody
    public ResponseEntity<?> registrarMatricula(@RequestBody MatriculaRequest request, HttpSession session) {
        LoginResponse user = (LoginResponse) session.getAttribute("usuario");
        if (user == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                .body(Map.of("success", false, "mensaje", "Sesión no válida"));
        }

        try {
            request.setEstudianteId(user.getId());
            
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);
            HttpEntity<MatriculaRequest> requestEntity = new HttpEntity<>(request, headers);

            ResponseEntity<Map> response = restTemplate.exchange(
                backendUrl + "/matriculas/registrar",
                HttpMethod.POST,
                requestEntity,
                Map.class
            );

            return ResponseEntity.ok(response.getBody());
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                .body(Map.of("success", false, "mensaje", "Error al procesar la matrícula"));
        }
    }

    @GetMapping("/verificar/{materiaId}")
    @ResponseBody
    public ResponseEntity<?> verificarPrerequisitos(@PathVariable Long materiaId, HttpSession session) {
        LoginResponse user = (LoginResponse) session.getAttribute("usuario");
        if (user == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                .body(Map.of("success", false, "mensaje", "Sesión no válida"));
        }

        try {
            ResponseEntity<Map> response = restTemplate.getForEntity(
                backendUrl + "/materias/" + materiaId + "/prerequisitos/" + user.getId(),
                Map.class
            );
            return ResponseEntity.ok(response.getBody());
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                .body(Map.of("success", false, "mensaje", "Error al verificar prerequisitos"));
        }
    }
} 