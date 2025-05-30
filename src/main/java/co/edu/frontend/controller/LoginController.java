package co.edu.frontend.controller;

import co.edu.frontend.model.ForgotPasswordRequest;
import co.edu.frontend.model.LoginRequest;
import co.edu.frontend.model.LoginResponse;
import co.edu.frontend.model.ResetPasswordRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.http.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.ResourceAccessException;
import org.springframework.web.client.RestTemplate;
import java.util.Collections;

@Controller
public class LoginController {
    private final String AUTH_URL = "http://localhost:8081/usuarios/login";

    @GetMapping("/")
    public String home(Model model) {
        model.addAttribute("message", "Hello World!");
        return "home";
    }

    @GetMapping("/login")
    public String mostrarFormularioLogin(Model model) {
        return "login";
    }

    @PostMapping("/login")
    public String procesarLogin(@RequestParam String correo,
            @RequestParam String contrasena,
            HttpSession session,
            Model model) {

        LoginRequest loginRequest = new LoginRequest();
        loginRequest.setCorreo(correo);
        loginRequest.setContrasena(contrasena);

        RestTemplate restTemplate = new RestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        HttpEntity<LoginRequest> requestEntity = new HttpEntity<>(loginRequest, headers);

        try {
            ResponseEntity<LoginResponse> response = restTemplate.exchange(
                    AUTH_URL,
                    HttpMethod.POST,
                    requestEntity,
                    LoginResponse.class);

            if (response.getStatusCode() == HttpStatus.OK) {
                LoginResponse usuario = response.getBody();

                // Guardamos todos los datos relevantes en la sesión
                session.setAttribute("usuario", usuario);
                session.setAttribute("userId", usuario.getId());
                session.setAttribute("userRole", usuario.getRol());
                session.setAttribute("userEmail", usuario.getCorreo());
                session.setAttribute("userName", usuario.getNombre());

                // Redirigir según el rol del usuario
                String userRole = usuario.getRol().toLowerCase();
                System.out.println("Usuario autenticado - Rol: " + userRole + ", Nombre: " + usuario.getNombre());

                switch (userRole) {
                    case "admin":
                    case "administrador":
                        return "redirect:/admin/dashboard";
                    case "docente":
                    case "profesor":
                        return "redirect:/profesor/dashboard";
                    case "estudiante":
                        System.out.println("Redirigiendo a dashboard de estudiante");
                        return "redirect:/estudiantes/dashboard";
                    default:
                        System.out.println("Rol no reconocido: " + userRole);
                        return "redirect:/login";
                }
            } else {
                model.addAttribute("error", "Error al iniciar sesión. Intenta nuevamente.");
                return "login";
            }
        } catch (HttpClientErrorException.Unauthorized e) {
            model.addAttribute("error", "Correo o contraseña incorrectos.");
            return "login";
        } catch (Exception e) {
            model.addAttribute("error", "Error al contactar el servicio. Intenta más tarde.");
            return "login";
        }
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }

    @GetMapping("/forgot-password")
    public String mostrarFormularioRecuperarContrasena() {
        return "forgotPassword";
    }

    @PostMapping("/forgot-password")
    public String procesarRecuperarContrasena(@RequestParam String correo, Model model) {
        ForgotPasswordRequest forgotPasswordRequest = new ForgotPasswordRequest();
        forgotPasswordRequest.setCorreo(correo);

        // Configurar RestTemplate con timeout
        RestTemplate restTemplate = new RestTemplate();

        // Configurar headers completos
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));

        // Agregar headers de CORS si es necesario
        headers.add("Access-Control-Allow-Origin", "*");

        HttpEntity<ForgotPasswordRequest> requestEntity = new HttpEntity<>(forgotPasswordRequest, headers);
        String forgotPasswordUrl = "http://localhost:8081/api/auth/forgot-password";

        try {
            ResponseEntity<String> response = restTemplate.exchange(
                    forgotPasswordUrl,
                    HttpMethod.POST,
                    requestEntity,
                    String.class);

            if (response.getStatusCode() == HttpStatus.OK) {
                model.addAttribute("message", "Instrucciones de recuperación enviadas a " + correo);
                return "verifyEmail";
            } else {
                model.addAttribute("error",
                        "Error al enviar las instrucciones de recuperación. Código: " + response.getStatusCode());
                return "forgotPassword";
            }
        } catch (HttpClientErrorException e) {
            // Loguear el error completo
            System.err.println("Error detallado: " + e.getResponseBodyAsString());
            System.err.println("Status code: " + e.getStatusCode());

            String errorMessage = "Error " + e.getRawStatusCode() + ": ";
            if (e.getStatusCode() == HttpStatus.BAD_REQUEST) {
                errorMessage += "Correo no registrado o inválido.";
            } else if (e.getStatusCode() == HttpStatus.UNAUTHORIZED) {
                errorMessage += "No autorizado para realizar esta operación.";
            } else {
                errorMessage += "Error al procesar la solicitud.";
            }

            model.addAttribute("error", errorMessage);
            return "forgotPassword";
        } catch (ResourceAccessException e) {
            // Error de conexión
            System.err.println("Error de conexión: " + e.getMessage());
            model.addAttribute("error", "No se pudo conectar al servidor. Verifica que el servicio esté disponible.");
            return "forgotPassword";
        } catch (Exception e) {
            // Error general
            System.err.println("Error inesperado: " + e.getMessage());
            e.printStackTrace();
            model.addAttribute("error", "Error interno del servidor. Por favor, intenta más tarde.");
            return "forgotPassword";
        }
    }

    @GetMapping("/reset-password")
    public String mostrarFormularioResetPassword(@RequestParam(required = false) String token, Model model) {
        if (token == null || token.isEmpty()) {
            return "redirect:/login";
        }
        model.addAttribute("token", token);
        return "resetPassword";
    }

    @PostMapping("/reset-password")
    public String procesarResetPassword(@RequestParam String token,
            @RequestParam String newPassword,
            @RequestParam String confirmPassword,
            Model model) {
        if (!newPassword.equals(confirmPassword)) {
            model.addAttribute("error", "Las contraseñas no coinciden");
            model.addAttribute("token", token);
            return "resetPassword";
        }

        ResetPasswordRequest resetRequest = new ResetPasswordRequest();
        resetRequest.setToken(token);
        resetRequest.setNuevaContrasena(newPassword);

        RestTemplate restTemplate = new RestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));

        HttpEntity<ResetPasswordRequest> requestEntity = new HttpEntity<>(resetRequest, headers);
        String resetPasswordUrl = "http://localhost:8081/api/auth/reset-password";

        try {
            ResponseEntity<String> response = restTemplate.exchange(
                    resetPasswordUrl,
                    HttpMethod.POST,
                    requestEntity,
                    String.class);

            if (response.getStatusCode() == HttpStatus.OK) {
                model.addAttribute("message", "Contraseña actualizada exitosamente");
                return "redirect:/login";
            } else {
                model.addAttribute("error", "Error al actualizar la contraseña");
                model.addAttribute("token", token);
                return "resetPassword";
            }
        } catch (HttpClientErrorException e) {
            // Loguear el error completo
            System.err.println("Error detallado: " + e.getResponseBodyAsString());
            System.err.println("Status code: " + e.getStatusCode());

            String errorMessage;
            if (e.getStatusCode() == HttpStatus.BAD_REQUEST) {
                errorMessage = e.getResponseBodyAsString();
            } else {
                errorMessage = "Error al procesar la solicitud";
            }

            model.addAttribute("error", errorMessage);
            model.addAttribute("token", token);
            return "resetPassword";
        } catch (ResourceAccessException e) {
            // Error de conexión
            System.err.println("Error de conexión: " + e.getMessage());
            model.addAttribute("error", "No se pudo conectar al servidor. Verifica que el servicio esté disponible.");
            model.addAttribute("token", token);
            return "resetPassword";
        } catch (Exception e) {
            // Error general
            System.err.println("Error inesperado: " + e.getMessage());
            e.printStackTrace();
            model.addAttribute("error", "Error interno del servidor. Por favor, intenta más tarde.");
            model.addAttribute("token", token);
            return "resetPassword";
        }
    }

    // Métodos auxiliares para verificar roles
    private boolean isAdmin(String rol) {
        String rolLower = rol.toLowerCase();
        return rolLower.equals("admin") || rolLower.equals("administrador");
    }

    private boolean isProfesor(String rol) {
        String rolLower = rol.toLowerCase();
        return rolLower.equals("docente") || rolLower.equals("profesor");
    }

    private boolean isEstudiante(String rol) {
        return rol.toLowerCase().equals("estudiante");
    }
}