package com.pablo.repositorios;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.pablo.modelos.Solicitud;

@Repository
public interface RepositorioSolicitudes extends CrudRepository<Solicitud, Long> {
}
