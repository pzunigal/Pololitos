package com.services;

import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.CompletableFuture;

import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.ValueEventListener;

import com.models.Chat;
import com.models.Message;
import com.models.Service;
import com.models.Request;

import com.repositories.ChatRepository;
import com.repositories.ChatNoSqlRepository;

@Service
public class ChatService {

    private final ChatNoSqlRepository chatNoSqlRepository;
    private final RequestService requestService;
    private final ServiceService serviceService;
    private final ChatRepository chatRepository;

    public ChatService(ChatNoSqlRepository chatNoSqlRepository,
                       RequestService requestService,
                       ServiceService serviceService,
                       ChatRepository chatRepository) {
        this.chatNoSqlRepository = chatNoSqlRepository;
        this.requestService = requestService;
        this.serviceService = serviceService;
        this.chatRepository = chatRepository;
    }

    public Chat createChat(Chat chat) {
        Request request = requestService.getRequestById(chat.getRequestId());
        Service service = serviceService.getById(request.getService().getId());

        String chatName = service.getName() + " | " + service.getUser().getFirstName() + " | " + service.getCity();
        chat.setName(chatName);

        String generatedId = chatNoSqlRepository.saveChat(chat);
        chat.setId(generatedId);

        chatRepository.save(chat);
        return chat;
    }

    public CompletableFuture<Chat> getChat(String chatId) {
        CompletableFuture<Chat> future = new CompletableFuture<>();

        chatNoSqlRepository.getChat(chatId, new ValueEventListener() {
            @Override
            public void onDataChange(DataSnapshot snapshot) {
                if (!snapshot.exists()) {
                    future.complete(null);
                    return;
                }

                Chat chat = new Chat();
                chat.setId(snapshot.child("id").getValue(String.class));
                chat.setName(snapshot.child("name").getValue(String.class));
                chat.setCreationTimestamp(snapshot.child("creationTimestamp").getValue(Long.class));
                chat.setRequesterId(snapshot.child("requesterId").getValue(Long.class));
                chat.setRequestId(snapshot.child("requestId").getValue(Long.class));

                List<Message> messages = new ArrayList<>();
                DataSnapshot messagesSnapshot = snapshot.child("messages");
                for (DataSnapshot messageSnapshot : messagesSnapshot.getChildren()) {
                    Message message = messageSnapshot.getValue(Message.class);
                    messages.add(message);
                }
                chat.setMessages(messages);

                future.complete(chat);
            }

            @Override
            public void onCancelled(DatabaseError error) {
                future.completeExceptionally(error.toException());
            }
        });

        return future;
    }

    public boolean existsChatForRequest(Long requestId) {
        return chatRepository.findByRequestId(requestId) != null;
    }

    public boolean existsConversation(Long requestId) {
        return chatRepository.findByRequestId(requestId) != null;
    }

    public Chat getChatByRequestId(Long requestId) {
        return chatRepository.findByRequestId(requestId);
    }
}
