package com.controladores;

import com.modelos.Chat;
import com.modelos.Mensaje;
import com.modelos.Solicitud;
import com.servicios.ServicioChat;
import com.servicios.ServicioSolicitud;

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

    @Autowired
    private ServicioSolicitud servicioSolicitud;

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

            // Actualizar el estado de la solicitud a "Leído"
            Solicitud solicitud = servicioSolicitud.getSolicitudById(solicitudId);
            if (solicitud != null) {
                solicitud.setEstado("Leído");
                servicioSolicitud.guardarSolicitud(solicitud); // Guardar la solicitud con el nuevo estado
            }

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
        Chat chat = chatFuture.join(); // Bloquea hasta que obtenga el resultado

        if (chat == null) {
            System.out.println("❌ Chat no encontrado para ID: " + chatId);
            return "redirect:/error?mensaje=Chat no encontrado";
        }

        // 🛠️ LOG: Mostrar información general del chat
        System.out.println("📨 Accediendo al chat con ID: " + chatId);
        System.out.println("👥 Solicitante ID: " + chat.getSolicitanteId());
        System.out.println("📅 Fecha de creación (timestamp): " + chat.getFechaCreacion());
        System.out.println("🧵 Nombre del chat: " + chat.getNombre());

        // 🛠️ LOG: Mostrar mensajes del chat (si hay)
        if (chat.getMensajes() != null && !chat.getMensajes().isEmpty()) {
            System.out.println("💬 Mensajes del chat:");
            for (Mensaje m : chat.getMensajes()) {
                String contenido = m.getContenido() != null ? m.getContenido() : "[sin contenido]";
                String autor = m.getNombreUsuario() != null ? m.getNombreUsuario() : "[desconocido]";
                String fecha = (m.getCreatedAt() != null) ? m.getCreatedAt().toString() : "[fecha nula]";
                System.out.println("   🗨️ " + autor + ": " + contenido + " (" + fecha + ")");
                if (m.getCreatedAt() != null) {
                    System.out.println("   🕒 Tipo de createdAt: " + m.getCreatedAt().getClass().getName());
                }
            }
        } else {
            System.out.println("📭 No hay mensajes en este chat.");
        }

        // Formatear la fecha para mostrar en la vista
        SimpleDateFormat dateFormat = new SimpleDateFormat("dd MMMM yyyy");
        String formattedDate = dateFormat.format(new Date(chat.getFechaCreacion()));

        // Cargar datos al modelo para JSP
        model.addAttribute("chat", chat);
        model.addAttribute("fechaCreacionFormateada", formattedDate);
        model.addAttribute("mensajes", chat.getMensajes() != null ? chat.getMensajes() : new ArrayList<>());
        model.addAttribute("chatId", chatId);
        model.addAttribute("solicitanteId", chat.getSolicitanteId());

        return "chat.jsp"; // Renderiza la vista
    } catch (Exception e) {
        System.out.println("🚨 Error al cargar el chat: " + e.getMessage());
        e.printStackTrace();
        return "redirect:/error?mensaje=No se pudo cargar el chat";
    }
}


}
