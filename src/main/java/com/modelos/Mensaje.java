package com.modelos;

import java.util.Date;
import jakarta.validation.constraints.NotBlank;
import org.springframework.format.annotation.DateTimeFormat;

public class Mensaje {  // ❌ Sin @Entity y @Table

    private Long id;

    @NotBlank(message = "El mensaje no puede estar vacío")
    private String contenido;

    private Chat chat;
    private Usuario usuario;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date createdAt;

    public Mensaje() {
        this.createdAt = new Date();
    }

    // Getters y Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getContenido() { return contenido; }
    public void setContenido(String contenido) { this.contenido = contenido; }

    public Chat getChat() { return chat; }
    public void setChat(Chat chat) { this.chat = chat; }

    public Usuario getUsuario() { return usuario; }
    public void setUsuario(Usuario usuario) { this.usuario = usuario; }

    public Date getCreatedAt() { return createdAt; }
}
