package com.controladores;

import com.modelos.Chat;
import com.modelos.Servicio;
import com.modelos.Solicitud;
import com.modelos.Usuario;
import com.servicios.ServicioChat;
import com.servicios.ServicioSolicitud;

import jakarta.servlet.http.HttpSession;
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
    private ServicioChat servicioChat; // Inyección del servicio para gestionar chats

    @Autowired
    private ServicioSolicitud servicioSolicitud; // Inyección del servicio para gestionar solicitudes

    // Maneja la continuación de una conversación existente
    @PostMapping("/continuar")
    public String continuarConversacion(@RequestParam("solicitudId") Long solicitudId, HttpSession session) {
        // Obtener el usuario autenticado desde la sesión
        Usuario usuarioEnSesion = (Usuario) session.getAttribute("usuarioEnSesion");
        if (usuarioEnSesion == null) {
            // Si no hay usuario en sesión, redirigir al login
            return "redirect:/login";
        }

        // Verificar si ya existe un chat relacionado con la solicitud
        if (!servicioChat.existeConversacion(solicitudId)) {
            // Si no existe, redirigir a la lista de solicitudes recibidas
            return "redirect:/mis-solicitudes-recibidas";
        }

        // Recuperar el chat existente desde el servicio
        Chat chatExistente = servicioChat.getChatBySolicitudId(solicitudId);
        if (chatExistente == null) {
            // Si no se encuentra el chat, redirigir a la página de error
            return "redirect:/error?mensaje=Chat no encontrado";
        }

        // Redirigir a la vista del chat correspondiente
        return "redirect:/chat/ver/" + chatExistente.getId();
    }

    // Crea una nueva conversación de chat
    @PostMapping("/crear")
    public String crearChat(@RequestParam Long solicitanteId, @RequestParam Long solicitudId, HttpSession session) {
        try {
            // Crear un nuevo objeto Chat y establecer atributos clave
            Chat chat = new Chat();
            chat.setSolicitanteId(solicitanteId);
            chat.setSolicitudId(solicitudId);
            chat.setFechaCreacion(new Date().getTime()); // Guardar timestamp actual como fecha de creación

            // Persistir el nuevo chat en Firebase o base de datos
            Chat createdChat = servicioChat.createChat(chat);
            // Marcar en sesión que el chat fue creado para esa solicitud (bandera para
            // lógica futura)
            session.setAttribute("isChatCreated_" + solicitudId, true);

            // Redirigir al usuario a la vista del nuevo chat
            return "redirect:/chat/ver/" + createdChat.getId();
        } catch (Exception e) {
            // En caso de error, redirigir a la vista de error con el mensaje
            // correspondiente
            return "redirect:/error?mensaje=" + e.getMessage();
        }
    }

    // Carga la vista del chat con sus mensajes y metadatos
    @GetMapping("/ver/{chatId}")
    public String verChat(@PathVariable String chatId, Model model, HttpSession session) {
        try {
            // Verificar que el usuario esté logueado
            Usuario usuarioEnSesion = (Usuario) session.getAttribute("usuarioEnSesion");
            if (usuarioEnSesion == null) {
                return "redirect:/";
            }

            // Obtener el chat de forma asíncrona
            CompletableFuture<Chat> chatFuture = servicioChat.getChat(chatId);
            Chat chat = chatFuture.join();

            // Si no se encuentra el chat, redirigir a home
            if (chat == null) {
                return "redirect:/";
            }

            // Obtener la solicitud asociada
            Solicitud solicitud = servicioSolicitud.getSolicitudById(chat.getSolicitudId());
            if (solicitud == null) {
                return "redirect:/";
            }

            // Validar si el usuario actual es el solicitante o el proveedor del servicio
            boolean esSolicitante = solicitud.getSolicitante().getId().equals(usuarioEnSesion.getId());
            boolean esProveedor = solicitud.getServicio().getUsuario().getId().equals(usuarioEnSesion.getId());
            Usuario otroUsuario = esSolicitante
                    ? solicitud.getServicio().getUsuario()
                    : solicitud.getSolicitante();
            String rolDescripcion = esSolicitante ? solicitud.getServicio().getNombre() : "Solicitante";
            model.addAttribute("rolDescripcion", rolDescripcion);

            if (!esSolicitante && !esProveedor) {
                return "redirect:/";
            }

            // Formatear fecha
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd MMMM yyyy");
            String formattedDate = dateFormat.format(new Date(chat.getFechaCreacion()));

            // Cargar datos al modelo
            model.addAttribute("chat", chat);
            model.addAttribute("fechaCreacionFormateada", formattedDate);
            model.addAttribute("mensajes", chat.getMensajes() != null ? chat.getMensajes() : new ArrayList<>());
            model.addAttribute("chatId", chatId);
            model.addAttribute("solicitanteId", chat.getSolicitanteId());
            model.addAttribute("otroUsuario", otroUsuario);
            Servicio servicio = solicitud.getServicio();
            model.addAttribute("servicio", servicio);

            return "chat.jsp";
        } catch (Exception e) {
            // Si ocurre cualquier error inesperado, redirigir a home
            return "redirect:/";
        }
    }

}
