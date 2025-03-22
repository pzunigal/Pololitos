package com.modelos;
import java.util.ArrayList;
import java.util.List;

@jakarta.persistence.Entity  // Indica que esta clase es una entidad JPA
public class Chat {
    
    @jakarta.persistence.Id  // Define el campo como clave primaria
    private String id;
    
    private String nombre;
    
    private long fechaCreacion;
    
    @jakarta.persistence.Transient  // No persistir esta propiedad en la base de datos
    private List<Mensaje> mensajes; 
    
    private Long solicitanteId;
    private Long solicitudId;

    // Constructor vacío
    public Chat() {
        this.mensajes = new ArrayList<>(); // Inicializa el array de mensajes vacío
    }

    // Constructor con parámetros
    public Chat(String id, String nombre, long fechaCreacion, List<Mensaje> mensajes, Long solicitanteId, Long solicitudId) {
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

    public long getFechaCreacion() {
        return fechaCreacion;
    }

    public void setFechaCreacion(long fechaCreacion) {
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
