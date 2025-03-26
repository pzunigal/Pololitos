package com.servicios;

import com.modelos.Mensaje;
import com.repositorios.RepositorioMensajeFirebase;
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
