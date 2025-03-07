package com.servicios;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.modelos.Servicio;
import com.repositorios.RepositorioServicios;

@Service
public class ServicioServicios {
    
    //llamamos al repositorio
    @Autowired
    private RepositorioServicios repositorioServicios;

    //para obtener todos los servicios de manera general:
    public List<Servicio> obtenerTodos(){
        return (List<Servicio>) repositorioServicios.findAll();
    }



}
