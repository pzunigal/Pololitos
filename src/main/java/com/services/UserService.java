package com.services;

import java.util.List;
import java.util.Optional;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.validation.BindingResult;

import com.models.LoginUser;
import com.models.User;
import com.repositories.UserRepository;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    // Register a user
    public User registerUser(User newUser, BindingResult result) {

        String password = newUser.getPassword();
        String confirm = newUser.getConfirmPassword();

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
    public User login(LoginUser loginData, BindingResult result) {

        String email = loginData.getEmailLogin();
        User existingUser = userRepository.findByEmail(email);

        if (existingUser == null) {
            result.rejectValue("emailLogin", "Unique", "E-mail no registrado");
        } else {
            if (!BCrypt.checkpw(loginData.getPasswordLogin(), existingUser.getPassword())) {
                result.rejectValue("passwordLogin", "Matches", "Password incorrecto");
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
