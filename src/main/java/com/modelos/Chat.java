package com.modelos;

import java.util.Date;
import java.util.List;
import jakarta.persistence.*;
import org.springframework.format.annotation.DateTimeFormat;

public class Chat {  // ❌ Sin @Entity y @Table

    private Long id;
    private Solicitud solicitud;
    private List<Mensaje> mensajes;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date createdAt;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date updatedAt;

    public Chat() {
        this.createdAt = new Date();
        this.updatedAt = new Date();
    }

    // Getters y Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Solicitud getSolicitud() { return solicitud; }
    public void setSolicitud(Solicitud solicitud) { this.solicitud = solicitud; }

    public List<Mensaje> getMensajes() { return mensajes; }
    public void setMensajes(List<Mensaje> mensajes) { this.mensajes = mensajes; }

    public Date getCreatedAt() { return createdAt; }
    public Date getUpdatedAt() { return updatedAt; }
}
