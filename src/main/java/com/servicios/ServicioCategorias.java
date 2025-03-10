package com.servicios;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.modelos.Categoria;
import com.repositorios.RepositorioCategorias;

@Service
public class ServicioCategorias {
    @Autowired
    private RepositorioCategorias repositorioCategorias;

    //metodo para obtener todas las categorias: (se planea para mostrar todas las cateogiras en el formulario para que asi el usuario pueda seleccionar una opcion)
    public List<Categoria> obtenerTodas(){
        return (List<Categoria>) repositorioCategorias.findAll();
    }
}
