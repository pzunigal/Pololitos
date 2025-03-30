package com.forgedevs.pololitos.dtos;

public class LoginUserResponse {
    private Long id;
    private String email;
    private String firstName;
    private String lastName;
    private String profileImage;
    private String phone;
    private String city;
    private String token;

    public LoginUserResponse(
            String email,
            String firstName,
            String lastName,
            String profileImage,
            String phone,
            String city,
            String token
    ) {
        this.email = email;
        this.firstName = firstName;
        this.lastName = lastName;
        this.profileImage = profileImage;
        this.phone = phone;
        this.city = city;
        this.token = token;
    }

    // 🛠️ Agregá este nuevo constructor con `id`
    public LoginUserResponse(
            Long id,
            String email,
            String firstName,
            String lastName,
            String profileImage,
            String phone,
            String city,
            String token
    ) {
        this.id = id;
        this.email = email;
        this.firstName = firstName;
        this.lastName = lastName;
        this.profileImage = profileImage;
        this.phone = phone;
        this.city = city;
        this.token = token;
    }

    public Long getId() {
        return id;
    }

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

