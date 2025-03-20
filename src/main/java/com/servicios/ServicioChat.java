package com.servicios;

import com.repositorios.RepositorioChat;
import com.modelos.Chat;
import com.google.firebase.database.*;
import org.springframework.stereotype.Service;

import java.util.concurrent.CompletableFuture;

@Service
public class ServicioChat {

    private final RepositorioChat repositorioChat;

    public ServicioChat(RepositorioChat repositorioChat) {
        this.repositorioChat = repositorioChat;
    }

    public void saveChat(String chatId, Chat chatData) {
        repositorioChat.saveChat(chatId, chatData);
    }

    public CompletableFuture<Chat> getChat(String chatId) {
        CompletableFuture<Chat> future = new CompletableFuture<>();
        repositorioChat.getChat(chatId, new ValueEventListener() {
            @Override
            public void onDataChange(DataSnapshot dataSnapshot) {
                Chat chat = dataSnapshot.getValue(Chat.class);
                future.complete(chat);
            }

            @Override
            public void onCancelled(DatabaseError databaseError) {
                future.completeExceptionally(databaseError.toException());
            }
        });
        return future;
    }
}
