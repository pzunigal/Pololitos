package com.forgedevs.pololitos.controllers;

import com.forgedevs.pololitos.models.Message;
import com.forgedevs.pololitos.services.MessageService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/messages")
public class MessageController {

    @Autowired
    private MessageService messageService;

    @PostMapping("/send")
    public ResponseEntity<?> sendMessage(
            @RequestParam("chatId") String chatId,
            @RequestParam("content") String content,
            @RequestParam("userId") Long userId,
            @RequestParam("userName") String userName) {

        try {
            Message message = new Message(content, userId, userName);
            messageService.sendMessage(chatId, message);
            return ResponseEntity.ok("Mensaje enviado");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Error al enviar el mensaje: " + e.getMessage());
        }
    }
}
