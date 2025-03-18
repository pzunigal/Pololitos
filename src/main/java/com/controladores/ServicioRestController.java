package com.controladores;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.context.request.WebRequest;

import com.modelos.Servicio;
import com.servicios.ServicioServicios;

@RestController
@RequestMapping("/api/servicios")
public class ServicioRestController {

    @Autowired
    private ServicioServicios servicioServicios; // Tu servicio de negocio

    @DeleteMapping("/{id}")
    public ResponseEntity<String> eliminarServicio(@PathVariable("id") Long id, WebRequest request) {
        try {
            // Obtener el servicio a eliminar
            Servicio servicio = servicioServicios.obtenerPorId(id);
            if (servicio == null) {
                return ResponseEntity.status(404).body("Servicio no encontrado.");
            }

            // Aquí puedes validar que el servicio pertenece al usuario actual (o hacer otra
            // validación)
            // Si el servicio existe, proceder con la eliminación
            servicioServicios.eliminar(id);

            return ResponseEntity.ok("Servicio eliminado correctamente.");
        } catch (Exception e) {
            return ResponseEntity.status(500).body("Hubo un error al intentar eliminar el servicio.");
        }
    }
}
