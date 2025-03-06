package com.pablo.modelos;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;

@Entity
@Table(name="usuarios")
public class Usuario {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY) //AI
	private Long id;
	
	@NotBlank(message="Por favor, proporciona tu nombre")
	@Size(min=3, message="El nombre debe tener al menos 3 caracteres")
	private String nombre;
	
	@NotBlank(message="Por favor, proporciona tu apellido")
	@Size(min=3, message="El apellido debe tener al menos 3 caracteres")
	private String apellido;
	
	@NotBlank(message="Por favor, ingresa un correo válido")
	@Email()
	private String email;
	
	@NotBlank(message="Por favor, ingresa una contraseña")
	@Size(min=8, message="La contraseña debe tener al menos 8 caracteres")
	@Pattern(regexp = "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z]).{8,}$", message = "La contraseña necesita incluir al menos una letra mayúscula, una letra minúscula y un número")
	private String password;
	
	@Transient 
	private String confirmacion;
	
	@Pattern(regexp = "^(https?|ftp)://.*\\.(jpg|jpeg|png)$", 
	         message = "La imagen debe ser un enlace válido y en formato JPG, JPEG o PNG")
	private String fotoPerfil;
	
	@Pattern(regexp = "\\d{10,15}", message="El número de teléfono debe contener entre 10 y 15 dígitos")
	private String telefono;

	private String direccion; // campo opcional
	
	@Column(updatable=false)
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date createdAt;
	
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date updatedAt;
	
	public Usuario() {}

	public Long getId() {
		return id;
	}

	public String getNombre() {
		return nombre;
	}

	public String getApellido() {
		return apellido;
	}

	public String getEmail() {
		return email;
	}

	public String getPassword() {
		return password;
	}

	public String getConfirmacion() {
		return confirmacion;
	}

	public String getFotoPerfil() {
		return fotoPerfil;
	}

	public String getTelefono() {
		return telefono;
	}

	public String getDireccion() {
		return direccion;
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

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public void setApellido(String apellido) {
		this.apellido = apellido;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public void setConfirmacion(String confirmacion) {
		this.confirmacion = confirmacion;
	}

	public void setFotoPerfil(String fotoPerfil) {
		this.fotoPerfil = fotoPerfil;
	}

	public void setTelefono(String telefono) {
		this.telefono = telefono;
	}

	public void setDireccion(String direccion) {
		this.direccion = direccion;
	}

	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}

	public void setUpdatedAt(Date updatedAt) {
		this.updatedAt = updatedAt;
	}
}
