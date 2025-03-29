package com.forgedevs.pololitos.controllers;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.forgedevs.pololitos.services.NotificationService;

@RestController
@RequestMapping("/api/notifications")
public class NotificationController {

    private final NotificationService notificationService;

    public NotificationController(NotificationService notificationService) {
        this.notificationService = notificationService;
    }

    @PatchMapping("/mark-as-read/{userId}/{notificationId}")
    public ResponseEntity<?> markAsRead(@PathVariable Long userId, @PathVariable String notificationId) {
        try {
            notificationService.markNotificationAsRead(userId, notificationId);
            return ResponseEntity.ok("Notificación marcada como leída.");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Error al marcar la notificación: " + e.getMessage());
        }
    }
}
