package com.pablo.modelos;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;

@Entity
@Table(name="resenas")
public class Resena {

	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY) // AI (Auto-Increment)
    private Long id;

    // Usuario que escribe la reseña
    @ManyToOne
    @JoinColumn(name="usuario_id", nullable=false)
    private Usuario usuario;

    // Servicio sobre el cual se deja la reseña
    @ManyToOne
    @JoinColumn(name="servicio_id", nullable=false)
    private Servicio servicio;

    @NotNull(message="La calificación es obligatoria")
    @Min(value=1, message="La calificación mínima es 1 estrella")
    @Max(value=5, message="La calificación máxima es 5 estrellas")
    private Integer calificacion;

    private String comentario; 

    // Constructor vacío
    public Resena() {}
    
    @Column(updatable=false)
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date createdAt;
	
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date updatedAt;

	public Long getId() {
		return id;
	}

	public Usuario getUsuario() {
		return usuario;
	}

	public Servicio getServicio() {
		return servicio;
	}

	public Integer getCalificacion() {
		return calificacion;
	}

	public String getComentario() {
		return comentario;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public void setUsuario(Usuario usuario) {
		this.usuario = usuario;
	}

	public void setServicio(Servicio servicio) {
		this.servicio = servicio;
	}

	public void setCalificacion(Integer calificacion) {
		this.calificacion = calificacion;
	}

	public void setComentario(String comentario) {
		this.comentario = comentario;
	}
}
