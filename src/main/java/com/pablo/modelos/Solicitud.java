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
import jakarta.validation.constraints.NotBlank;

@Entity
@Table(name="solicitudes")
public class Solicitud {

	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY) // AI (Auto-Increment)
    private Long id;

    // Usuario que solicita el servicio
    @ManyToOne
    @JoinColumn(name="solicitante_id", nullable=false)
    private Usuario solicitante;

    // Usuario que ofrece el servicio
    @ManyToOne
    @JoinColumn(name="proveedor_id", nullable=false)
    private Usuario proveedor;

    // Servicio solicitado
    @ManyToOne
    @JoinColumn(name="servicio_id", nullable=false)
    private Servicio servicio;

    @NotBlank(message="El estado de la solicitud es obligatorio")
    private String estado;

    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date fechaSolicitud = new Date(); 

    private String comentarioAdicional; 

    public Solicitud() {}
    
    @Column(updatable=false)
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date createdAt;
	
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date updatedAt;

	public Long getId() {
		return id;
	}

	public Usuario getSolicitante() {
		return solicitante;
	}

	public Usuario getProveedor() {
		return proveedor;
	}

	public Servicio getServicio() {
		return servicio;
	}

	public String getEstado() {
		return estado;
	}

	public Date getFechaSolicitud() {
		return fechaSolicitud;
	}

	public String getComentarioAdicional() {
		return comentarioAdicional;
	}

	public Date getCreatedAt() {
		return createdAt;
	}

	public Date getUpdatedAt() {
		return updatedAt;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public void setSolicitante(Usuario solicitante) {
		this.solicitante = solicitante;
	}

	public void setProveedor(Usuario proveedor) {
		this.proveedor = proveedor;
	}

	public void setServicio(Servicio servicio) {
		this.servicio = servicio;
	}

	public void setEstado(String estado) {
		this.estado = estado;
	}

	public void setFechaSolicitud(Date fechaSolicitud) {
		this.fechaSolicitud = fechaSolicitud;
	}

	public void setComentarioAdicional(String comentarioAdicional) {
		this.comentarioAdicional = comentarioAdicional;
	}

	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}

	public void setUpdatedAt(Date updatedAt) {
		this.updatedAt = updatedAt;
	}
}
