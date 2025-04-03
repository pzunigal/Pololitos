package com.forgedevs.pololitos.services;

import com.forgedevs.pololitos.models.Notification;
import com.forgedevs.pololitos.models.OfferedService;
import com.forgedevs.pololitos.models.Request;
import com.forgedevs.pololitos.models.User;
import com.forgedevs.pololitos.repositories.NotificationFirebaseRepository;
import org.springframework.stereotype.Service;

import java.time.Instant;

@Service
public class NotificationService {

    private final NotificationFirebaseRepository repository;

    public NotificationService(NotificationFirebaseRepository repository) {
        this.repository = repository;
    }

    public void notifyNewRequest(Request request) {
        User requester = request.getRequester();
        OfferedService service = request.getService();

        String text = requester.getFirstName() + " " + requester.getLastName() +
                " ha solicitado tu servicio: " + service.getName();

        Notification notification = new Notification(
                service.getUser().getId(),
                "Solicitud",
                text,
                "/my-received-requests",
                Instant.now().toString(),
                requester.getId(),
                requester.getFirstName() + " " + requester.getLastName(),
                service.getName(),
                service.getImageUrl()
        );

        repository.saveNotification(notification);
    }

    public void markNotificationAsRead(Long userId, String notificationId) {
        repository.markAsRead(userId, notificationId);
    }

    public void notifyStatusChange(Request request, String newStatus) {
        String message = switch (newStatus) {
            case "Aceptada" -> "Tu solicitud fue aceptada";
            case "Rechazada" -> "Tu solicitud fue rechazada";
            case "Cancelada" -> "El usuario ha cancelado la solicitud";
            case "Completada" -> "El proveedor ha marcado la solicitud como completada";
            default -> "Tu solicitud cambió de estado";
        };

        Notification notification = Notification.createStatusChange(request, newStatus, message);
        repository.saveNotification(notification);
    }

    public void notifyConversationStarted(Request request, String chatId) {
        User requester = request.getRequester();
        User provider = request.getService().getUser();
        OfferedService service = request.getService();

        String message = "El proveedor ha iniciado una conversación sobre tu solicitud.";

        Notification notification = new Notification(
                requester.getId(),
                "Conversación Iniciada",
                message,
                "/chat/view/" + chatId,
                Instant.now().toString(),
                provider.getId(),
                provider.getFirstName() + " " + provider.getLastName(),
                service.getName(),
                provider.getProfileImage()
        );

        repository.saveNotification(notification);
    }
}
