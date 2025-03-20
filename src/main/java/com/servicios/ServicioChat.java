package com.servicios;

import org.springframework.stereotype.Service;
import com.modelos.Chat;
import com.modelos.Solicitud;
import com.modelos.Servicio;
import com.repositorios.RepositorioChatMySQL;
import com.repositorios.RepositorioChatNOSQL;
import java.util.concurrent.CompletableFuture;
import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.ValueEventListener;

@Service
public class ServicioChat {

    private final RepositorioChatNOSQL repositorioChatNOSQL;
    private final ServicioSolicitud servicioSolicitud;
    private final ServicioServicios servicioServicios;
    private final RepositorioChatMySQL repositorioChatMySQL;

    public ServicioChat(RepositorioChatNOSQL repositorioChatNOSQL, ServicioSolicitud servicioSolicitud,
            ServicioServicios servicioServicios, RepositorioChatMySQL repositorioChatMySQL
            ) {
        this.repositorioChatNOSQL = repositorioChatNOSQL;
        this.servicioSolicitud = servicioSolicitud;
        this.servicioServicios = servicioServicios;
        this.repositorioChatMySQL = repositorioChatMySQL;
    }

    public Chat createChat(Chat chat) {
        // Obtener los detalles de la solicitud y servicio
        Solicitud solicitud = servicioSolicitud.getSolicitudById(chat.getSolicitudId());
        Servicio servicio = servicioServicios.obtenerPorId(solicitud.getServicio().getId());
    
        // Construir el nombre del chat
        String nombreChat = servicio.getNombre() + " | " + servicio.getUsuario().getNombre() + " | " + servicio.getCiudad();
        chat.setNombre(nombreChat);
    
        // Crear el chat en Firebase
        String generatedId = repositorioChatNOSQL.saveChat(chat);
        chat.setId(generatedId); // Asignar el ID generado por Firebase
    
        // Guardar el chat en MySQL (sin la lista de mensajes)
        repositorioChatMySQL.save(chat);
    
        return chat;
    }
    

    public CompletableFuture<Chat> getChat(String chatId) {
        CompletableFuture<Chat> future = new CompletableFuture<>();
        repositorioChatNOSQL.getChat(chatId, new ValueEventListener() {
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

    // En el servicio de chat
    public boolean existeChatParaSolicitud(Long solicitudId) {
        // Asumimos que tienes un repositorio de chat que permite obtener una
        // conversación por solicitudId
        Chat chat = repositorioChatMySQL.findBySolicitudId(solicitudId);
        return chat != null;
    }

}
