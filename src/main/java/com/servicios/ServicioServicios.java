package com.servicios;

import java.util.List;
import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import com.modelos.Categoria;
import com.modelos.Servicio;
import com.modelos.Usuario;
import com.repositorios.RepositorioCategorias;
import com.repositorios.RepositorioServicios;
import jakarta.persistence.EntityNotFoundException;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;


@Service
public class ServicioServicios {

    @Autowired
    private RepositorioServicios repositorioServicios;
    @Autowired
    private RepositorioCategorias repositorioCategorias;

    public List<Categoria> obtenerCategoriasConServicios() {
        List<Categoria> categorias = repositorioCategorias.findAll();
        for (Categoria categoria : categorias) {
            List<Servicio> servicios = repositorioServicios.findByCategoria(categoria);
            categoria.setServicios(servicios); // Asegúrate de tener un `setServicios` en `Categoria`
        }
        
        // Ordenar las categorías por el tamaño de los servicios (de mayor a menor)
        categorias.sort((c1, c2) -> Integer.compare(c2.getServicios().size(), c1.getServicios().size()));
        
        return categorias;
    }



    public List<Servicio> obtenerTodosLosServicios() {
        return (List<Servicio>) repositorioServicios.findAll();
    }

    public boolean existsById(Long id) {
        return repositorioServicios.existsById(id); // Verifica si el servicio existe
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

    public List<Servicio> buscarPorNombre(String query) {
        return repositorioServicios.findByNombreContainingIgnoreCase(query);
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

    // Obtener los últimos servicios registrados
    public List<Servicio> obtenerUltimosServicios(int cantidad) {
        Pageable pageable = PageRequest.of(0, cantidad, Sort.by("id").descending());
        return repositorioServicios.findAll(pageable).getContent();
    }

    public List<Servicio> obtenerServiciosPorUsuario(Long usuarioId) {
        return repositorioServicios.findByUsuarioId(usuarioId);
    }
}
