package co.edu.frontend.model;

import java.util.List;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Curso {
    private Long id;
    private String nombre;
    private String codigo;
    private String descripcion;
    private String objetivos;
    private String competencias;
    private Integer cuposDisponibles;
    private String horario;
    private List<String> prerrequisitos;
    private Boolean activo;
    private String profesor;
    private Integer periodoAcademico;
} 