package com.forgedevs.pololitos.models;

public class LoginUserResponse {

    private String email;
    private String firstName;
    private String lastName;
    private String profileImage;
    private String phone;
    private String city;

    // Constructor para enviar los datos relevantes
    public LoginUserResponse(String email, String firstName, String lastName, String profileImage, String phone, String city) {
        this.email = email;
        this.firstName = firstName;
        this.lastName = lastName;
        this.profileImage = profileImage;
        this.phone = phone;
        this.city = city;
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
}
