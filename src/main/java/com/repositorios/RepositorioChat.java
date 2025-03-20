package com.repositorios;

import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.ValueEventListener;
import com.modelos.Chat;
import org.springframework.stereotype.Repository;

@Repository
public class RepositorioChat {

    private final DatabaseReference databaseReference;

    public RepositorioChat(FirebaseDatabase firebaseDatabase) {
        this.databaseReference = firebaseDatabase.getReference("chats");
    }

    // Método para guardar un chat en Firebase
    public void saveChat(String chatId, Chat chat) {
        databaseReference.child(chatId).setValueAsync(chat);
    }

    // Método para obtener un chat de Firebase de forma asíncrona
    public void getChat(String chatId, ValueEventListener listener) {
        databaseReference.child(chatId).addListenerForSingleValueEvent(listener);
    }
}
