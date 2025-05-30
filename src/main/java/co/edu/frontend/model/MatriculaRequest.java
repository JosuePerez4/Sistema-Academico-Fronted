package co.edu.frontend.model;

import java.util.List;

public class MatriculaRequest {
    private Long estudianteId;
    private Long semestreId;
    private List<Long> materias;

    public Long getEstudianteId() {
        return estudianteId;
    }

    public void setEstudianteId(Long estudianteId) {
        this.estudianteId = estudianteId;
    }

    public Long getSemestreId() {
        return semestreId;
    }

    public void setSemestreId(Long semestreId) {
        this.semestreId = semestreId;
    }

    public List<Long> getMaterias() {
        return materias;
    }

    public void setMaterias(List<Long> materias) {
        this.materias = materias;
    }
} 