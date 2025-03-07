package com.repositorios;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.modelos.Servicio;
import com.modelos.Usuario;

@Repository
public interface RepositorioServicios extends CrudRepository<Servicio, Long>{

    /*
    // Buscar servicios por categoría
    List<Servicio> findByCategoria(String categoria);
    
    // Buscar servicios ofrecidos por un usuario específico
    List<Servicio> findByOfrecidoPor(Usuario usuario);

    // Buscar servicios solicitados por un usuario específico
    List<Servicio> findBySolicitadoPor(Usuario usuario);*/
}
