package com.controladores;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.servicios.ServicioNotificaciones;
import com.servicios.ServicioServicios;
import com.servicios.ServicioSolicitud;
import com.repositorios.RepositorioChatMySQL;

import jakarta.servlet.http.HttpSession;

@Controller
public class ControladorSolicitud {

    @Autowired
    private ServicioSolicitud solicitudServicio;

    @Autowired
    private ServicioServicios servicioServicio;

    /*
     * @Autowired
     * private ServicioChat servicioChat;
     */

    @Autowired
    private RepositorioChatMySQL repositorioChat;
    @Autowired
    private ServicioNotificaciones servicioNotificaciones;

    @PostMapping("/crear-solicitud")
    public String crearSolicitud(@RequestParam("mensaje") String mensaje,
            @RequestParam("servicioId") Long servicioId,
            HttpSession session,
            RedirectAttributes redirectAttributes) {

        Usuario usuarioEnSesion = (Usuario) session.getAttribute("usuarioEnSesion");
        if (usuarioEnSesion == null) {
            session.setAttribute("urlPendiente", "/servicio/detalles/" + servicioId);
            return "redirect:/login";
        }

        Servicio servicio = servicioServicio.obtenerPorId(servicioId);
        if (servicio == null) {
            redirectAttributes.addFlashAttribute("error", "El servicio no existe.");
            return "redirect:/servicios";
        }

        Solicitud nuevaSolicitud = new Solicitud();
        nuevaSolicitud.setSolicitante(usuarioEnSesion);
        nuevaSolicitud.setServicio(servicio);
        nuevaSolicitud.setEstado("Enviada");
        nuevaSolicitud.setFechaSolicitud(new Date());
        nuevaSolicitud.setComentarioAdicional(mensaje);

        solicitudServicio.guardarSolicitud(nuevaSolicitud);

        // Enviar notificación solo al proveedor (no al usuario que la crea)
        servicioNotificaciones.notificarNuevaSolicitud(nuevaSolicitud);

        redirectAttributes.addFlashAttribute("success", "Solicitud enviada correctamente.");
        return "redirect:/mis-solicitudes-enviadas";
    }

    @GetMapping("/mis-solicitudes-enviadas")
    public ModelAndView verMisSolicitudesEnviadas(HttpSession session) {
        Usuario usuarioEnSesion = (Usuario) session.getAttribute("usuarioEnSesion");
        if (usuarioEnSesion == null)
            return new ModelAndView("redirect:/login");

        List<Solicitud> activas = solicitudServicio.obtenerSolicitudesPorSolicitante(usuarioEnSesion).stream()
                .filter(s -> s.getEstado().equals("Enviada") || s.getEstado().equals("Aceptada"))
                .toList();

        List<Solicitud> inactivas = solicitudServicio.obtenerSolicitudesPorSolicitante(usuarioEnSesion).stream()
                .filter(s -> s.getEstado().equals("Cancelada") || s.getEstado().equals("Completada")
                        || s.getEstado().equals("Rechazada"))
                .toList();

        Map<Long, Boolean> chatsCreados = new HashMap<>();
        for (Solicitud s : activas) {
            chatsCreados.put(s.getId(), repositorioChat.findBySolicitudId(s.getId()) != null);
        }

        ModelAndView mav = new ModelAndView("misSolicitudesEnviadas.jsp");
        mav.addObject("solicitudesActivas", activas);
        mav.addObject("solicitudesInactivas", inactivas);
        mav.addObject("chatsCreados", chatsCreados);
        return mav;
    }

    @GetMapping("/mis-solicitudes-recibidas")
    public ModelAndView verMisSolicitudesRecibidas(HttpSession session) {
        Usuario usuarioEnSesion = (Usuario) session.getAttribute("usuarioEnSesion");
        if (usuarioEnSesion == null)
            return new ModelAndView("redirect:/login");

        List<Solicitud> activas = solicitudServicio.obtenerSolicitudesPorProveedor(usuarioEnSesion).stream()
                .filter(s -> s.getEstado().equals("Enviada") || s.getEstado().equals("Aceptada"))
                .toList();

        List<Solicitud> inactivas = solicitudServicio.obtenerSolicitudesPorProveedor(usuarioEnSesion).stream()
                .filter(s -> s.getEstado().equals("Rechazada") || s.getEstado().equals("Completada")
                        || s.getEstado().equals("Cancelada"))
                .toList();

        Map<Long, Boolean> chatsCreados = new HashMap<>();
        for (Solicitud s : activas) {
            chatsCreados.put(s.getId(), repositorioChat.findBySolicitudId(s.getId()) != null);
        }

        ModelAndView mav = new ModelAndView("misSolicitudesRecibidas.jsp");
        mav.addObject("solicitudesActivas", activas);
        mav.addObject("solicitudesInactivas", inactivas);
        mav.addObject("chatsCreados", chatsCreados);
        return mav;
    }

    @PostMapping("/aceptar-solicitud")
    public String aceptarSolicitud(@RequestParam("solicitudId") Long solicitudId,
            RedirectAttributes redirectAttributes) {
        Solicitud solicitud = solicitudServicio.getSolicitudById(solicitudId);
        if (solicitud == null) {
            redirectAttributes.addFlashAttribute("error", "La solicitud no existe.");
        } else if (!"Enviado".equals(solicitud.getEstado())) {
            redirectAttributes.addFlashAttribute("error",
                    "La solicitud ya fue actualizada por otra acción. Se ha recargado la vista.");
        } else {
            solicitud.setEstado("Aceptada");
            solicitudServicio.guardarSolicitud(solicitud);

            // Notificar cambio de estado
            servicioNotificaciones.notificarCambioEstado(solicitud, "Aceptada");

            redirectAttributes.addFlashAttribute("success", "Solicitud aceptada correctamente.");
        }
        return "redirect:/mis-solicitudes-recibidas";
    }

    @PostMapping("/rechazar-solicitud")
    public String rechazarSolicitud(@RequestParam("solicitudId") Long solicitudId,
            RedirectAttributes redirectAttributes) {
        Solicitud solicitud = solicitudServicio.getSolicitudById(solicitudId);
        if (solicitud == null) {
            redirectAttributes.addFlashAttribute("error", "La solicitud no existe.");
        } else if (!"Enviada".equals(solicitud.getEstado())) {
            redirectAttributes.addFlashAttribute("error",
                    "La solicitud ya fue actualizada por otra acción. Se ha recargado la vista.");
        } else {
            solicitud.setEstado("Rechazada");
            solicitudServicio.guardarSolicitud(solicitud);

            servicioNotificaciones.notificarCambioEstado(solicitud, "Rechazada");

            redirectAttributes.addFlashAttribute("success", "Solicitud rechazada correctamente.");
        }
        return "redirect:/mis-solicitudes-recibidas";
    }

    @PostMapping("/cancelar-solicitud")
    public String cancelarSolicitud(@RequestParam("solicitudId") Long solicitudId,
            HttpSession session,
            RedirectAttributes redirectAttributes) {

        Solicitud solicitud = solicitudServicio.getSolicitudById(solicitudId);
        @SuppressWarnings("unused")
        Usuario usuario = (Usuario) session.getAttribute("usuarioEnSesion");

        if (solicitud == null) {
            redirectAttributes.addFlashAttribute("error", "La solicitud no existe.");
        } else if (!solicitud.getEstado().equals("Enviada") && !solicitud.getEstado().equals("Aceptada")) {
            redirectAttributes.addFlashAttribute("error",
                    "La solicitud ya fue actualizada por otra acción. Se ha recargado la vista.");
        } else {
            solicitud.setEstado("Cancelada");
            solicitudServicio.guardarSolicitud(solicitud);

            // Agregamos notificación al proveedor del servicio
            servicioNotificaciones.notificarCambioEstado(solicitud, "Cancelada");

            redirectAttributes.addFlashAttribute("success", "Solicitud cancelada correctamente.");
        }

        return "redirect:/mis-solicitudes-enviadas";
    }

    @PostMapping("/completar-solicitud")
    public String completarSolicitud(@RequestParam("solicitudId") Long solicitudId,
            RedirectAttributes redirectAttributes) {
        Solicitud solicitud = solicitudServicio.getSolicitudById(solicitudId);

        if (solicitud == null) {
            redirectAttributes.addFlashAttribute("error", "La solicitud no existe.");
        } else if ("Completada".equals(solicitud.getEstado())) {
            redirectAttributes.addFlashAttribute("error", "Esta solicitud ya fue marcada como completada.");
        } else if (!"Aceptada".equals(solicitud.getEstado())) {
            redirectAttributes.addFlashAttribute("error",
                    "La solicitud ya fue actualizada por otra acción. Se ha recargado la vista.");
        } else {
            solicitud.setEstado("Completada");
            solicitudServicio.guardarSolicitud(solicitud);

            servicioNotificaciones.notificarCambioEstado(solicitud, "Completada");

            redirectAttributes.addFlashAttribute("success", "Trabajo marcado como completado.");
        }

        return "redirect:/mis-solicitudes-recibidas";
    }

}
