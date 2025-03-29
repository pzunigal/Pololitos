package com.services;

import com.models.Message;
import com.repositories.MessageFirebaseRepository;
import org.springframework.stereotype.Service;

@Service
public class MessageService {

    private final MessageFirebaseRepository messageFirebaseRepository;

    public MessageService(MessageFirebaseRepository messageFirebaseRepository) {
        this.messageFirebaseRepository = messageFirebaseRepository;
    }

    public void sendMessage(String chatId, Message message) {
        messageFirebaseRepository.saveMessage(chatId, message);
    }
}
