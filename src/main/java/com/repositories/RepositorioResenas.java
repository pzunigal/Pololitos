package com.repositories;

import org.springframework.data.repository.CrudRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.models.Resena;

import java.util.List;

@Repository
public interface RepositorioResenas extends CrudRepository<Resena, Long> {

    @Query("SELECT r FROM Resena r WHERE r.servicio.id = :servicioId")
    List<Resena> findByServicioId(@Param("servicioId") Long servicioId);
    
}
