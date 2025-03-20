package com.servicios;

import org.springframework.stereotype.Service;
import com.modelos.Chat;
import com.modelos.Solicitud;
import com.modelos.Servicio;
import com.repositorios.RepositorioChat;
import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.ValueEventListener;
import java.util.concurrent.CompletableFuture;

@Service
public class ServicioChat {

    private final RepositorioChat repositorioChat;
    private final ServicioSolicitud servicioSolicitud;
    private final ServicioServicios servicioServicios;

    public ServicioChat(RepositorioChat repositorioChat, ServicioSolicitud servicioSolicitud, ServicioServicios servicioServicios) {
        this.repositorioChat = repositorioChat;
        this.servicioSolicitud = servicioSolicitud;
        this.servicioServicios = servicioServicios;
    }

    public Chat createChat(Chat chat) {
        // Obtener los detalles de la solicitud y servicio
        Solicitud solicitud = servicioSolicitud.getSolicitudById(chat.getSolicitudId());
        Servicio servicio = servicioServicios.obtenerPorId(solicitud.getServicio().getId());
        
        // Construir el nombre del chat
        String nombreChat = servicio.getNombre() + " | " + servicio.getUsuario().getNombre() + " | " + servicio.getCiudad();
        chat.setNombre(nombreChat);

        // Crear el chat en Firebase
        String generatedId = repositorioChat.saveChat(chat);
        chat.setId(generatedId);  // Asignar el ID generado por Firebase
        return chat;
    }

    public CompletableFuture<Chat> getChat(String chatId) {
        CompletableFuture<Chat> future = new CompletableFuture<>();
        repositorioChat.getChat(chatId, new ValueEventListener() {
            @Override
            public void onDataChange(DataSnapshot dataSnapshot) {
                Chat chat = dataSnapshot.getValue(Chat.class);
                future.complete(chat);
            }

            @Override
            public void onCancelled(DatabaseError databaseError) {
                future.completeExceptionally(databaseError.toException());
            }
        });
        return future;
    }
}
