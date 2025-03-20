package com.controladores;

import com.servicios.ServicioMensaje;
import com.modelos.Mensaje;
import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.ValueEventListener;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.CompletableFuture;

@Controller
public class ControladorMensaje {

    private final ServicioMensaje servicioMensaje;

    public ControladorMensaje(ServicioMensaje servicioMensaje) {
        this.servicioMensaje = servicioMensaje;
    }

    // Guardar un nuevo mensaje
    @PostMapping("/crear-mensaje")
    public ResponseEntity<String> createMensaje(@RequestBody Mensaje mensaje) {
        try {
            String mensajeId = "mensaje-" + System.currentTimeMillis(); // Generar un ID único
            mensaje.setId(mensajeId);
            servicioMensaje.saveMensaje(mensajeId, mensaje);
            return ResponseEntity.ok("Mensaje guardado con éxito en Firebase!");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Error guardando el mensaje: " + e.getMessage());
        }
    }

    // Obtener los mensajes de un chat por ID
    @GetMapping("/chat-mensajes/{chatId}")
    public CompletableFuture<ResponseEntity<List<Mensaje>>> obtenerMensajes(@PathVariable String chatId) {
        // Usamos CompletableFuture para manejar la respuesta asincrónica
        CompletableFuture<ResponseEntity<List<Mensaje>>> future = new CompletableFuture<>();

        servicioMensaje.getMensajes(chatId, new ValueEventListener() {
            @Override
            public void onDataChange(DataSnapshot dataSnapshot) {
                List<Mensaje> mensajes = new ArrayList<>();
                // Verificamos si hay hijos en el DataSnapshot
                if (dataSnapshot.exists()) {
                    for (DataSnapshot snapshot : dataSnapshot.getChildren()) {
                        Mensaje mensaje = snapshot.getValue(Mensaje.class);
                        if (mensaje != null) {
                            mensajes.add(mensaje);
                        }
                    }
                }
                // Completar el CompletableFuture con la lista de mensajes
                future.complete(ResponseEntity.ok(mensajes));
            }

            @Override
            public void onCancelled(DatabaseError databaseError) {
                // Completar con la excepción si hay error
                future.completeExceptionally(databaseError.toException());
            }
        });

        return future;
    }
}
