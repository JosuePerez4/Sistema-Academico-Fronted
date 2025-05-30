package co.edu.frontend.model;

public class DocenteResponseDTO {
    private Long id;
    private String nombre;
    private String apellido;
    private String cedula;
    private String correo;
    private String especialidad;
    private int cargaHoraria;
    private String tituloProfesional;
    private String aniosExperiencia;
    private String tipoContrato;

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }
    public String getApellido() { return apellido; }
    public void setApellido(String apellido) { this.apellido = apellido; }
    public String getCedula() { return cedula; }
    public void setCedula(String cedula) { this.cedula = cedula; }
    public String getCorreo() { return correo; }
    public void setCorreo(String correo) { this.correo = correo; }
    public String getEspecialidad() { return especialidad; }
    public void setEspecialidad(String especialidad) { this.especialidad = especialidad; }
    public int getCargaHoraria() { return cargaHoraria; }
    public void setCargaHoraria(int cargaHoraria) { this.cargaHoraria = cargaHoraria; }
    public String getTituloProfesional() { return tituloProfesional; }
    public void setTituloProfesional(String tituloProfesional) { this.tituloProfesional = tituloProfesional; }
    public String getAniosExperiencia() { return aniosExperiencia; }
    public void setAniosExperiencia(String aniosExperiencia) { this.aniosExperiencia = aniosExperiencia; }
    public String getTipoContrato() { return tipoContrato; }
    public void setTipoContrato(String tipoContrato) { this.tipoContrato = tipoContrato; }
} 