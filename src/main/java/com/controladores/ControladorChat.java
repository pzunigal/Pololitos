package com.controladores;

import com.servicios.ServicioChat;
import com.modelos.Chat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.Date;
import java.util.concurrent.CompletionException;

@Controller
@RequestMapping("/chat")
public class ControladorChat {

    private final ServicioChat servicioChat;

    public ControladorChat(ServicioChat servicioChat) {
        this.servicioChat = servicioChat;
    }

    @PostMapping("/crear")
    public String createChat(@RequestParam Long solicitanteId, @RequestParam Long solicitudId) {
        try {
            Chat chat = new Chat();
            chat.setSolicitanteId(solicitanteId);
            chat.setSolicitudId(solicitudId);
            chat.setFechaCreacion(new Date());

            Chat createdChat = servicioChat.createChat(chat);

            // Redirigir a la vista del chat con el ID creado
            return "redirect:/chat/ver/" + createdChat.getId();
        } catch (Exception e) {
            return "redirect:/error?mensaje=" + e.getMessage();
        }
    }

    @GetMapping("/ver/{chatId}")
public String verChat(@PathVariable String chatId, Model model) {
    try {
        Chat chat = servicioChat.getChat(chatId).join(); // Espera la respuesta

        if (chat == null) {
            return "redirect:/error?mensaje=Chat no encontrado";
        }

        model.addAttribute("chat", chat);
        model.addAttribute("mensajes", chat.getMensajes() != null ? chat.getMensajes() : new ArrayList<>());
        model.addAttribute("chatId", chatId);
        model.addAttribute("solicitanteId", chat.getSolicitanteId());

        return "chat.jsp"; // Renderiza la vista `chat.jsp`
    } catch (CompletionException e) {
        // Si Firebase devuelve un error específico
        return "redirect:/error?mensaje=Error al obtener el chat: " + e.getCause().getMessage();
    } catch (Exception e) {
        // Error genérico
        return "redirect:/error?mensaje=No se pudo cargar el chat";
    }
}

}
