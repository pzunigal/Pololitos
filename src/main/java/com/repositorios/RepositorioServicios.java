package com.repositorios;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.modelos.Categoria;
import com.modelos.Servicio;
import com.modelos.Usuario;

@Repository
public interface RepositorioServicios extends JpaRepository<Servicio, Long> {
    
    // Buscar servicios por nombre ignorando case (mayúsculas y minúsculas)
    List<Servicio> findByNombreContainingIgnoreCase(String nombre);

    // Buscar servicios a través de un usuario
    // Servirá para revisar el perfil de un usuario y visualizar todos los servicios que ofrece
    List<Servicio> findByUsuario(Usuario usuario);

    // Servirá para filtrar servicios con una categoría específica seleccionada a través de una interfaz interactiva de filtros
    List<Servicio> findByCategoria(Categoria categoria);

    // Servirá para buscar o filtrar servicios que tengan un precio menor o igual al filtro aplicado
    // A futuro se puede personalizar de distintas maneras con lógica
    List<Servicio> findByPrecioLessThanEqual(Double precio);

    // Genera una lista que ordena los servicios por id de forma descendente
    // Servirá para mostrar los servicios más recientes primero en el home
    List<Servicio> findByOrderByIdDesc();

    // Servirá para buscar servicios a través de un usuario
    List<Servicio> findByUsuarioId(Long usuarioId);
}
