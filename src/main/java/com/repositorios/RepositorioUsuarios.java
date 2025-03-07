package com.repositorios;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.modelos.Servicio;
import com.modelos.Usuario;

@Repository
public interface RepositorioUsuarios extends CrudRepository<Usuario, Long> {
	
	Usuario findByEmail(String email);

	List<Servicio> findServiciosOfrecidosPorUsuario(@Param("usuarioId") Long usuarioId);

	List<Servicio> findServiciosSolicitadosPorUsuario(@Param("usuarioId") Long usuarioId);
}
