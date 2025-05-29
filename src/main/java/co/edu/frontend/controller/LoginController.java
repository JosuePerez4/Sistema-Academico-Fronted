package co.edu.frontend.controller;

import co.edu.frontend.model.LoginRequest;
import co.edu.frontend.model.LoginResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.http.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;

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

        // Preparamos el objeto LoginRequest para enviar al microservicio
        LoginRequest loginRequest = new LoginRequest();
        loginRequest.setCorreo(correo);
        loginRequest.setContrasena(contrasena);

        // Creamos RestTemplate para la llamada HTTP
        RestTemplate restTemplate = new RestTemplate();

        // Preparamos los headers (Content-Type: application/json)
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        // Empaquetamos la petición
        HttpEntity<LoginRequest> requestEntity = new HttpEntity<>(loginRequest, headers);

        try {
            // Enviamos POST al microservicio
            ResponseEntity<LoginResponse> response = restTemplate.exchange(
                    AUTH_URL,
                    HttpMethod.POST,
                    requestEntity,
                    LoginResponse.class);

            // Si el microservicio responde OK (200)
            if (response.getStatusCode() == HttpStatus.OK) {
                LoginResponse usuario = response.getBody();

                session.setAttribute("usuario", usuario);

                return "redirect:/dashboard";
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

    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        LoginResponse user = (LoginResponse) session.getAttribute("usuario");
        if (user == null)
            return "redirect:/login";

        model.addAttribute("nombre", user.getNombre());
        model.addAttribute("correo", user.getCorreo());
        model.addAttribute("rol", user.getRol());
        return "dashboard";
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
}
