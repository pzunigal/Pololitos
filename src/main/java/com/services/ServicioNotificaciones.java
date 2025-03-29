package com.services;

import com.models.Notificacion;
import com.models.Servicio;
import com.models.Solicitud;
import com.models.Usuario;
import com.repositories.RepositorioNotificacionesFirebase;

import org.springframework.stereotype.Service;

import java.time.Instant;

@Service
public class ServicioNotificaciones {

    private final RepositorioNotificacionesFirebase repo;

    public ServicioNotificaciones(RepositorioNotificacionesFirebase repo) {
        this.repo = repo;
    }

    public void notificarNuevaSolicitud(Solicitud solicitud) {
        Usuario solicitante = solicitud.getSolicitante();
        Servicio servicio = solicitud.getServicio();

        String texto = solicitante.getNombre() + " " + solicitante.getApellido() +
                " ha solicitado tu servicio: " + servicio.getNombre();

        Notificacion noti = new Notificacion(
                servicio.getUsuario().getId(), // receptorId
                "Solicitud",
                texto,
                "/mis-solicitudes-recibidas",
                Instant.now().toString(),
                solicitante.getId(),
                solicitante.getNombre() + " " + solicitante.getApellido(),
                servicio.getNombre(),
                servicio.getImgUrl());

        repo.guardarNotificacion(noti);
    }

    public void marcarNotificacionLeida(Long usuarioId, String notificacionId) {
        repo.marcarComoLeida(usuarioId, notificacionId);
    }

    public void notificarCambioEstado(Solicitud solicitud, String nuevoEstado) {
        String mensaje = switch (nuevoEstado) {
            case "Aceptada" -> "Tu solicitud fue aceptada";
            case "Rechazada" -> "Tu solicitud fue rechazada";
            case "Cancelada" -> "El usuario ha cancelado la solicitud";
            case "Completada" -> "El proveedor ha marcado la solicitud como completada";
            default -> "Tu solicitud cambió de estado";
        };

        Notificacion noti = Notificacion.crearCambioEstado(solicitud, nuevoEstado, mensaje);
        repo.guardarNotificacion(noti);
    }

    public void notificarConversacionIniciada(Solicitud solicitud, String chatId) {
        Usuario solicitante = solicitud.getSolicitante();
        Usuario proveedor = solicitud.getServicio().getUsuario();
        Servicio servicio = solicitud.getServicio();
    
        String mensaje = "El proveedor ha iniciado una conversación sobre tu solicitud.";
    
        Notificacion noti = new Notificacion(
                solicitante.getId(), // Receptor: el solicitante
                "Conversación Iniciada", // Tipo
                mensaje, // Mensaje
                "/chat/ver/" + chatId, // URL destino
                Instant.now().toString(), // Timestamp
                proveedor.getId(), // Emisor ID
                proveedor.getNombre() + " " + proveedor.getApellido(), // Nombre emisor
                servicio.getNombre(), // Nombre del servicio
                proveedor.getFotoPerfil() // ✅ Imagen del perfil del proveedor
        );
    
        repo.guardarNotificacion(noti);
    }
    

}
