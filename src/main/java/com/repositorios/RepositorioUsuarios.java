package com.repositorios;

import org.springframework.data.repository.CrudRepository;

import org.springframework.stereotype.Repository;

import com.modelos.Usuario;

@Repository
public interface RepositorioUsuarios extends CrudRepository<Usuario, Long> {
	
	Usuario findByEmail(String email);


	// no es necesaro aqui porque la logica de servicios se maneja en el repositorio de servicios


	/* List<Servicio> findByUsuarioId(@Param("usuarioId") Long usuarioId);

	List<Servicio> findByServiciosSolicitados_Id(@Param("usuarioId") Long usuarioId); */
}
