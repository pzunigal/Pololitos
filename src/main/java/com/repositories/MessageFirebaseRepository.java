package com.repositories;

import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.models.Message;

import org.springframework.stereotype.Repository;

@Repository
public class MessageFirebaseRepository {

    private final DatabaseReference chatsRef;

    public MessageFirebaseRepository(FirebaseDatabase firebaseDatabase) {
        this.chatsRef = firebaseDatabase.getReference("chats");
    }

    public void saveMessage(String chatId, Message message) {
        DatabaseReference newMessageRef = chatsRef.child(chatId).child("messages").push();
        message.setId(newMessageRef.getKey());
        newMessageRef.setValueAsync(message);
    }
}
