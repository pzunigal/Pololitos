package com.controladores;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.modelos.Servicio;
import com.modelos.Solicitud;
import com.modelos.Usuario;
import com.servicios.ServicioServicios;
import com.servicios.SolicitudServicio;

import jakarta.servlet.http.HttpSession;

@Controller
public class ControladorSolicitud {
    
    @Autowired
    private SolicitudServicio solicitudServicio;

    @Autowired
    private ServicioServicios servicioServicio;

    @PostMapping("/crear-solicitud")
    public String crearSolicitud(@RequestParam("mensaje") String mensaje, @RequestParam("servicioId") Long servicioId,
            HttpSession session, RedirectAttributes redirectAttributes) {
        
        // Obtener usuario en sesión
        Usuario usuarioEnSesion = (Usuario) session.getAttribute("usuarioEnSesion");
        if (usuarioEnSesion == null) {
            return "redirect:/login"; // Redirigir si no hay usuario en sesión
        }

        // Obtener el servicio al que se quiere enviar la solicitud
        Servicio servicio = servicioServicio.obtenerPorId(servicioId);
        if (servicio == null) {
            redirectAttributes.addFlashAttribute("error", "El servicio no existe.");
            return "redirect:/servicios";
        }

        // Crear la nueva solicitud
        Solicitud nuevaSolicitud = new Solicitud();
        nuevaSolicitud.setSolicitante(usuarioEnSesion);
        nuevaSolicitud.setServicio(servicio);
        nuevaSolicitud.setEstado("Enviado"); // Estado por defecto
        nuevaSolicitud.setFechaSolicitud(new Date());
        nuevaSolicitud.setComentarioAdicional(mensaje);

        // Guardar la solicitud
        solicitudServicio.guardarSolicitud(nuevaSolicitud);
        redirectAttributes.addFlashAttribute("success", "Solicitud enviada correctamente.");

        return "redirect:/servicio/detalles/" + servicioId; // Redirigir a los detalles del servicio
    }

    // Endpoint para ver las solicitudes enviadas
    @GetMapping("/solicitudes/mis-enviadas")
    public ModelAndView verMisSolicitudesEnviadas(HttpSession session) {
        // Obtener usuario en sesión
        Usuario usuarioEnSesion = (Usuario) session.getAttribute("usuarioEnSesion");
        if (usuarioEnSesion == null) {
            return new ModelAndView("redirect:/login"); // Redirigir si no hay usuario en sesión
        }

        // Obtener todas las solicitudes enviadas por el usuario
        List<Solicitud> solicitudesEnviadas = solicitudServicio.obtenerSolicitudesPorSolicitante(usuarioEnSesion);

        // Crear y devolver la vista con las solicitudes
        ModelAndView mav = new ModelAndView("misSolicitudesEnviadas.jsp");
        mav.addObject("solicitudes", solicitudesEnviadas);
        return mav;
    }
}
