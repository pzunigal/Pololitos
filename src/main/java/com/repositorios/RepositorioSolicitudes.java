package com.repositorios;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.modelos.Solicitud;

@Repository
public interface RepositorioSolicitudes extends CrudRepository<Solicitud, Long> {
}
