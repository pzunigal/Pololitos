package com.services;

import org.springframework.stereotype.Service;
import java.util.List;

import com.models.Resena;
import com.repositories.RepositorioResenas;

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