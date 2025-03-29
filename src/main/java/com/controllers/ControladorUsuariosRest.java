package com.controllers;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import com.models.LoginUsuario;
import com.models.Servicio;
import com.models.Usuario;
import com.services.ServicioCloudinary;
import com.services.ServicioServicios;
import com.services.ServicioUsuarios;

import jakarta.validation.Valid;

@RestController
@RequestMapping("/api/usuarios")
@CrossOrigin(origins = "http://localhost:3000")
public class ControladorUsuariosRest {

    @Autowired
    private ServicioUsuarios servicioUsuarios;

    @Autowired
    private ServicioServicios servicioServicios;

    @Autowired
    private ServicioCloudinary servicioCloudinary;

    @PostMapping("/registro")
    public ResponseEntity<?> registrarUsuario(@Valid @ModelAttribute Usuario nuevoUsuario,
                                              BindingResult result,
                                              @RequestParam(value = "fotoPerfilArchivo", required = false) MultipartFile fotoPerfilArchivo) {
        if (fotoPerfilArchivo != null && !fotoPerfilArchivo.isEmpty()) {
            try {
                String url = servicioCloudinary.subirArchivo(fotoPerfilArchivo, "profile-images");
                nuevoUsuario.setFotoPerfil(url);
            } catch (IOException e) {
                return ResponseEntity.badRequest().body("Error al subir la imagen de perfil.");
            }
        }

        Usuario usuarioGuardado = servicioUsuarios.registrarUsuario(nuevoUsuario, result);
        if (result.hasErrors() || usuarioGuardado == null) {
            return ResponseEntity.badRequest().body("Error al registrar usuario.");
        }

        return ResponseEntity.ok(usuarioGuardado);
    }

    @PostMapping("/login")
    public ResponseEntity<?> iniciarSesion(@Valid @RequestBody LoginUsuario loginUsuario,
                                           BindingResult result) {
        Usuario usuario = servicioUsuarios.login(loginUsuario, result);
        if (result.hasErrors() || usuario == null) {
            return ResponseEntity.status(401).body("Credenciales inválidas.");
        }

        return ResponseEntity.ok(usuario);
    }

    @GetMapping("/{usuarioId}/perfil")
    public ResponseEntity<?> obtenerPerfil(@PathVariable Long usuarioId) {
        Usuario usuario = servicioUsuarios.buscarUsuarioPorId(usuarioId);
        if (usuario == null) {
            return ResponseEntity.notFound().build();
        }

        List<Servicio> serviciosUsuario = servicioServicios.obtenerServiciosPorUsuario(usuario.getId());
        return ResponseEntity.ok(new PerfilUsuarioResponse(usuario, serviciosUsuario));
    }

    @PatchMapping("/{usuarioId}/perfil")
    @Transactional
    public ResponseEntity<?> actualizarPerfil(@PathVariable Long usuarioId,
                                              @ModelAttribute Usuario usuario,
                                              BindingResult result,
                                              @RequestParam(value = "fotoPerfilArchivo", required = false) MultipartFile nuevaImagen) {
        Usuario usuarioEnSesion = servicioUsuarios.buscarUsuarioPorId(usuarioId);
        if (usuarioEnSesion == null) {
            return ResponseEntity.status(401).body("Usuario no encontrado.");
        }

        if (result.hasErrors()) {
            return ResponseEntity.badRequest().body("Errores en los datos.");
        }

        if (nuevaImagen != null && !nuevaImagen.isEmpty()) {
            try {
                if (usuarioEnSesion.getFotoPerfil() != null) {
                    servicioCloudinary.eliminarArchivo(usuarioEnSesion.getFotoPerfil());
                }
                String nuevaUrl = servicioCloudinary.subirArchivo(nuevaImagen, "profile-images");
                usuarioEnSesion.setFotoPerfil(nuevaUrl);
            } catch (IOException e) {
                return ResponseEntity.badRequest().body("Error al actualizar imagen de perfil.");
            }
        }

        usuarioEnSesion.setNombre(usuario.getNombre());
        usuarioEnSesion.setApellido(usuario.getApellido());
        usuarioEnSesion.setTelefono(usuario.getTelefono());
        usuarioEnSesion.setCiudad(usuario.getCiudad());

        servicioUsuarios.actualizarUsuario(usuarioEnSesion);
        return ResponseEntity.ok(usuarioEnSesion);
    }

    // Clase interna para estructurar la respuesta del perfil
    public static class PerfilUsuarioResponse {
        private Usuario usuario;
        private List<Servicio> servicios;

        public PerfilUsuarioResponse(Usuario usuario, List<Servicio> servicios) {
            this.usuario = usuario;
            this.servicios = servicios;
        }

        public Usuario getUsuario() {
            return usuario;
        }

        public List<Servicio> getServicios() {
            return servicios;
        }
    }
}
