package com.servicios;

import com.modelos.Notificacion;
import com.modelos.Servicio;
import com.modelos.Solicitud;
import com.modelos.Usuario;
import com.repositorios.RepositorioNotificacionesFirebase;
import org.springframework.stereotype.Service;

import java.time.Instant;

@Service
public class ServicioNotificaciones {

    private final RepositorioNotificacionesFirebase repo;

    public ServicioNotificaciones(RepositorioNotificacionesFirebase repo) {
        this.repo = repo;
    }

    /* public void notificarNuevoMensaje(Long receptorId, String mensajePreview, String chatId) {
        Notificacion noti = new Notificacion(
                receptorId,
                "mensaje",
                "Nuevo mensaje: " + mensajePreview,
                "/chat/ver/" + chatId,
                Instant.now().toString()
        );
        repo.guardarNotificacion(noti);
    }

    public void notificarCambioEstado(Long receptorId, String estado, Long solicitudId) {
        String texto = switch (estado) {
            case "Aceptada" -> "Tu solicitud fue aceptada";
            case "Rechazada" -> "Tu solicitud fue rechazada";
            case "Cancelada" -> "Tu solicitud fue cancelada";
            case "Completada" -> "Tu solicitud fue completada";
            default -> "Tu solicitud cambió de estado";
        };

        Notificacion noti = new Notificacion(
                receptorId,
                "estado",
                texto,
                "/mis-solicitudes-enviadas",
                Instant.now().toString()
        );
        repo.guardarNotificacion(noti);
    } */

    public void notificarNuevaSolicitud(Solicitud solicitud) {
    Usuario solicitante = solicitud.getSolicitante();
    Servicio servicio = solicitud.getServicio();

    String texto = solicitante.getNombre() + " " + solicitante.getApellido() +
                   " ha solicitado tu servicio: " + servicio.getNombre();

    Notificacion noti = new Notificacion(
        servicio.getUsuario().getId(), // receptorId
        "solicitud",
        texto,
        "/mis-solicitudes-recibidas",
        Instant.now().toString(),
        solicitante.getId(),
        solicitante.getNombre() + " " + solicitante.getApellido(),
        servicio.getNombre(),
        servicio.getImgUrl()
    );

    repo.guardarNotificacion(noti);
}

    

    public void marcarNotificacionLeida(Long usuarioId, String notificacionId) {
        repo.marcarComoLeida(usuarioId, notificacionId);
    }
}
