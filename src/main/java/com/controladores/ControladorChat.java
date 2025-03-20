package com.controladores;

import com.modelos.Chat;
import com.servicios.ServicioChat;
import jakarta.servlet.http.HttpSession;
import com.modelos.Usuario;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.concurrent.CompletableFuture;

@Controller
@RequestMapping("/chat")
public class ControladorChat {

    @Autowired
    private ServicioChat servicioChat;

    @PostMapping("/continuar")
    public String continuarConversacion(@RequestParam("solicitudId") Long solicitudId, HttpSession session) {
        // Obtener usuario en sesión
        Usuario usuarioEnSesion = (Usuario) session.getAttribute("usuarioEnSesion");
        if (usuarioEnSesion == null) {
            return "redirect:/login"; // Redirigir si no hay usuario en sesión
        }
    
        // Verificar si la conversación existe
        if (!servicioChat.existeConversacion(solicitudId)) {
            return "redirect:/mis-solicitudes-recibidas"; // Redirigir si la conversación no existe
        }
    
        // Obtener el chat asociado a la solicitud
        Chat chatExistente = servicioChat.getChatBySolicitudId(solicitudId);
        if (chatExistente == null) {
            return "redirect:/error?mensaje=Chat no encontrado";
        }
    
        // Redirigir a la vista del chat usando el chatId correcto
        return "redirect:/chat/ver/" + chatExistente.getId();
    }
    

    // Método para crear una nueva conversación
    @PostMapping("/crear")
    public String crearChat(@RequestParam Long solicitanteId, @RequestParam Long solicitudId, HttpSession session) {
        try {
            // Crear un objeto de tipo Chat
            Chat chat = new Chat();
            chat.setSolicitanteId(solicitanteId);
            chat.setSolicitudId(solicitudId);
            chat.setFechaCreacion(new Date().getTime()); // Establecer la fecha de creación como timestamp

            // Guardar el chat usando el servicio
            Chat createdChat = servicioChat.createChat(chat); // Usar el servicio para crear el chat

            // Agregar la variable que indica que el chat fue creado
            session.setAttribute("isChatCreated_" + solicitudId, true);

            // Redirigir a la vista del chat con el ID creado
            return "redirect:/chat/ver/" + createdChat.getId();
        } catch (Exception e) {
            return "redirect:/error?mensaje=" + e.getMessage();
        }
    }

    @GetMapping("/ver/{chatId}")
    public String verChat(@PathVariable String chatId, Model model) {
        try {
            // Esperar a que el CompletableFuture se resuelva y obtener el Chat
            CompletableFuture<Chat> chatFuture = servicioChat.getChat(chatId);
            Chat chat = chatFuture.join(); // Utiliza join() para esperar el resultado de manera sincrónica

            if (chat == null) {
                return "redirect:/error?mensaje=Chat no encontrado";
            }

            // Formatear la fecha
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd MMMM yyyy");
            String formattedDate = dateFormat.format(new Date(chat.getFechaCreacion()));

            model.addAttribute("chat", chat);
            model.addAttribute("fechaCreacionFormateada", formattedDate); // Pasar la fecha formateada
            model.addAttribute("mensajes", chat.getMensajes() != null ? chat.getMensajes() : new ArrayList<>());
            model.addAttribute("chatId", chatId);
            model.addAttribute("solicitanteId", chat.getSolicitanteId());

            return "chat.jsp"; // Renderiza la vista `chat.jsp`
        } catch (Exception e) {
            // Si ocurre una excepción, redirige al usuario con un mensaje de error
            return "redirect:/error?mensaje=No se pudo cargar el chat";
        }
    }

}
