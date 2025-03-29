package com.forgedevs.pololitos.models;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;

public class LoginUser {

    @NotBlank(message = "El correo es obligatorio")
    @Email(message = "Debes ingresar un correo válido")
    private String emailLogin;

    @NotBlank(message = "La contraseña es obligatoria")
    private String passwordLogin;

    public LoginUser() {}

    public String getEmailLogin() {
        return emailLogin;
    }

    public void setEmailLogin(String emailLogin) {
        this.emailLogin = emailLogin;
    }

    public String getPasswordLogin() {
        return passwordLogin;
    }

    public void setPasswordLogin(String passwordLogin) {
        this.passwordLogin = passwordLogin;
    }
}
