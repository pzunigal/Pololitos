package com.forgedevs.pololitos.models;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonIgnore;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;

@Entity
@Table(name = "users")
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotBlank(message = "Por favor, proporciona tu nombre")
    @Size(min = 3, message = "El nombre debe tener al menos 3 caracteres")
    private String firstName;

    @NotBlank(message = "Por favor, proporciona tu apellido")
    @Size(min = 3, message = "El apellido debe tener al menos 3 caracteres")
    private String lastName;

    @NotBlank(message = "Por favor, ingresa un correo válido")
    @Email
    private String email;

    @NotBlank(message = "Por favor, ingresa una contraseña")
    @Size(min = 8, message = "La contraseña debe tener al menos 8 caracteres")
    @Pattern(regexp = "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z]).{8,}$", message = "La contraseña necesita incluir al menos una letra mayúscula, una letra minúscula y un número")
    private String password;

    @Transient
    private String confirmation;

    @Column(name = "profile_picture")
    private String profileImage;

    @Transient
    private MultipartFile profileImageFile;

    @NotBlank(message = "Por favor, ingresa un teléfono válido")
    @Pattern(regexp = "\\d{9,15}", message = "El número de teléfono debe contener entre 9 y 15 dígitos")
    private String phone;

    @NotBlank(message = "Por favor, ingresa una ciudad")
    @Size(min = 3, message = "La ciudad debe tener al menos 3 caracteres")
    private String city;

    @OneToMany(mappedBy = "user", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    @JsonIgnore
    private List<OfferedService> offeredServices;

    @Column(updatable = false)
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date createdAt;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date updatedAt;

    public User() {
    }

    public User(Long id) {
        this.id = id;
    }

    // Getters
    public Long getId() {
        return id;
    }

    public String getFirstName() {
        return firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public String getEmail() {
        return email;
    }

    public String getPassword() {
        return password;
    }

    public String getConfirmation() {
        return confirmation;
    }

    public String getProfileImage() {
        return profileImage;
    }

    public MultipartFile getProfileImageFile() {
        return profileImageFile;
    }

    public String getPhone() {
        return phone;
    }

    public String getCity() {
        return city;
    }

    public List<OfferedService> getOfferedServices() {
        return offeredServices;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public Date getUpdatedAt() {
        return updatedAt;
    }

    // Setters
    public void setId(Long id) {
        this.id = id;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setConfirmation(String confirmation) {
        this.confirmation = confirmation;
    }

    public void setProfileImage(String profilePicture) {
        this.profileImage = profilePicture;
    }

    public void setProfileImageFile(MultipartFile profilePictureFile) {
        this.profileImageFile = profilePictureFile;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public void setOfferedServices(List<OfferedService> offeredServices) {
        this.offeredServices = offeredServices;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public void setUpdatedAt(Date updatedAt) {
        this.updatedAt = updatedAt;
    }
}
