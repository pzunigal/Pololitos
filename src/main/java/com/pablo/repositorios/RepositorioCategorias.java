package com.pablo.repositorios;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.pablo.modelos.Categoria;

@Repository
public interface RepositorioCategorias extends CrudRepository<Categoria, Long> {
    Categoria findByNombre(String nombre);
}
