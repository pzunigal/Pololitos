package com.servicios;

import org.springframework.stereotype.Service;
import java.util.List;

import com.modelos.Resena;
import com.repositorios.RepositorioResenas;

@Service
public class ServicioResenas {
    private final RepositorioResenas repositorioResenas;

    public ServicioResenas(RepositorioResenas repositorioResenas) {
        this.repositorioResenas = repositorioResenas;
    }

    public List<Resena> getResenasByServicio(Long servicioId) {
        return repositorioResenas.findByServicioId(servicioId);
    }

    public Resena createResena(Resena resena) {
        return repositorioResenas.save(resena);
    }
}