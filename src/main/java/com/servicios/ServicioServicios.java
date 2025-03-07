package com.servicios;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.modelos.Servicio;
import com.modelos.Usuario;
import com.repositorios.RepositorioServicios;

@Service
public class ServicioServicios {
    
     @Autowired
    private RepositorioServicios repositorioServicios;

    /* 
    // Obtener todos los servicios
    public List<Servicio> obtenerTodosLosServicios() {
        return (List<Servicio>) repositorioServicios.findAll();
    }

    // Obtener un servicio por id
    public Servicio obtenerServicioPorId(Long id) {
        return repositorioServicios.findById(id).orElse(null);
    }

    // Solicitar un servicio (requiere inicio de sesión)
    public void solicitarServicio(Long servicioId, Usuario usuario) {
        Optional<Servicio> servicio = repositorioServicios.findById(servicioId);

        if (servicio.isPresent()) {
            Servicio servicioEncontrado = servicio.get();
            servicioEncontrado.setUsuario(usuario);
            repositorioServicios.save(servicioEncontrado);
        }
    }
        */
}
