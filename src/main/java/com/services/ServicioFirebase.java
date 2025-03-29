package com.services;

import com.google.firebase.FirebaseApp;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import org.springframework.stereotype.Service;

@Service
public class ServicioFirebase {

    private final DatabaseReference databaseReference;

    // Inyectamos FirebaseApp para asegurarnos de que esté inicializada
    public ServicioFirebase(FirebaseApp firebaseApp) {
        this.databaseReference = FirebaseDatabase.getInstance(firebaseApp).getReference();
    }

    public void saveData(String key, Object data) {
        // Guardar datos en Firebase de manera asíncrona
        databaseReference.child(key).setValueAsync(data);
    }
}
