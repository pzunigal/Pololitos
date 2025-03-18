package com.servicios;

import java.util.List;
import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.modelos.Categoria;
import com.modelos.Servicio;
import com.modelos.Usuario;
import com.repositorios.RepositorioServicios;

import jakarta.persistence.EntityNotFoundException;

@Service
public class ServicioServicios {

    @Autowired
    private RepositorioServicios repositorioServicios;

    public List<Servicio> obtenerTodosLosServicios() {
        return (List<Servicio>) repositorioServicios.findAll();
    }

    public Servicio obtenerPorId(Long id) {
    return repositorioServicios.findById(id)
            .orElseThrow(() -> new EntityNotFoundException("Servicio con ID " + id + " no encontrado"));
}

    public Servicio guardar(Servicio servicio) {
        return repositorioServicios.save(servicio);
    }

    public void eliminar(Long id) {
        repositorioServicios.deleteById(id);
    }

    public List<Servicio> buscarPorNombre(String nombre) {
        return repositorioServicios.findByNombreContainingIgnoreCase(nombre);
    }

    public List<Servicio> buscarPorUsuario(Usuario usuario) {
        return repositorioServicios.findByUsuario(usuario);
    }

    public List<Servicio> buscarPorCategoria(Categoria categoria) {
        return repositorioServicios.findByCategoria(categoria);
    }

    public List<Servicio> buscarPorPrecio(Double precio) {
        return repositorioServicios.findByPrecioLessThanEqual(precio);
    }

    public void solicitarServicio(Long servicioId, Usuario usuario) {
        Optional<Servicio> servicio = repositorioServicios.findById(servicioId);
        if (servicio.isPresent()) {
            Servicio servicioEncontrado = servicio.get();
            servicioEncontrado.setUsuario(usuario);
            repositorioServicios.save(servicioEncontrado);
        }
    }
}
