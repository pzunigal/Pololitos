package com.servicios;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.modelos.Solicitud;
import com.modelos.Usuario;
import com.repositorios.SolicitudRepositorio;

@Service
public class SolicitudServicio {

    @Autowired
    private SolicitudRepositorio solicitudRepositorio;

    // Guardar solicitud
    public void guardarSolicitud(Solicitud solicitud) {
        solicitudRepositorio.save(solicitud);
    }

    // Obtener solicitudes enviadas por un usuario
    public List<Solicitud> obtenerSolicitudesPorSolicitante(Usuario solicitante) {
        return solicitudRepositorio.findBySolicitante(solicitante);
    }
}
