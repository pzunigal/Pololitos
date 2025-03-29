package com.forgedevs.pololitos.repositories;

import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.ValueEventListener;
import com.forgedevs.pololitos.models.Chat;

import org.springframework.stereotype.Repository;

import java.util.Date;

@Repository
public class ChatNoSqlRepository {

    private final DatabaseReference databaseReference;

    public ChatNoSqlRepository(FirebaseDatabase firebaseDatabase) {
        this.databaseReference = firebaseDatabase.getReference("chats");
    }

    // Get a chat from Firebase asynchronously
    public void getChat(String chatId, ValueEventListener listener) {
        databaseReference.child(chatId).addListenerForSingleValueEvent(listener);
    }

    // Save a chat to Firebase
    public String saveChat(Chat chat) {
        DatabaseReference newRef = databaseReference.push();
        chat.setId(newRef.getKey()); // Firebase auto-generates the ID
        chat.setCreationTimestamp(new Date().getTime()); // Save as timestamp
        newRef.setValueAsync(chat);
        return chat.getId();
    }
}
