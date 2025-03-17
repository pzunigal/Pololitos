package com.repositorios;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.modelos.Categoria;

@Repository
public interface RepositorioCategorias extends CrudRepository<Categoria, Long> {
    Categoria findByNombre(String nombre);


    //metodo para obtener todas las categorias:
    @SuppressWarnings("null")
    List<Categoria> findAll();
}
