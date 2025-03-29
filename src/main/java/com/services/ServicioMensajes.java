package com.services;

import com.models.Mensaje;
import com.repositories.RepositorioMensajeFirebase;

import org.springframework.stereotype.Service;

@Service
public class ServicioMensajes {

    private final RepositorioMensajeFirebase repositorioMensajeFirebase;

    public ServicioMensajes(RepositorioMensajeFirebase repositorioMensajeFirebase) {
        this.repositorioMensajeFirebase = repositorioMensajeFirebase;
    }

    public void enviarMensaje(String chatId, Mensaje mensaje) {
        repositorioMensajeFirebase.guardarMensaje(chatId, mensaje);
    }
}
