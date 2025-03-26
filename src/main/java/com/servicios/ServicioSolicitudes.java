package com.servicios;

import com.modelos.Solicitud;
import com.repositorios.RepositorioSolicitud; 
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ServicioSolicitudes {

    @Autowired
    private RepositorioSolicitud repositorioSolicitud; 

    // Método para aceptar solicitud
    public boolean aceptarSolicitud(Long id) {
        // Lógica para aceptar la solicitud (cambiar el estado)
        Solicitud solicitud = repositorioSolicitud.findById(id).orElse(null);
        if (solicitud != null) {
            solicitud.setEstado("ACEPTADA"); 
            repositorioSolicitud.save(solicitud);
            return true;
        }
        return false;
    }

    // Método para rechazar solicitud
    public boolean rechazarSolicitud(Long id) {
        // Lógica para rechazar la solicitud (cambiar el estado)
        Solicitud solicitud = repositorioSolicitud.findById(id).orElse(null); 
        if (solicitud != null) {
            solicitud.setEstado("RECHAZADA");  
            repositorioSolicitud.save(solicitud); 
            return true;
        }
        return false;
    }
}
