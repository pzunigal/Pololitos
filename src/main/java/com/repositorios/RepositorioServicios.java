package com.repositorios;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.modelos.Categoria;
import com.modelos.Servicio;
import com.modelos.Usuario;

@Repository
public interface RepositorioServicios extends CrudRepository<Servicio, Long>{
    
    //buscar servicios por nombre ignorando case(mayusculas y minusculas)
    List<Servicio> findByNombreContainingIgnoreCase(String nombre);

    //buscar servicio atraves de un usuario
    //servira para revisar el perfil de un usuario y visualizar todos los servicios que ofrece
    List<Servicio> findByUsuario(Usuario usuario);

    //servira para poder filtrar servicios con una categoria especifica seleccionada atraves de una interfaz interactiva de filtros
    List<Servicio> findByCategoria(Categoria categoria);

    //servira para buscar o filtrar servicios que tengan un precio menor o igual al filtro aplicado
    //a futuro se puede personalizar de distintas maneras con logica
    List<Servicio> findByPrecioLessThanEqual(Double precio);



    /*
    // Buscar servicios por categoría
    List<Servicio> findByCategoria(String categoria);
    
    // Buscar servicios ofrecidos por un usuario específico
    List<Servicio> findByOfrecidoPor(Usuario usuario);

    // Buscar servicios solicitados por un usuario específico
    List<Servicio> findBySolicitadoPor(Usuario usuario);*/
}
