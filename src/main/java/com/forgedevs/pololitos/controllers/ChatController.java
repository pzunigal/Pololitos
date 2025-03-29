package com.forgedevs.pololitos.controllers;

import com.forgedevs.pololitos.models.Chat;
import com.forgedevs.pololitos.models.Request;
import com.forgedevs.pololitos.services.ChatService;
import com.forgedevs.pololitos.services.NotificationService;
import com.forgedevs.pololitos.services.RequestService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Date;
import java.util.concurrent.CompletableFuture;

@RestController
@RequestMapping("/api/chats")
public class ChatController {

    @Autowired
    private ChatService chatService;

    @Autowired
    private RequestService requestService;

    @Autowired
    private NotificationService notificationService;

    @PostMapping("/create")
    public ResponseEntity<?> createChat(@RequestParam Long requesterId, @RequestParam Long requestId) {
        try {
            Chat chat = new Chat();
            chat.setRequesterId(requesterId);
            chat.setRequestId(requestId);
            chat.setCreationTimestamp(new Date().getTime());

            Chat createdChat = chatService.createChat(chat);

            // Optional: Send notification (Firebase)
            Request request = requestService.getRequestById(requestId);
            notificationService.notifyConversationStarted(request, createdChat.getId());

            return ResponseEntity.ok(createdChat);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Error al crear el chat: " + e.getMessage());
        }
    }

    @GetMapping("/view/{chatId}")
    public ResponseEntity<?> viewChat(@PathVariable String chatId, @RequestParam Long userId) {
        try {
            CompletableFuture<Chat> chatFuture = chatService.getChat(chatId);
            Chat chat = chatFuture.join();

            if (chat == null) {
                return ResponseEntity.notFound().build();
            }

            Request request = requestService.getRequestById(chat.getRequestId());
            if (request == null) {
                return ResponseEntity.badRequest().body("Solicitud no encontrada");
            }

            boolean isRequester = request.getRequester().getId().equals(userId);
            boolean isProvider = request.getService().getUser().getId().equals(userId);

            if (!isRequester && !isProvider) {
                return ResponseEntity.status(403).body("Acceso denegado");
            }

            return ResponseEntity.ok(chat);

        } catch (Exception e) {
            return ResponseEntity.internalServerError().body("Error al recuperar el chat");
        }
    }

    @GetMapping("/by-request/{requestId}")
    public ResponseEntity<?> getChatByRequest(@PathVariable Long requestId) {
        Chat chat = chatService.getChatByRequestId(requestId);
        if (chat != null) {
            return ResponseEntity.ok(chat);
        } else {
            return ResponseEntity.status(404).body("Chat no encontrado para esta solicitud");
        }
    }

    @GetMapping("/exists/{requestId}")
    public ResponseEntity<Boolean> existsConversation(@PathVariable Long requestId) {
        boolean exists = chatService.existsConversation(requestId);
        return ResponseEntity.ok(exists);
    }
}
