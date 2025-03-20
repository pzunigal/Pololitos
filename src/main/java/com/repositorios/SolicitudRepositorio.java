package com.repositorios;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.modelos.Solicitud;

@Repository
public interface SolicitudRepositorio extends JpaRepository<Solicitud, Long> {
}
