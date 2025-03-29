package com.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.models.Resena;
import com.models.Servicio;
import com.repositories.RepositorioResena;

@Service
public class ServicioResena {

    @Autowired
    private RepositorioResena repositorioResena;

    public void guardar(Resena resena) {
        repositorioResena.save(resena);
    }

    public List<Resena> obtenerPorServicio(Servicio servicio) {
        return repositorioResena.findByServicioOrderByCreatedAtDesc(servicio);
    }

    public Double obtenerPromedioCalificacion(Servicio servicio) {
        return repositorioResena.obtenerPromedioPorServicio(servicio);
    }
    public Resena obtenerPorId(Long id) {
        return repositorioResena.findById(id).orElse(null);
    }
    
    public void eliminar(Long id) {
        repositorioResena.deleteById(id);
    }
    
}
