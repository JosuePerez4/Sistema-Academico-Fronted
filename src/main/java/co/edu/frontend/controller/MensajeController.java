package co.edu.frontend.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import co.edu.frontend.controller.ProfesorController.Profesor; // Asegúrate de que esta importación sea correcta

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Locale;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/mensajes") // Mapea todas las URLs bajo /mensajes
public class MensajeController {

    // --- Clases Internas Temporales (simulando modelos de datos) ---
    // En un sistema real, estas serían clases de dominio o DTOs en su propio paquete.

    public static class Conversacion {
        private int id;
        private String asunto;
        private String participante; // Con quién es la conversación
        private String preview; // Vista previa del último mensaje
        private String ultimaFecha;
        private boolean leido;
        private List<Mensaje> mensajes; // Los mensajes dentro de esta conversación

        public Conversacion(int id, String asunto, String participante, String preview, String ultimaFecha, boolean leido, List<Mensaje> mensajes) {
            this.id = id;
            this.asunto = asunto;
            this.participante = participante;
            this.preview = preview;
            this.ultimaFecha = ultimaFecha;
            this.leido = leido;
            this.mensajes = mensajes;
        }

        // Getters
        public int getId() { return id; }
        public String getAsunto() { return asunto; }
        public String getParticipante() { return participante; }
        public String getPreview() { return preview; }
        public String getUltimaFecha() { return ultimaFecha; }
        public boolean isLeido() { return leido; }
        public List<Mensaje> getMensajes() { return mensajes; }

        // Setters (pueden ser necesarios si se usa @ModelAttribute para formularios)
        public void setId(int id) { this.id = id; }
        public void setAsunto(String asunto) { this.asunto = asunto; }
        public void setParticipante(String participante) { this.participante = participante; }
        public void setPreview(String preview) { this.preview = preview; }
        public void setUltimaFecha(String ultimaFecha) { this.ultimaFecha = ultimaFecha; }
        public void setLeido(boolean leido) { this.leido = leido; }
        public void setMensajes(List<Mensaje> mensajes) { this.mensajes = mensajes; }
    }

    public static class Mensaje {
        private int id;
        private String remitente;
        private String contenido;
        private String fechaHora;
        private boolean esEnviadoPorMi; // true si el mensaje fue enviado por el usuario actual

        public Mensaje(int id, String remitente, String contenido, String fechaHora, boolean esEnviadoPorMi) {
            this.id = id;
            this.remitente = remitente;
            this.contenido = contenido;
            this.fechaHora = fechaHora;
            this.esEnviadoPorMi = esEnviadoPorMi;
        }

        // Getters
        public int getId() { return id; }
        public String getRemitente() { return remitente; }
        public String getContenido() { return contenido; }
        public String getFechaHora() { return fechaHora; }
        public boolean isEsEnviadoPorMi() { return esEnviadoPorMi; }

        // Setters
        public void setId(int id) { this.id = id; }
        public void setRemitente(String remitente) { this.remitente = remitente; }
        public void setContenido(String contenido) { this.contenido = contenido; }
        public void setFechaHora(String fechaHora) { this.fechaHora = fechaHora; }
        public void setEsEnviadoPorMi(boolean esEnviadoPorMi) { this.esEnviadoPorMi = esEnviadoPorMi; }
    }

    public static class Anuncio {
        private String titulo;
        private String cuerpo;
        private String fecha;
        private String autor;
        private boolean isNew;

        public Anuncio(String titulo, String cuerpo, String fecha, String autor, boolean isNew) {
            this.titulo = titulo;
            this.cuerpo = cuerpo;
            this.fecha = fecha;
            this.autor = autor;
            this.isNew = isNew;
        }

        public String getTitulo() { return titulo; }
        public String getCuerpo() { return cuerpo; }
        public String getFecha() { return fecha; }
        public String getAutor() { return autor; }
        public boolean isNew() { return isNew; }
    }
    // --- Fin Clases Internas Temporales ---


    // --- ALMACENAMIENTO SIMULADO DE CONVERSACIONES ---
    // En un sistema real, esto sería una base de datos o un servicio.
    // Usamos una lista de instancia para que los mensajes se mantengan durante la ejecución de la aplicación.
    private List<Conversacion> conversacionesSimuladas;

    public MensajeController() {
        // Inicializa las conversaciones simuladas al crear el controlador
        conversacionesSimuladas = new ArrayList<>();
        conversacionesSimuladas.add(new Conversacion(
                1,
                "Consulta de Notas",
                "Profesor García",
                "Hola, tengo una pregunta sobre mi calificación en el...",
                "28 May 2025",
                true, // Ya leído
                new ArrayList<>(Arrays.asList( // Usar ArrayList para poder añadir mensajes
                    new Mensaje(101, "Profesor García", "Hola, tengo una pregunta sobre mi calificación en el último examen de Álgebra Lineal. ¿Podría revisarlo?", "28 May 2025 10:00 AM", false),
                    new Mensaje(102, "Juan Pérez", "Claro, enviaré un correo detallado con la revisión. Saludos.", "28 May 2025 10:15 AM", true)
                ))
        ));
        conversacionesSimuladas.add(new Conversacion(
                2,
                "Aviso Importante",
                "Departamento Académico",
                "Recordatorio: el plazo para la inscripción de...",
                "27 May 2025",
                false, // No leído
                new ArrayList<>(Arrays.asList(
                    new Mensaje(201, "Departamento Académico", "Estimados estudiantes, se les recuerda que el plazo para la inscripción de cursos finaliza el 5 de junio. Favor de completar el proceso a la brevedad.", "27 May 2025 09:30 AM", false)
                ))
        ));
        conversacionesSimuladas.add(new Conversacion(
                3,
                "Dudas Tarea Final",
                "Estudiante López",
                "Estimado profesor, quisiera consultarle sobre los...",
                "26 May 2025",
                true,
                new ArrayList<>(Arrays.asList(
                    new Mensaje(301, "Estudiante López", "Estimado profesor, quisiera consultarle sobre los requisitos para la tarea final de Lógica de Programación. ¿Podría aclarar algunos puntos?", "26 May 2025 03:00 PM", false),
                    new Mensaje(302, "Juan Pérez", "Hola. Puedes revisar la guía publicada en el campus virtual. Si persisten las dudas, nos vemos en la tutoría del jueves.", "26 May 2025 03:10 PM", true),
                    new Mensaje(303, "Estudiante López", "Gracias, profesor. Revisaré la guía.", "26 May 2025 03:15 PM", false)
                ))
        ));
    }


    // --- Métodos de Controlador ---

    // Dashboard principal de Mensajes y Notificaciones
    @GetMapping
    public String showMensajesDashboard(Model model) {
        addCommonAttributes(model);
        return "mensajes";
    }

    // Mensajería Interna (lista de conversaciones)
    @GetMapping("/interna")
    public String showMensajeriaInterna(Model model) {
        addCommonAttributes(model);
        model.addAttribute("conversaciones", conversacionesSimuladas); // Usa la lista simulada
        return "mensajeriaInterna";
    }

    // *** ESTE ES EL MÉTODO CLAVE PARA EL BOTÓN "NUEVO MENSAJE" ***
    @GetMapping("/nuevo")
    public String showNuevoMensajeForm(Model model) {
        addCommonAttributes(model);
        System.out.println("DEBUG: Accediendo a /mensajes/nuevo. Redirigiendo a nuevoMensaje.jsp"); // Debug
        return "nuevoMensaje"; // Retorna el nombre de la vista (nuevoMensaje.jsp)
    }

    // Procesar el envío de un nuevo mensaje (simulado)
    @PostMapping("/enviar")
    public String enviarNuevoMensaje(
            @RequestParam("to") String to,
            @RequestParam("subject") String subject,
            @RequestParam("content") String content,
            RedirectAttributes redirectAttributes) {

        // Simulación de creación y adición de una nueva conversación/mensaje
        int newConvId = conversacionesSimuladas.isEmpty() ? 1 : conversacionesSimuladas.stream().mapToInt(Conversacion::getId).max().orElse(0) + 1;
        String currentDateTime = LocalDateTime.now().format(DateTimeFormatter.ofPattern("dd MMM yyyy HH:mm", new Locale("es", "ES")));

        Mensaje nuevoMensaje = new Mensaje(1, "Juan Pérez", content, currentDateTime, true); // Asumiendo que Juan Pérez es el remitente
        Conversacion nuevaConversacion = new Conversacion(
                newConvId,
                subject,
                to, // El destinatario es el "participante" en esta simulación
                content.substring(0, Math.min(content.length(), 50)) + (content.length() > 50 ? "..." : ""),
                currentDateTime.split(" ")[0] + " " + currentDateTime.split(" ")[1] + " " + currentDateTime.split(" ")[2], // Solo fecha para preview
                false, // Marca como no leído para el destinatario (simulado)
                new ArrayList<>(Arrays.asList(nuevoMensaje))
        );
        conversacionesSimuladas.add(0, nuevaConversacion); // Añade al principio para que se vea primero

        System.out.println("Mensaje Enviado Exitosamente.");
        redirectAttributes.addFlashAttribute("successMessage", "Mensaje enviado exitosamente.");
        return "redirect:/mensajes/interna"; // Redirige para evitar reenvío de formulario
    }

    // Ver una conversación específica
    @GetMapping("/conversacion/{id}")
    public String verConversacion(@PathVariable("id") int conversacionId, Model model) {
        addCommonAttributes(model);

        Conversacion conversacion = findConversacionById(conversacionId);

        if (conversacion == null) {
            System.out.println("DEBUG: Conversación con ID " + conversacionId + " no encontrada."); // Debug
            return "redirect:/mensajes/interna"; // Redirige si no se encuentra
        }
        System.out.println("DEBUG: Mostrando conversación con ID: " + conversacionId); // Debug
        model.addAttribute("conversacion", conversacion);
        return "verConversacion";
    }

    // Nuevo método para mostrar el formulario de respuesta para una conversación existente
    @GetMapping("/responder-form/{id}")
    public String showResponderMensajeForm(@PathVariable("id") int conversacionId, Model model) {
        addCommonAttributes(model);
        Conversacion conversacion = findConversacionById(conversacionId);

        if (conversacion == null) {
            System.out.println("DEBUG: Conversación para responder con ID " + conversacionId + " no encontrada."); // Debug
            return "redirect:/mensajes/interna";
        }
        System.out.println("DEBUG: Mostrando formulario de respuesta para conversación ID: " + conversacionId); // Debug
        model.addAttribute("conversacion", conversacion); // Pasa la conversación para pre-rellenar datos
        return "responderMensaje"; // Retorna el nuevo JSP
    }

    // Procesar el envío de una respuesta a una conversación específica
    @PostMapping("/enviar-respuesta/{id}")
    public String enviarRespuesta(
            @PathVariable("id") int conversacionId,
            @RequestParam("replyContent") String replyContent,
            RedirectAttributes redirectAttributes) {

        Conversacion conversacion = findConversacionById(conversacionId);

        if (conversacion == null) {
            redirectAttributes.addFlashAttribute("errorMessage", "Conversación no encontrada.");
            return "redirect:/mensajes/interna";
        }

        // Simulación: Añadir el nuevo mensaje a la conversación
        String currentDateTime = LocalDateTime.now().format(DateTimeFormatter.ofPattern("dd MMM yyyy HH:mm", new Locale("es", "ES")));
        int newMsgId = conversacion.getMensajes().isEmpty() ? 1 : conversacion.getMensajes().stream().mapToInt(Mensaje::getId).max().orElse(0) + 1;

        // Asumiendo que el usuario logueado es "Juan Pérez"
        Mensaje nuevaRespuesta = new Mensaje(newMsgId, "Juan Pérez", replyContent, currentDateTime, true);
        conversacion.getMensajes().add(nuevaRespuesta);

        // Actualizar el preview y la última fecha de la conversación (simulado)
        conversacion.setPreview(replyContent.substring(0, Math.min(replyContent.length(), 50)) + (replyContent.length() > 50 ? "..." : ""));
        conversacion.setUltimaFecha(currentDateTime.split(" ")[0] + " " + currentDateTime.split(" ")[1] + " " + currentDateTime.split(" ")[2]);
        conversacion.setLeido(false); // Marca la conversación como no leída para el otro participante (simulado)

        System.out.println("Respuesta enviada a conversación ID: " + conversacionId);
        redirectAttributes.addFlashAttribute("successMessage", "Respuesta enviada exitosamente.");
        return "redirect:/mensajes/conversacion/" + conversacionId; // Redirige de nuevo a la conversación
    }


    // Método para Alertas y Anuncios
    @GetMapping("/alertas")
    public String showAlertasAnuncios(Model model) {
        addCommonAttributes(model);

        // Simulando una lista de anuncios
        List<Anuncio> anuncios = new ArrayList<>();
        anuncios.add(new Anuncio(
                "Mantenimiento Programado del Sistema",
                "Se informa a toda la comunidad académica que se realizará un mantenimiento programado del sistema el 30 de mayo de 2025 de 10:00 PM a 2:00 AM. Agradecemos su comprensión.",
                "29 de mayo de 2025",
                "Administración",
                false
        ));
        anuncios.add(new Anuncio(
                "Nueva Política de Evaluación Docente",
                "Se ha publicado la nueva política de evaluación docente, disponible para su consulta en la sección de 'Documentos'.",
                "28 de mayo de 2025",
                "Dirección Académica",
                true
        ));
        anuncios.add(new Anuncio(
                "Convocatoria a Curso de Actualización",
                "Invitamos a todos los docentes a participar en el curso de actualización en metodologías de enseñanza innovadoras.",
                "25 de mayo de 2025",
                "Decanatura de Facultad",
                false
        ));
        model.addAttribute("anuncios", anuncios);
        return "alertasAnuncios";
    }

    // --- Métodos de Ayuda ---

    // Método auxiliar para añadir atributos comunes a todas las vistas
    private void addCommonAttributes(Model model) {
        model.addAttribute("profesor", new Profesor(123, "Juan Pérez", 4.36f)); // Profesor simulado
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("EEEE, MMMM d, yyyy", new Locale("es", "ES")); // Cambiado para que el año siempre salga
        model.addAttribute("fechaActual", LocalDate.now().format(formatter));
        model.addAttribute("notificacionesPendientes", 3); // Notificaciones simuladas
    }

    // Método auxiliar para simular la búsqueda de una conversación por ID
    private Conversacion findConversacionById(int id) {
        // Busca en la lista de conversacionesSimuladas global.
        return conversacionesSimuladas.stream()
                .filter(conv -> conv.getId() == id)
                .findFirst()
                .orElse(null);
    }
}