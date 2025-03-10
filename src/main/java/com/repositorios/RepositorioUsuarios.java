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

	// no es necesaro aqui porque la logica de servicios se maneja en el repositorio de servicios

	
	/* List<Servicio> findByUsuarioId(@Param("usuarioId") Long usuarioId);

	List<Servicio> findByServiciosSolicitados_Id(@Param("usuarioId") Long usuarioId); */
}
