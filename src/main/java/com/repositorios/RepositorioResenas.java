package com.repositorios;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.modelos.Resena;

@Repository
public interface RepositorioResenas extends CrudRepository<Resena, Long> {

    
}
