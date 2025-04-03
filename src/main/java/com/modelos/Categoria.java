package com.modelos;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

@Entity
@Table(name="categorias")
public class Categoria {
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY) // AI (Auto-Increment)
    private Long id;

    @NotBlank(message="El nombre de la categoría es obligatorio")
    @Size(min=3, max=255, message="El nombre debe tener entre 3 y 50 caracteres")
    private String nombre;

    // Relación con Servicio (Una categoría puede tener muchos servicios)
    @OneToMany(mappedBy = "categoria", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Servicio> servicios;

    public Categoria() {}
    
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

	public List<Servicio> getServicios() {
		return servicios;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public void setServicios(List<Servicio> servicios) {
		this.servicios = servicios;
	}
}
