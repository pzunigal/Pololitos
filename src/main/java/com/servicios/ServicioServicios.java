package com.servicios;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.modelos.Categoria;
import com.modelos.Servicio;
import com.modelos.Usuario;
import com.repositorios.RepositorioServicios;

@Service
public class ServicioServicios {

    // llamamos al repositorio
    @Autowired
    private RepositorioServicios repositorioServicios;

    // para obtener todos los servicios de manera general:
    public List<Servicio> obtenerTodosLosServicios() {
        return (List<Servicio>) repositorioServicios.findAll();
    }

    // obtener servicio por ID
    public Servicio obtenerPorId(Long id) {
        // optional porque un servicio puede no existir en ese momento, y con esto
        // evitamos errores
        Optional<Servicio> servicio = repositorioServicios.findById(id);
        return servicio.orElse(null);
    }

    // guardar o actualizar servicio
    public Servicio guardar(Servicio servicio) {
        return repositorioServicios.save(servicio);
    }

    // eliminar servicio por ID
    public void eliminar(Long id) {
        repositorioServicios.deleteById(id);
    }

    // buscar por nombre
    public List<Servicio> buscarPorNombre(String nombre) {
        return repositorioServicios.findByNombreContainingIgnoreCase(nombre);
    }

    // buscar por usuario
    public List<Servicio> buscarPorUsuario(Usuario usuario) {
        return repositorioServicios.findByUsuario(usuario);
    }

    // buscar por categoría
    public List<Servicio> buscarPorCategoria(Categoria categoria) {
        return repositorioServicios.findByCategoria(categoria);
    }

    // buscar por precio
    public List<Servicio> buscarPorPrecio(Double precio) {
        return repositorioServicios.findByPrecioLessThanEqual(precio);
    }


    // Solicitar un servicio (requiere inicio de sesión)
    public void solicitarServicio(Long servicioId, Usuario usuario) {
        //busca si existe el servicio
        Optional<Servicio> servicio = repositorioServicios.findById(servicioId);

        //si existe, se asigna el usuario que solicita el servicio
        if (servicio.isPresent()) {
            Servicio servicioEncontrado = servicio.get(); //obtiene el servicio
            servicioEncontrado.setUsuario(usuario); //asigna el usuario
            repositorioServicios.save(servicioEncontrado); //guarda el servicio con el usuario asignado
        }
    }
}
