package com.repositorios;

import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.ValueEventListener;
import com.modelos.Mensaje;
import org.springframework.stereotype.Repository;

@Repository
public class RepositorioMensaje {

    private final DatabaseReference databaseReference;

    public RepositorioMensaje(FirebaseDatabase firebaseDatabase) {
        this.databaseReference = firebaseDatabase.getReference("mensajes");
    }

    // Método para guardar un mensaje en Firebase
    public void saveMensaje(String mensajeId, Mensaje mensaje) {
        databaseReference.child(mensajeId).setValueAsync(mensaje);
    }

    // Método para obtener un mensaje de Firebase de forma asíncrona
    public void getMensaje(String mensajeId, ValueEventListener listener) {
        databaseReference.child(mensajeId).addListenerForSingleValueEvent(listener);
    }
}
