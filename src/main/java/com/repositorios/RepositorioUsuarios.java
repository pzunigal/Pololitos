package com.repositorios;

import org.springframework.data.repository.CrudRepository;

import org.springframework.stereotype.Repository;

import com.modelos.Usuario;

@Repository
public interface RepositorioUsuarios extends CrudRepository<Usuario, Long> {

	Usuario findByEmail(String email);
}
