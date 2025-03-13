package com.modelos;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Positive;
import jakarta.validation.constraints.Size;

@Entity
@Table(name="servicios")
public class Servicio {

	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotBlank(message="El nombre del servicio es obligatorio")
    @Size(min=3, max=100, message="El nombre debe tener entre 3 y 100 caracteres")
    private String nombre;

    @NotBlank(message="La descripción del servicio es obligatoria")
    @Size(min=10, message="La descripción debe tener al menos 10 caracteres")
    private String descripcion;

    @NotNull(message="Debe especificar un precio")
    @Positive(message="El precio debe ser mayor a 0")
    private Double precio;

	@NotBlank(message="La ciudad es obligatoria")
    @Size(min=3, max=100, message="La ciudad debe tener entre 3 y 30 caracteres")
    private String ciudad;

    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date fechaPublicacion = new Date();

	@Pattern(regexp = "^(https?|ftp)://.*\\.(jpg|jpeg|png)$", 
			 message = "La imagen debe ser un enlace válido y en formato JPG, JPEG o PNG")
	private String fotoServicio;

	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="usuario_id") 
	private Usuario creador;

    // Relación con Usuario (Un usuario puede publicar muchos servicios)
    @ManyToOne
    @JoinColumn(name="usuario_id", nullable=false)
    private Usuario usuario;

    // Relación con Categoría (Un servicio pertenece a una categoría)
    @ManyToOne
    @JoinColumn(name="categoria_id", nullable=false)
    private Categoria categoria;

    public Servicio() {}
    
    @Column(updatable=false)
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date createdAt;
	
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date updatedAt;

	public Long getId() {
		return id;
	}

	public String getNombre() {
		return nombre;
	}

	public String getDescripcion() {
		return descripcion;
	}

	public Double getPrecio() {
		return precio;
	}

	public String getUbicacion() {
		return ciudad;
	}

	public Date getFechaPublicacion() {
		return fechaPublicacion;
	}

	public Usuario getUsuario() {
		return usuario;
	}

	public Categoria getCategoria() {
		return categoria;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}

	public void setPrecio(Double precio) {
		this.precio = precio;
	}

	public void setUbicacion(String ubicacion) {
		this.ciudad = ubicacion;
	}

	public void setFechaPublicacion(Date fechaPublicacion) {
		this.fechaPublicacion = fechaPublicacion;
	}

	public void setUsuario(Usuario usuario) {
		this.usuario = usuario;
	}

	public void setCategoria(Categoria categoria) {
		this.categoria = categoria;
	}

	public String getFotoServicio() {
		return fotoServicio;
	}

	public void setFotoServicio(String fotoServicio) {
		this.fotoServicio = fotoServicio;
	}
}
