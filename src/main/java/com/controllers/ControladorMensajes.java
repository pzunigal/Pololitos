package com.controllers;

import com.models.Mensaje;
import com.models.Usuario;
import com.services.ServicioMensajes;

import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/mensajes")
public class ControladorMensajes {

    @Autowired
    private ServicioMensajes servicioMensajes;

    @PostMapping("/enviar")
    public String enviarMensaje(@RequestParam("chatId") String chatId,
            @RequestParam("contenido") String contenido,
            HttpSession session) {

        Usuario usuario = (Usuario) session.getAttribute("usuarioEnSesion");
        if (usuario == null) {
            return "redirect:/login";
        }

        String nombreCompleto = usuario.getNombre() + " " + usuario.getApellido();

        Mensaje mensaje = new Mensaje(contenido, usuario.getId(), nombreCompleto);
        servicioMensajes.enviarMensaje(chatId, mensaje);

        return "redirect:/chat/ver/" + chatId;
    }

}
