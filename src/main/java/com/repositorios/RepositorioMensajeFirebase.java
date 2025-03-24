package com.repositorios;

import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.modelos.Mensaje;
import org.springframework.stereotype.Repository;

@Repository
public class RepositorioMensajeFirebase {

    private final DatabaseReference chatsRef;

    public RepositorioMensajeFirebase(FirebaseDatabase firebaseDatabase) {
        this.chatsRef = firebaseDatabase.getReference("chats");
    }

    public void guardarMensaje(String chatId, Mensaje mensaje) {
        DatabaseReference nuevoMensajeRef = chatsRef.child(chatId).child("mensajes").push();
        mensaje.setId(nuevoMensajeRef.getKey());
        nuevoMensajeRef.setValueAsync(mensaje);
    }
}
