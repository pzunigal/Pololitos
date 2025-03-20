package com.controladores;

import com.servicios.ServicioChat;
import com.servicios.ServicioMensaje;
import com.modelos.Chat;
import com.modelos.Mensaje;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutionException;

@Controller
public class ControladorChat {

    private final ServicioChat servicioChat;
    /* private final ServicioMensaje servicioMensaje; */

    // Inyección de dependencias
    public ControladorChat(ServicioChat servicioChat, ServicioMensaje servicioMensaje) {
        this.servicioChat = servicioChat;
        /* this.servicioMensaje = servicioMensaje; */
    }
    @PostMapping("/crear-chat")
    public ResponseEntity<String> createChat(@RequestBody Chat chat) {
        try {
            String chatId = "chat-" + System.currentTimeMillis(); // Generar un ID único
            chat.setId(chatId);
            chat.setFechaCreacion(new Date());
            servicioChat.saveChat(chatId, chat);
            return ResponseEntity.ok("Chat creado con éxito en Firebase!");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Error creando el chat: " + e.getMessage());
        }
    }

    
    @GetMapping("/chat")
    public String mostrarChat(@RequestParam(name = "solicitanteId") String solicitanteId,
                              @RequestParam(name = "solicitudId") String solicitudId,
                              Model model) {
        String chatId = "chat-" + solicitanteId + "-" + solicitudId; 

        CompletableFuture<Chat> chatFuture = servicioChat.getChat(chatId);

        try {
            Chat chat = chatFuture.get(); // Bloquea, pero lo manejamos con try-catch
            List<Mensaje> mensajes = (chat != null && chat.getMensajes() != null) ? chat.getMensajes() : new ArrayList<>();
            model.addAttribute("chatId", chatId);
            model.addAttribute("mensajes", mensajes);
        } catch (InterruptedException | ExecutionException e) {
            model.addAttribute("chatId", chatId);
            model.addAttribute("mensajes", new ArrayList<>()); // Si falla, chat vacío
        }

        return "chat.jsp";
    }
}
