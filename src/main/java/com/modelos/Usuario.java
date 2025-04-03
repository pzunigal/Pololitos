package com.modelos;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;

@Entity
@Table(name = "usuarios")
public class Usuario {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotBlank(message = "Por favor, proporciona tu nombre")
    @Size(min = 3, message = "El nombre debe tener al menos 3 caracteres")
    private String nombre;

    @NotBlank(message = "Por favor, proporciona tu apellido")
    @Size(min = 3, message = "El apellido debe tener al menos 3 caracteres")
    private String apellido;

    @NotBlank(message = "Por favor, ingresa un correo válido")
    @Email()
    private String email;

    @NotBlank(message = "Por favor, ingresa una contraseña")
    @Size(min = 8, message = "La contraseña debe tener al menos 8 caracteres")
    @Pattern(regexp = "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z]).{8,}$", message = "La contraseña necesita incluir al menos una letra mayúscula, una letra minúscula y un número")
    private String password;

    @Transient
    private String confirmacion;

    @Column(name = "foto_perfil")
    private String fotoPerfil; // URL de la imagen subida

    @Transient
    private MultipartFile fotoPerfilArchivo; // archivo subido en el formulario

    @NotBlank(message = "Por favor, ingresa un teléfono válido")
    @Pattern(regexp = "\\d{9,15}", message = "El número de teléfono debe contener entre 9 y 15 dígitos")
    private String telefono;

    @NotBlank(message = "Por favor, ingresa una ciudad")
    @Size(min = 3, message = "La ciudad debe tener al menos 3 caracteres")
    private String ciudad;

    // Relación con servicios ofrecidos
    @OneToMany(mappedBy = "usuario", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    private List<Servicio> serviciosOfrecidos;

    @Column(updatable = false)
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date createdAt;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date updatedAt;

    public Usuario() {
    }

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

    public String getCiudad() {
        return ciudad;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public Date getUpdatedAt() {
        return updatedAt;
    }

    public List<Servicio> getServiciosOfrecidos() {
        return serviciosOfrecidos;
    }

    public void setServiciosOfrecidos(List<Servicio> serviciosOfrecidos) {
        this.serviciosOfrecidos = serviciosOfrecidos;
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

    public void setCiudad(String ciudad) {
        this.ciudad = ciudad;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public void setUpdatedAt(Date updatedAt) {
        this.updatedAt = updatedAt;
    }
    public MultipartFile getFotoPerfilArchivo() {
        return fotoPerfilArchivo;
    }
    
    public void setFotoPerfilArchivo(MultipartFile fotoPerfilArchivo) {
        this.fotoPerfilArchivo = fotoPerfilArchivo;
    }
    
}
