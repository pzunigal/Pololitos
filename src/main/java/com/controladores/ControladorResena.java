package com.controladores;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.modelos.Resena;
import com.modelos.Servicio;
import com.modelos.Usuario;
import com.servicios.ServicioResena;
import com.servicios.ServicioServicios;

import jakarta.servlet.http.HttpSession;

@Controller
public class ControladorResena {

    @Autowired
    private ServicioServicios servicioServicios;

    @Autowired
    private ServicioResena servicioResena;

    @PostMapping("/publicar-resena")
    public String publicarResena(@RequestParam("servicioId") Long servicioId,
                                 @RequestParam("calificacion") Integer calificacion,
                                 @RequestParam("comentario") String comentario,
                                 HttpSession session,
                                 RedirectAttributes redirectAttributes) {

        Usuario usuarioEnSesion = (Usuario) session.getAttribute("usuarioEnSesion");

        if (usuarioEnSesion == null) {
            session.setAttribute("urlPendiente", "/servicio/detalles/" + servicioId);
            return "redirect:/login";
        }

        Servicio servicio = servicioServicios.obtenerPorId(servicioId);
        if (servicio == null) {
            redirectAttributes.addFlashAttribute("error", "El servicio no existe.");
            return "redirect:/servicios";
        }

        Resena nueva = new Resena();
        nueva.setServicio(servicio);
        nueva.setUsuario(usuarioEnSesion);
        nueva.setCalificacion(calificacion);
        nueva.setComentario(comentario);
        nueva.setCreatedAt(new Date());

        servicioResena.guardar(nueva);

        redirectAttributes.addFlashAttribute("success", "Reseña publicada.");
        return "redirect:/servicio/detalles/" + servicioId;
    }
}
