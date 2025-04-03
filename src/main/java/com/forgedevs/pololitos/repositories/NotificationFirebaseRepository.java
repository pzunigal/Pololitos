package com.forgedevs.pololitos.repositories;

import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.forgedevs.pololitos.models.Notification;

import org.springframework.stereotype.Repository;

@Repository
public class NotificationFirebaseRepository {

    private final DatabaseReference notificationsRef;

    public NotificationFirebaseRepository(FirebaseDatabase firebaseDatabase) {
        this.notificationsRef = firebaseDatabase.getReference("notificaciones");
    }

    public void saveNotification(Notification notification) {
        DatabaseReference userRef = notificationsRef.child(notification.getReceiverId().toString());
        DatabaseReference newNotificationRef = userRef.push();

        notification.setId(newNotificationRef.getKey());
        newNotificationRef.setValueAsync(notification);
    }

    public void markAsRead(Long userId, String notificationId) {
        notificationsRef.child(userId.toString()).child(notificationId).child("read").setValueAsync(true);
    }

    public DatabaseReference getUserNotifications(Long userId) {
        return notificationsRef.child(userId.toString());
    }
}
