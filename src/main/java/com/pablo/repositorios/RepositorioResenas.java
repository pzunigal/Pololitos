package com.pablo.repositorios;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.pablo.modelos.Resena;

@Repository
public interface RepositorioResenas extends CrudRepository<Resena, Long> {

    
}
