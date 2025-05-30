package co.edu.frontend.controller;

import co.edu.frontend.model.EstudianteRequestDTO;
import co.edu.frontend.model.EstudianteUpdateDTO;
import org.springframework.http.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.ResourceAccessException;
import org.springframework.web.client.RestTemplate;
import java.util.Collections;

@Controller
@RequestMapping("/estudiantes")
public class EstudianteController {
    private final String API_URL = "http://localhost:8081/api/estudiante";

    @GetMapping("/registro")
    public String mostrarFormularioRegistro(Model model) {
        return "registroEstudiante";
    }

    @GetMapping("/actualizar/{codigo}")
    public String mostrarFormularioActualizacion(@PathVariable String codigo, Model model) {
        RestTemplate restTemplate = new RestTemplate();
        try {
            // Primero verificamos si existe el estudiante
            ResponseEntity<EstudianteRequestDTO> response = restTemplate.getForEntity(
                    API_URL + "/codigo/" + codigo,
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
        RestTemplate restTemplate = new RestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));

        HttpEntity<EstudianteUpdateDTO> requestEntity = new HttpEntity<>(estudiante, headers);

        try {
            ResponseEntity<String> response = restTemplate.exchange(
                    API_URL + "/actualizar/" + codigo,
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
        RestTemplate restTemplate = new RestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));

        HttpEntity<EstudianteRequestDTO> requestEntity = new HttpEntity<>(estudiante, headers);

        try {
            ResponseEntity<String> response = restTemplate.exchange(
                    API_URL + "/registrar",
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
}