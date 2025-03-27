
package com.modelos;

import java.time.Instant;

public class Notificacion {
    private String id; // ID autogenerado por Firebase
    private Long receptorId; // Usuario que recibe la notificación
    private String tipo; // Tipo de notificación: "mensaje", "solicitud", "estado"
    private String mensaje; // Texto visible al usuario
    private String urlDestino; // URL a la que se redirige al hacer click
    private boolean leida = false; // Si el usuario ya la vio
    private String timestamp; // Fecha/hora en formato ISO-8601
    private Long emisorId;
    private String nombreEmisor;

    private String nombreServicio;
    private String imagenServicio;

    public Notificacion() {
    }

    public Notificacion(Long receptorId, String tipo, String mensaje, String urlDestino, String timestamp,
                    Long emisorId, String nombreEmisor, String nombreServicio, String imagenServicio) {
    this.receptorId = receptorId;
    this.tipo = tipo;
    this.mensaje = mensaje;
    this.urlDestino = urlDestino;
    this.timestamp = timestamp;
    this.leida = false;
    this.emisorId = emisorId;
    this.nombreEmisor = nombreEmisor;
    this.nombreServicio = nombreServicio;
    this.imagenServicio = imagenServicio;
}
    
public static Notificacion crearCambioEstado(Solicitud solicitud, String estado, String mensaje) {
    Usuario solicitante = solicitud.getSolicitante();
    Usuario proveedor = solicitud.getServicio().getUsuario();
    Servicio servicio = solicitud.getServicio();

    Long receptorId;
    Long emisorId;
    String nombreEmisor;
    String urlDestino;

    if (estado.equals("Cancelada")) {
        receptorId = proveedor.getId(); // Le llega al proveedor
        emisorId = solicitante.getId();
        nombreEmisor = solicitante.getNombre() + " " + solicitante.getApellido();
        urlDestino = "/mis-solicitudes-recibidas";
    } else {
        receptorId = solicitante.getId(); // Le llega al solicitante
        emisorId = proveedor.getId();
        nombreEmisor = proveedor.getNombre() + " " + proveedor.getApellido();
        urlDestino = "/mis-solicitudes-enviadas";
    }

    return new Notificacion(
        receptorId,
        "Cambio de Estado",
        mensaje + " para el servicio: " + servicio.getNombre(),
        urlDestino,
        Instant.now().toString(),
        emisorId,
        nombreEmisor,
        servicio.getNombre(),
        servicio.getImgUrl()
    );
}


    // Getters y Setters

    

    public String getNombreServicio() {
        return nombreServicio;
    }

    public Long getEmisorId() {
        return emisorId;
    }

    public void setEmisorId(Long emisorId) {
        this.emisorId = emisorId;
    }

    public String getNombreEmisor() {
        return nombreEmisor;
    }

    public void setNombreEmisor(String nombreEmisor) {
        this.nombreEmisor = nombreEmisor;
    }

    public void setNombreServicio(String nombreServicio) {
        this.nombreServicio = nombreServicio;
    }

    public String getImagenServicio() {
        return imagenServicio;
    }

    public void setImagenServicio(String imagenServicio) {
        this.imagenServicio = imagenServicio;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public Long getReceptorId() {
        return receptorId;
    }

    public void setReceptorId(Long receptorId) {
        this.receptorId = receptorId;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public String getMensaje() {
        return mensaje;
    }

    public void setMensaje(String mensaje) {
        this.mensaje = mensaje;
    }

    public String getUrlDestino() {
        return urlDestino;
    }

    public void setUrlDestino(String urlDestino) {
        this.urlDestino = urlDestino;
    }

    public boolean isLeida() {
        return leida;
    }

    public void setLeida(boolean leida) {
        this.leida = leida;
    }

    public String getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(String timestamp) {
        this.timestamp = timestamp;
    }
}
