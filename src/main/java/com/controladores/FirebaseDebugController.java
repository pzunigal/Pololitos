package com.controladores;

import com.google.firebase.database.*;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/debug-firebase")
public class FirebaseDebugController {

    @GetMapping("/{chatId}")
    public String debugFirebase(@PathVariable String chatId) {
        System.out.println("🔍 Solicitando acceso al chat con ID: " + chatId);

        DatabaseReference chatRef = FirebaseDatabase.getInstance()
                .getReference("chats")
                .child(chatId);

        chatRef.addListenerForSingleValueEvent(new ValueEventListener() {
            @Override
            public void onDataChange(DataSnapshot snapshot) {
                if (snapshot.exists()) {
                    System.out.println("✅ Snapshot recibido desde Firebase:");
                    System.out.println(snapshot.getValue());
                } else {
                    System.out.println("⚠️ No se encontró el chat con ID: " + chatId);
                }
            }

            @Override
            public void onCancelled(DatabaseError error) {
                System.out.println("❌ Error accediendo a Firebase: " + error.getMessage());
            }
        });

        return "🔄 Consulta enviada a Firebase. Revisa la consola.";
    }
}
