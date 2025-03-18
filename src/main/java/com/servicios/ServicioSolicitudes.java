package com.servicios;

import com.modelos.Solicitud;
import com.repositorios.RepositorioSolicitudes; 
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ServicioSolicitudes {

    @Autowired
    private RepositorioSolicitudes repositorioSolicitudes; 

    // Método para aceptar solicitud
    public boolean aceptarSolicitud(Long id) {
        // Lógica para aceptar la solicitud (cambiar el estado)
        Solicitud solicitud = repositorioSolicitudes.findById(id).orElse(null);
        if (solicitud != null) {
            solicitud.setEstado("ACEPTADA"); 
            repositorioSolicitudes.save(solicitud);
            return true;
        }
        return false;
    }

    // Método para rechazar solicitud
    public boolean rechazarSolicitud(Long id) {
        // Lógica para rechazar la solicitud (cambiar el estado)
        Solicitud solicitud = repositorioSolicitudes.findById(id).orElse(null); 
        if (solicitud != null) {
            solicitud.setEstado("RECHAZADA");  
            repositorioSolicitudes.save(solicitud); 
            return true;
        }
        return false;
    }
}
