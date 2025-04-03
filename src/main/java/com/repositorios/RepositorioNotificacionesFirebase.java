package com.repositorios;

import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.modelos.Notificacion;
import org.springframework.stereotype.Repository;

@Repository
public class RepositorioNotificacionesFirebase {

    private final DatabaseReference notificacionesRef;

    public RepositorioNotificacionesFirebase(FirebaseDatabase firebaseDatabase) {
        this.notificacionesRef = firebaseDatabase.getReference("notificaciones");
    }

    public void guardarNotificacion(Notificacion notificacion) {
        DatabaseReference refUsuario = notificacionesRef.child(notificacion.getReceptorId().toString());
        DatabaseReference nuevaNotiRef = refUsuario.push(); // Firebase genera ID único

        notificacion.setId(nuevaNotiRef.getKey());
        nuevaNotiRef.setValueAsync(notificacion);
    }

    public void marcarComoLeida(Long usuarioId, String notificacionId) {
        notificacionesRef.child(usuarioId.toString()).child(notificacionId).child("leida").setValueAsync(true);
    }

    public DatabaseReference getNotificacionesUsuario(Long usuarioId) {
        return notificacionesRef.child(usuarioId.toString());
    }
}
