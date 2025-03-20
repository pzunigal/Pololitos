package com.modelos;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class Chat {
    private String id;
    private String nombre;
    private Date fechaCreacion;
    private List<Mensaje> mensajes; 
    private Long solicitanteId;
    private Long solicitudId;

    public Chat() {
        this.mensajes = new ArrayList<>(); // Inicializa el array de mensajes vacío
    }

    public Chat(String id, String nombre, Date fechaCreacion, List<Mensaje> mensajes, Long solicitanteId, Long solicitudId) {
        this.id = id;
        this.nombre = nombre;
        this.fechaCreacion = fechaCreacion;
        this.mensajes = mensajes;
        this.solicitanteId = solicitanteId;
        this.solicitudId = solicitudId;
    }

    // Getters y Setters
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public Date getFechaCreacion() {
        return fechaCreacion;
    }

    public void setFechaCreacion(Date fechaCreacion) {
        this.fechaCreacion = fechaCreacion;
    }

    public List<Mensaje> getMensajes() {
        return mensajes;
    }

    public void setMensajes(List<Mensaje> mensajes) {
        this.mensajes = mensajes;
    }

    public Long getSolicitanteId() {
        return solicitanteId;
    }

    public void setSolicitanteId(Long solicitanteId) {
        this.solicitanteId = solicitanteId;
    }

    public Long getSolicitudId() {
        return solicitudId;
    }

    public void setSolicitudId(Long solicitudId) {
        this.solicitudId = solicitudId;
    }
}
