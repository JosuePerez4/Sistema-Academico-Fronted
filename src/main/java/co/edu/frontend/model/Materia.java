package co.edu.frontend.model;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import jakarta.validation.constraints.*;

/**
 * Representa una materia en el sistema académico.
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Materia {
    private Long id;

    @NotBlank(message = "El nombre es obligatorio")
    @Size(min = 3, max = 100, message = "El nombre debe tener entre 3 y 100 caracteres")
    private String nombre;

    @NotBlank(message = "El código es obligatorio")
    @Pattern(regexp = "^[A-Z0-9]{3,10}$", message = "El código debe tener entre 3 y 10 caracteres alfanuméricos en mayúsculas")
    private String codigo;

    @Size(max = 500, message = "La descripción no puede exceder los 500 caracteres")
    private String descripcion;

    @NotNull(message = "Los créditos son obligatorios")
    @Min(value = 1, message = "Los créditos deben ser al menos 1")
    @Max(value = 10, message = "Los créditos no pueden ser más de 10")
    private Integer creditos;

    @NotBlank(message = "El departamento es obligatorio")
    private String departamento;

    @NotNull(message = "El nivel es obligatorio")
    @Min(value = 1, message = "El nivel debe ser al menos 1")
    @Max(value = 10, message = "El nivel no puede ser mayor a 10")
    private Integer nivel;

    private Boolean activa = true;

    @Size(max = 200, message = "Los prerequisitos no pueden exceder los 200 caracteres")
    private String prerequisitos;

    @Size(max = 200, message = "Los corequisitos no pueden exceder los 200 caracteres")
    private String corequisitos;

    // Métodos de utilidad
    public String getEstadoTexto() {
        return activa ? "Activa" : "Inactiva";
    }

    public String getNivelTexto() {
        return "Nivel " + nivel;
    }
} 