package com.forgedevs.pololitos.responses;

public class LoginUserResponse {

    private String email;
    private String firstName;
    private String lastName;
    private String profileImage;
    private String phone;
    private String city;
    private String token;  // Agregamos el campo token

    // Constructor para enviar los datos relevantes, incluyendo el token
    public LoginUserResponse(String email, String firstName, String lastName, String profileImage, String phone, String city, String token) {
        this.email = email;
        this.firstName = firstName;
        this.lastName = lastName;
        this.profileImage = profileImage;
        this.phone = phone;
        this.city = city;
        this.token = token;  // Asignamos el token al campo
    }

    // Getters
    public String getEmail() {
        return email;
    }

    public String getFirstName() {
        return firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public String getProfileImage() {
        return profileImage;
    }

    public String getPhone() {
        return phone;
    }

    public String getCity() {
        return city;
    }

    public String getToken() {
        return token;
    }
}
