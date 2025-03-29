package com.forgedevs.pololitos.controllers;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import com.forgedevs.pololitos.models.LoginUser;
import com.forgedevs.pololitos.models.LoginUserResponse;
import com.forgedevs.pololitos.models.OfferedService;
import com.forgedevs.pololitos.models.User;
import com.forgedevs.pololitos.services.CloudinaryService;
import com.forgedevs.pololitos.services.ServiceService;
import com.forgedevs.pololitos.services.UserService;

import jakarta.validation.Valid;

@RestController
@RequestMapping("/api/users")
@CrossOrigin(origins = "http://localhost:3000")
public class UserController {

    @Autowired
    private UserService userService;

    @Autowired
    private ServiceService serviceService;

    @Autowired
    private CloudinaryService cloudinaryService;

    @PostMapping("/register")
    public ResponseEntity<?> registerUser(@Valid @ModelAttribute User newUser,
            BindingResult result,
            @RequestParam(value = "profileImageFile", required = false) MultipartFile profileImageFile) {
        if (profileImageFile != null && !profileImageFile.isEmpty()) {
            try {
                String url = cloudinaryService.uploadFile(profileImageFile, "profile-images");
                newUser.setProfileImage(url);
            } catch (IOException e) {
                return ResponseEntity.badRequest().body("Error al subir la imagen de perfil.");
            }
        }

        User savedUser = userService.registerUser(newUser, result);
        if (result.hasErrors() || savedUser == null) {
            return ResponseEntity.badRequest().body("Error al registrar usuario.");
        }

        return ResponseEntity.ok(savedUser);
    }

    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody LoginUser loginUser, BindingResult result) {
        // Usamos los datos de loginUser (que ahora contiene email y password)
        User user = userService.login(loginUser.getEmailLogin(), loginUser.getPasswordLogin(), result);

        if (result.hasErrors() || user == null) {
            return ResponseEntity.status(401).body("Credenciales inválidas.");
        }

        // Creamos el LoginUserResponse para responder con los campos necesarios
        LoginUserResponse response = new LoginUserResponse(
                user.getEmail(),
                user.getFirstName(),
                user.getLastName(),
                user.getProfileImage(),
                user.getPhone(),
                user.getCity());

        return ResponseEntity.ok(response);
    }

    @GetMapping("/{userId}/profile")
    public ResponseEntity<?> getProfile(@PathVariable Long userId) {
        User user = userService.findById(userId);
        if (user == null) {
            return ResponseEntity.notFound().build();
        }

        List<OfferedService> userServices = serviceService.getServicesByUserId(user.getId());
        return ResponseEntity.ok(new UserProfileResponse(user, userServices));
    }

    @PatchMapping("/{userId}/profile")
    @Transactional
    public ResponseEntity<?> updateProfile(@PathVariable Long userId,
            @ModelAttribute User user,
            BindingResult result,
            @RequestParam(value = "profileImageFile", required = false) MultipartFile newImage) {
        User existingUser = userService.findById(userId);
        if (existingUser == null) {
            return ResponseEntity.status(401).body("Usuario no encontrado.");
        }

        if (result.hasErrors()) {
            return ResponseEntity.badRequest().body("Errores en los datos.");
        }

        if (newImage != null && !newImage.isEmpty()) {
            try {
                if (existingUser.getProfileImage() != null) {
                    cloudinaryService.deleteFile(existingUser.getProfileImage());
                }
                String newUrl = cloudinaryService.uploadFile(newImage, "profile-images");
                existingUser.setProfileImage(newUrl);
            } catch (IOException e) {
                return ResponseEntity.badRequest().body("Error al actualizar imagen de perfil.");
            }
        }

        existingUser.setFirstName(user.getFirstName());
        existingUser.setLastName(user.getLastName());
        existingUser.setPhone(user.getPhone());
        existingUser.setCity(user.getCity());

        userService.updateUser(existingUser);
        return ResponseEntity.ok(existingUser);
    }

    // Inner class for response
    public static class UserProfileResponse {
        private User user;
        private List<OfferedService> services;

        public UserProfileResponse(User user, List<OfferedService> services) {
            this.user = user;
            this.services = services;
        }

        public User getUser() {
            return user;
        }

        public List<OfferedService> getServices() {
            return services;
        }
    }
}
