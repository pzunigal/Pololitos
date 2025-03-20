package com.repositorios;

import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import org.springframework.stereotype.Repository;

@Repository
public class RepositorioChat {

    private final DatabaseReference databaseReference;

    public RepositorioChat(FirebaseDatabase firebaseDatabase) {
        this.databaseReference = firebaseDatabase.getReference("chats");
    }

    // Método para guardar un chat en Firebase
    public void saveChat(String chatId, Object chatData) {
        databaseReference.child(chatId).setValueAsync(chatData);
    }

    // Método para obtener un chat de Firebase
    public DatabaseReference getChat(String chatId) {
        return databaseReference.child(chatId);
    }

    // Otros métodos si es necesario, como obtener todos los chats, etc.
}
