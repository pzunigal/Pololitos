package com.controladores;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.modelos.Categoria;
import com.modelos.Servicio;
import com.modelos.Usuario;
import com.servicios.ServicioCategorias;
import com.servicios.ServicioCloudinary;
import com.servicios.ServicioServicios;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
public class ControladorServicios {

    @Autowired
    private ServicioServicios servicioServicios;
    @Autowired
    private ServicioCategorias servicioCategorias;
    @Autowired
    private ServicioCloudinary servicioCloudinary;

    // endpoint para renderizar el formulario visual
    @GetMapping("/servicios/publicar")
    public String mostrarFormulario(HttpSession session, Model model) {
        Usuario usuarioEnSesion = (Usuario) session.getAttribute("usuarioEnSesion");

        if (usuarioEnSesion == null) {
            return "redirect:/login"; // Si no hay usuario en sesión, redirigir al login
        }

        List<Categoria> categorias = servicioCategorias.obtenerTodas();
        model.addAttribute("categorias", categorias);
        model.addAttribute("servicio", new Servicio());
        model.addAttribute("usuario", usuarioEnSesion); // Agregar el usuario en sesión al modelo
        return "nuevoServicio.jsp";
    }

    @PostMapping("/publicar")
    public String crearServicio(@Valid @ModelAttribute("servicio") Servicio servicio,
                                BindingResult result,
                                @RequestParam("fotoServicio") MultipartFile file,
                                HttpSession session,
                                Model model) {
        Usuario usuarioEnSesion = (Usuario) session.getAttribute("usuarioEnSesion");

        if (usuarioEnSesion == null) {
            return "redirect:/login"; // Asegurar que hay un usuario en sesión
        }

        if (result.hasErrors()) {
            List<Categoria> categorias = servicioCategorias.obtenerTodas();
            model.addAttribute("categorias", categorias);
            model.addAttribute("usuario", usuarioEnSesion);
            return "nuevoServicio.jsp";
        }

        // Subir imagen a Cloudinary
        try {
            String imageUrl = servicioCloudinary.uploadFile(file);
            servicio.setFotoServicio(imageUrl); // Guardamos la URL en el campo 'fotoServicio'
        } catch (IOException e) {
            model.addAttribute("error", "Error al subir la imagen");
            return "nuevoServicio.jsp";
        }

        servicio.setUsuario(usuarioEnSesion);
        servicioServicios.guardar(servicio);

        return "redirect:/perfilUsuario";
    }
}