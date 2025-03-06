package com.pablo.repositorios;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.pablo.modelos.Servicio;

@Repository
public interface RepositorioServicios extends CrudRepository<Servicio, Long>{

}
