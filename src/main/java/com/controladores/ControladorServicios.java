package com.controladores;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.bind.annotation.ModelAttribute;
import com.modelos.Categoria;
import com.modelos.Servicio;
import com.modelos.Usuario;
import com.servicios.ServicioCategorias;
import com.servicios.ServicioCloudinary;
import com.servicios.ServicioServicios;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.List;

@Controller
public class ControladorServicios {

    @Autowired
    private ServicioServicios servicioServicios;

    @Autowired
    private ServicioCategorias servicioCategorias;

    @Autowired
    private ServicioCloudinary servicioCloudinary;

    private static final Logger logger = LoggerFactory.getLogger(ControladorServicios.class);

    @GetMapping("/servicios/publicar")
    public String mostrarFormulario(HttpSession session, Model model) {
        Usuario usuarioEnSesion = (Usuario) session.getAttribute("usuarioEnSesion");
        if (usuarioEnSesion == null) {
            return "redirect:/login";
        }
        List<Categoria> categorias = servicioCategorias.obtenerTodas();
        model.addAttribute("categorias", categorias);
        model.addAttribute("servicio", new Servicio());
        model.addAttribute("usuario", usuarioEnSesion);
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
            return "redirect:/login";
        }

        // Verificación de errores de validación de los campos del servicio
        if (result.hasErrors()) {
            logger.error("Errores de validación en el formulario: " + result.getAllErrors());
            List<Categoria> categorias = servicioCategorias.obtenerTodas();
            model.addAttribute("categorias", categorias);
            model.addAttribute("usuario", usuarioEnSesion);
            model.addAttribute("error", "Existen errores en los campos del formulario.");
            return "nuevoServicio.jsp";
        }

        // Verificación si no se sube una imagen
        if (file.isEmpty()) {
            logger.error("No se ha subido una imagen para el servicio.");
            List<Categoria> categorias = servicioCategorias.obtenerTodas();
            model.addAttribute("categorias", categorias);
            model.addAttribute("usuario", usuarioEnSesion);
            model.addAttribute("error", "Debe subir una imagen para el servicio.");
            return "nuevoServicio.jsp";
        }

        // Verificación del tamaño de la imagen (puedes ajustar el tamaño según tus necesidades)
        if (file.getSize() > 5000000) { // 5MB de límite de tamaño
            logger.error("La imagen subida es demasiado grande. Tamaño: " + file.getSize());
            List<Categoria> categorias = servicioCategorias.obtenerTodas();
            model.addAttribute("categorias", categorias);
            model.addAttribute("usuario", usuarioEnSesion);
            model.addAttribute("error", "La imagen es demasiado grande. El tamaño máximo permitido es 5MB.");
            return "nuevoServicio.jsp";
        }

        try {
            // Subir la imagen
            String imageUrl = servicioCloudinary.uploadFile(file);
            servicio.setFotoServicio(imageUrl);
        } catch (Exception e) {
            logger.error("Error al subir la imagen: " + e.getMessage());
            List<Categoria> categorias = servicioCategorias.obtenerTodas();
            model.addAttribute("categorias", categorias);
            model.addAttribute("usuario", usuarioEnSesion);
            model.addAttribute("error", "Error al subir la imagen: " + e.getMessage());
            return "nuevoServicio.jsp";
        }

        servicio.setUsuario(usuarioEnSesion);
        servicioServicios.guardar(servicio);
        logger.info("Servicio creado exitosamente: " + servicio.getNombre());

        return "redirect:/";
    }
}
