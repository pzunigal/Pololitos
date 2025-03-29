package com.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.models.Resena;
import com.models.Servicio;

public interface RepositorioResena extends JpaRepository<Resena, Long> {

    List<Resena> findByServicioOrderByCreatedAtDesc(Servicio servicio);

    @Query("SELECT AVG(r.calificacion) FROM Resena r WHERE r.servicio = :servicio")
    Double obtenerPromedioPorServicio(Servicio servicio);
}
