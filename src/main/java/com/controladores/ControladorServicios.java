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
import com.servicios.FileUploadService;
import com.servicios.ServicioCategorias;
import com.servicios.ServicioServicios;
import jakarta.servlet.http.HttpSession;
import jakarta.transaction.Transactional;
import jakarta.validation.Valid;

import java.util.List;

@Controller
public class ControladorServicios {

    @Autowired
    private ServicioServicios servicioServicios;

    @Autowired
    private ServicioCategorias servicioCategorias;

    @Autowired
    private FileUploadService fileUploadService;

    @GetMapping("/servicios/publicar")
    public String mostrarFormulario(HttpSession session, Model model) {
        Usuario usuarioEnSesion = (Usuario) session.getAttribute("usuarioEnSesion");
        if (usuarioEnSesion == null) {
            return "redirect:/login";
        }
        cargarDatosFormulario(model, usuarioEnSesion, new Servicio(), null);
        return "nuevoServicio.jsp";
    }

    private void cargarDatosFormulario(Model model, Usuario usuario, Servicio servicio, String error) {
        List<Categoria> categorias = servicioCategorias.obtenerTodas();
        model.addAttribute("categorias", categorias);
        model.addAttribute("usuario", usuario);
        model.addAttribute("servicio", servicio);
        if (error != null) {
            model.addAttribute("error", error);
        }
    }

    @PostMapping("/publicar")
    @Transactional
    public String crearServicio(@Valid @ModelAttribute("servicio") Servicio servicio,
            BindingResult result,
            @RequestParam("file") MultipartFile file,
            HttpSession session,
            Model model) {

        Usuario usuarioEnSesion = (Usuario) session.getAttribute("usuarioEnSesion");
        if (usuarioEnSesion == null) {
            return "redirect:/login";
        }

        if (result.hasErrors()) {
            model.addAttribute("error", "Existen errores en los campos del formulario.");
            return "nuevoServicio.jsp";
        }

        if (file.isEmpty()) {
            model.addAttribute("error", "Debe subir una imagen para el servicio.");
            return "nuevoServicio.jsp";
        }

        try {
            // Llamamos al controlador de subida para obtener la URL de la imagen
            String imageUrl = fileUploadService.uploadFile(file);
            if (imageUrl == null || imageUrl.isBlank()) {
                model.addAttribute("error", "No se pudo obtener la URL de la imagen.");
                return "nuevoServicio.jsp";
            }
            servicio.setImgUrl(imageUrl);
        } catch (Exception e) {
            model.addAttribute("error", "Error al subir la imagen: " + e.getMessage());
            return "nuevoServicio.jsp";
        }

        servicio.setUsuario(usuarioEnSesion);
        servicioServicios.guardar(servicio);
        return "redirect:/";
    }

}
