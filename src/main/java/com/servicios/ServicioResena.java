package com.servicios;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.modelos.Resena;
import com.modelos.Servicio;
import com.repositorios.RepositorioResena;

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
}
