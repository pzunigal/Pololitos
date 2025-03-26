package com.modelos;

import java.util.Date;
import java.time.Instant;

public class Mensaje {
    private String id;
    private String contenido;
    private Long usuarioId;
    private String nombreUsuario; // ← NUEVO
    private String createdAt;

    public Mensaje() {
        this.createdAt = Date.from(Instant.now()).toInstant().toString();
    }

    public Mensaje(String contenido, Long usuarioId, String nombreUsuario) {
        this.contenido = contenido;
        this.usuarioId = usuarioId;
        this.nombreUsuario = nombreUsuario;
        this.createdAt = Date.from(Instant.now()).toInstant().toString();
    }

    // Getters y Setters
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getContenido() {
        return contenido;
    }

    public void setContenido(String contenido) {
        this.contenido = contenido;
    }

    public Long getUsuarioId() {
        return usuarioId;
    }

    public void setUsuarioId(Long usuarioId) {
        this.usuarioId = usuarioId;
    }

    public String getNombreUsuario() {
        return nombreUsuario;
    }

    public void setNombreUsuario(String nombreUsuario) {
        this.nombreUsuario = nombreUsuario;
    }

    public String getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }

    public Date getCreatedAtAsDate() {
        try {
            return Date.from(Instant.parse(createdAt));
        } catch (Exception e) {
            return null;
        }
    }
}
