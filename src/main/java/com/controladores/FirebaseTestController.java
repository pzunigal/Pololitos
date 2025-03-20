package com.controladores;

import com.servicios.FirebaseService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/test")
public class FirebaseTestController {

    private final FirebaseService firebaseService;

    public FirebaseTestController(FirebaseService firebaseService) {
        this.firebaseService = firebaseService;
    }

    @GetMapping("/save-data")
    public String saveData() {
        String key = "user123";
        String data = "Hello Firebase!";
        
        try {
            // Guardamos el dato en Firebase
            firebaseService.saveData(key, data);
            return "Data saved to Firebase!";
        } catch (Exception e) {
            // Captura cualquier excepción y retorna el error
            return "Error saving data: " + e.getMessage();
        }
    }
}
