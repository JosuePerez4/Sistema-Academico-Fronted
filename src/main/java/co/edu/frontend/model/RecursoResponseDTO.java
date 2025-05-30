package co.edu.frontend.model;

public class RecursoResponseDTO {
    private Long id;
    private String nombre;
    private String tipo;
    private String descripcion;
    private boolean disponible;
    private String estado;

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }
    public String getTipo() { return tipo; }
    public void setTipo(String tipo) { this.tipo = tipo; }
    public String getDescripcion() { return descripcion; }
    public void setDescripcion(String descripcion) { this.descripcion = descripcion; }
    public boolean isDisponible() { return disponible; }
    public void setDisponible(boolean disponible) { this.disponible = disponible; }
    public String getEstado() { return estado; }
    public void setEstado(String estado) { this.estado = estado; }
} 