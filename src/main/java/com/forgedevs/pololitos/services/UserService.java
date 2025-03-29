package com.forgedevs.pololitos.services;

import java.util.List;
import java.util.Optional;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.validation.BindingResult;

import com.forgedevs.pololitos.models.User;
import com.forgedevs.pololitos.repositories.UserRepository;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    // Register a user
    public User registerUser(User newUser, BindingResult result) {

        String password = newUser.getPassword();
        String confirm = newUser.getConfirmation();

        if (!password.equals(confirm)) {
            result.rejectValue("confirmPassword", "Matches", "Password y Confirmación deben ser iguales");
        }

        String email = newUser.getEmail();
        User existingUser = userRepository.findByEmail(email);

        if (existingUser != null) {
            result.rejectValue("email", "Unique", "E-mail ya se encuentra registrado.");
        }

        if (result.hasErrors()) {
            return null;
        } else {
            String hashed = BCrypt.hashpw(password, BCrypt.gensalt());
            newUser.setPassword(hashed);
            return userRepository.save(newUser);
        }
    }

    // Log in
    public User login(String email, String password, BindingResult result) {
        User existingUser = userRepository.findByEmail(email);

        if (existingUser == null) {
            result.rejectValue("email", "Unique", "E-mail no registrado");
        } else {
            if (!BCrypt.checkpw(password, existingUser.getPassword())) {
                result.rejectValue("password", "Matches", "Contraseña incorrecta");
            }
        }

        if (result.hasErrors()) {
            return null;
        } else {
            return existingUser;
        }
    }

    // Find by ID
    public User findById(Long id) {
        Optional<User> user = userRepository.findById(id);
        return user.orElse(null);
    }

    // Find by email
    public User findByEmail(String email) {
        return userRepository.findByEmail(email);
    }

    // Find all
    public List<User> findAllUsers() {
        return (List<User>) userRepository.findAll();
    }

    // Update
    public User updateUser(User user) {
        return userRepository.save(user);
    }

    // Delete
    public void deleteUser(Long id) {
        userRepository.deleteById(id);
    }
}
