package com.servicios;

import com.repositorios.RepositorioMensaje;
import com.modelos.Mensaje;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.ValueEventListener;
import org.springframework.stereotype.Service;

@Service
public class ServicioMensaje {

    private final RepositorioMensaje repositorioMensaje;
    
    private FirebaseDatabase firebaseDatabase;

    public ServicioMensaje(RepositorioMensaje repositorioMensaje, FirebaseDatabase firebaseDatabase) {
            this.repositorioMensaje = repositorioMensaje;
            this.firebaseDatabase = firebaseDatabase;
    }

    public void saveMensaje(String mensajeId, Mensaje mensajeData) {
        repositorioMensaje.saveMensaje(mensajeId, mensajeData);
    }

    // Obtener mensaje desde Firebase
    public void getMensaje(String mensajeId, ValueEventListener listener) {
        repositorioMensaje.getMensaje(mensajeId, listener);
    }
    public void getMensajes(String chatId, ValueEventListener listener) {
        // Accedemos a la referencia de los mensajes del chat específico en Firebase
        firebaseDatabase.getReference("chats").child(chatId).child("mensajes")
            .addListenerForSingleValueEvent(listener);
    }
}
