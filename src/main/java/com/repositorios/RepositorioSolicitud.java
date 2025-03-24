package com.repositorios;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.modelos.Servicio;
import com.modelos.Solicitud;
import com.modelos.Usuario;

@Repository
public interface RepositorioSolicitud extends JpaRepository<Solicitud, Long> {
    List<Solicitud> findBySolicitante(Usuario solicitante);
    List<Solicitud> findAll();
    List<Solicitud> findByServicio_Usuario(Usuario usuario);
    List<Solicitud> findByServicio(Servicio servicio);

}
