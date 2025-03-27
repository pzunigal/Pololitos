
package com.modelos;

public class Notificacion {
    private String id; // ID autogenerado por Firebase
    private Long receptorId; // Usuario que recibe la notificación
    private String tipo; // Tipo de notificación: "mensaje", "solicitud", "estado"
    private String mensaje; // Texto visible al usuario
    private String urlDestino; // URL a la que se redirige al hacer click
    private boolean leida = false; // Si el usuario ya la vio
    private String timestamp; // Fecha/hora en formato ISO-8601
    private Long solicitanteId;
    private String nombreSolicitante;
    private String nombreServicio;
    private String imagenServicio;

    public Notificacion() {
    }

    public Notificacion(Long receptorId, String tipo, String mensaje, String urlDestino, String timestamp,
            Long solicitanteId, String nombreSolicitante, String nombreServicio, String imagenServicio) {
        this.receptorId = receptorId;
        this.tipo = tipo;
        this.mensaje = mensaje;
        this.urlDestino = urlDestino;
        this.timestamp = timestamp;
        this.leida = false;
        this.solicitanteId = solicitanteId;
        this.nombreSolicitante = nombreSolicitante;
        this.nombreServicio = nombreServicio;
        this.imagenServicio = imagenServicio;
    }

    // Getters y Setters

    public Long getSolicitanteId() {
        return solicitanteId;
    }

    public void setSolicitanteId(Long solicitanteId) {
        this.solicitanteId = solicitanteId;
    }

    public String getNombreSolicitante() {
        return nombreSolicitante;
    }

    public void setNombreSolicitante(String nombreSolicitante) {
        this.nombreSolicitante = nombreSolicitante;
    }

    public String getNombreServicio() {
        return nombreServicio;
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
