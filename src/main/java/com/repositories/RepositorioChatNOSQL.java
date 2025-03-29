package com.repositories;

import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.ValueEventListener;
import com.models.Chat;

import org.springframework.stereotype.Repository;

import java.util.Date;

@Repository
public class RepositorioChatNOSQL {

    private final DatabaseReference databaseReference;

    public RepositorioChatNOSQL(FirebaseDatabase firebaseDatabase) {
        this.databaseReference = firebaseDatabase.getReference("chats");
    }

    // Método para obtener un chat de Firebase de forma asíncrona
    public void getChat(String chatId, ValueEventListener listener) {
        databaseReference.child(chatId).addListenerForSingleValueEvent(listener);
    }

    // Guardar el chat en Firebase
    public String saveChat(Chat chat) {
        DatabaseReference newRef = databaseReference.push();
        chat.setId(newRef.getKey());  // Firebase genera el ID automáticamente
        chat.setFechaCreacion(new Date().getTime()); // Guardar como timestamp
        newRef.setValueAsync(chat);
        return chat.getId();
    }
}
