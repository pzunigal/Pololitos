package com.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.models.Servicio;
import com.models.Solicitud;
import com.models.Usuario;

@Repository
public interface RepositorioSolicitud extends JpaRepository<Solicitud, Long> {
    List<Solicitud> findBySolicitante(Usuario solicitante);

    List<Solicitud> findAll();

    List<Solicitud> findByServicio_Usuario(Usuario usuario);

    List<Solicitud> findByServicio(Servicio servicio);

    List<Solicitud> findBySolicitanteAndEstado(Usuario solicitante, String estado);

    List<Solicitud> findByServicio_UsuarioAndEstado(Usuario proveedor, String estado);

}
