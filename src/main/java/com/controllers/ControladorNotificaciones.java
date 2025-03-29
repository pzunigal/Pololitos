package com.controllers;

import org.springframework.web.bind.annotation.*;

import com.services.ServicioNotificaciones;

@RestController
public class ControladorNotificaciones {

    private final ServicioNotificaciones servicioNotificaciones;

    public ControladorNotificaciones(ServicioNotificaciones servicioNotificaciones) {
        this.servicioNotificaciones = servicioNotificaciones;
    }

    @PatchMapping("/notificaciones/marcar-leida/{usuarioId}/{notificacionId}")
    public void marcarComoLeida(@PathVariable Long usuarioId, @PathVariable String notificacionId) {
        servicioNotificaciones.marcarNotificacionLeida(usuarioId, notificacionId);
    }
}
