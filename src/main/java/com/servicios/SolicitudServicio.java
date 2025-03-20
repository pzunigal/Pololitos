package com.servicios;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.modelos.Solicitud;
import com.repositorios.SolicitudRepositorio;

@Service
public class SolicitudServicio {

    @Autowired
    private SolicitudRepositorio solicitudRepositorio;

    public void guardarSolicitud(Solicitud solicitud) {
        solicitudRepositorio.save(solicitud);
    }
}
