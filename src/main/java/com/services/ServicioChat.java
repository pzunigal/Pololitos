package com.services;

import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.CompletableFuture;
import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.ValueEventListener;
import com.models.Chat;
import com.models.Mensaje;
import com.models.Servicio;
import com.models.Solicitud;
import com.repositories.RepositorioChatMySQL;
import com.repositories.RepositorioChatNOSQL;

@Service
public class ServicioChat {

    private final RepositorioChatNOSQL repositorioChatNOSQL;
    private final ServicioSolicitud servicioSolicitud;
    private final ServicioServicios servicioServicios;
    private final RepositorioChatMySQL repositorioChatMySQL;

    public ServicioChat(RepositorioChatNOSQL repositorioChatNOSQL, ServicioSolicitud servicioSolicitud,
                        ServicioServicios servicioServicios, RepositorioChatMySQL repositorioChatMySQL) {
        this.repositorioChatNOSQL = repositorioChatNOSQL;
        this.servicioSolicitud = servicioSolicitud;
        this.servicioServicios = servicioServicios;
        this.repositorioChatMySQL = repositorioChatMySQL;
    }

    public Chat createChat(Chat chat) {
        Solicitud solicitud = servicioSolicitud.getSolicitudById(chat.getSolicitudId());
        Servicio servicio = servicioServicios.obtenerPorId(solicitud.getServicio().getId());

        String nombreChat = servicio.getNombre() + " | " + servicio.getUsuario().getNombre() + " | " + servicio.getCiudad();
        chat.setNombre(nombreChat);

        String generatedId = repositorioChatNOSQL.saveChat(chat);
        chat.setId(generatedId);

        repositorioChatMySQL.save(chat);
        return chat;
    }

    public CompletableFuture<Chat> getChat(String chatId) {
        CompletableFuture<Chat> future = new CompletableFuture<>();

        repositorioChatNOSQL.getChat(chatId, new ValueEventListener() {
            @Override
            public void onDataChange(DataSnapshot snapshot) {
                if (!snapshot.exists()) {
                    future.complete(null);
                    return;
                }

                Chat chat = new Chat();
                chat.setId(snapshot.child("id").getValue(String.class));
                chat.setNombre(snapshot.child("nombre").getValue(String.class));
                chat.setFechaCreacion(snapshot.child("fechaCreacion").getValue(Long.class));
                chat.setSolicitanteId(snapshot.child("solicitanteId").getValue(Long.class));
                chat.setSolicitudId(snapshot.child("solicitudId").getValue(Long.class));

                List<Mensaje> mensajes = new ArrayList<>();
                DataSnapshot mensajesSnapshot = snapshot.child("mensajes");
                for (DataSnapshot mensajeSnapshot : mensajesSnapshot.getChildren()) {
                    Mensaje mensaje = mensajeSnapshot.getValue(Mensaje.class);
                    mensajes.add(mensaje);
                }
                chat.setMensajes(mensajes);

                future.complete(chat);
            }

            @Override
            public void onCancelled(DatabaseError error) {
                future.completeExceptionally(error.toException());
            }
        });

        return future;
    }

    public boolean existeChatParaSolicitud(Long solicitudId) {
        return repositorioChatMySQL.findBySolicitudId(solicitudId) != null;
    }

    public boolean existeConversacion(Long solicitudId) {
        return repositorioChatMySQL.findBySolicitudId(solicitudId) != null;
    }

    public Chat getChatBySolicitudId(Long solicitudId) {
        return repositorioChatMySQL.findBySolicitudId(solicitudId);
    }
}
