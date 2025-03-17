package com.controladores;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ModelAttribute;
import com.modelos.Categoria;
import com.modelos.Servicio;
import com.modelos.Usuario;
import com.servicios.ServicioCategorias;
import com.servicios.ServicioServicios;
import jakarta.servlet.http.HttpSession;
import jakarta.transaction.Transactional;
import jakarta.validation.Valid;

import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Controller
public class ControladorServicios {

    @Autowired
    private ServicioServicios servicioServicios;

    @Autowired
    private ServicioCategorias servicioCategorias;

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
            @RequestParam("imgUrl") String imgUrl,
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

        if (imgUrl.isBlank()) {
            model.addAttribute("error", "Debe ingresar una URL para la imagen.");
            return "nuevoServicio.jsp";
        }

        // Validación de la URL
        if (!esUrlValida(imgUrl)) {
            model.addAttribute("error", "La URL de la imagen debe terminar en .png, .jpg o .jpeg.");
            return "nuevoServicio.jsp";
        }

        servicio.setImgUrl(imgUrl);
        servicio.setUsuario(usuarioEnSesion);
        servicioServicios.guardar(servicio);
        return "redirect:/";
    }

    // Método para validar que la URL termina con .png, .jpg o .jpeg
    private boolean esUrlValida(String url) {
        String regex = "^(https?:\\/\\/)?([a-z0-9]+[.])*[a-z0-9-]+\\.[a-z]+(\\/[^\\s]*)*(\\.png|\\.jpg|\\.jpeg)$";
        Pattern pattern = Pattern.compile(regex, Pattern.CASE_INSENSITIVE);
        Matcher matcher = pattern.matcher(url);
        return matcher.matches();
    }

    @GetMapping("/mis-servicios")
    public String verMisServicios(HttpSession session, Model model) {
        // Verificar si el usuario está logueado
        Usuario usuarioEnSesion = (Usuario) session.getAttribute("usuarioEnSesion");
        if (usuarioEnSesion == null) {
            return "redirect:/login"; // Redirigir a login si no está logueado
        }

        // Obtener los servicios del usuario logueado
        List<Servicio> servicios = servicioServicios.buscarPorUsuario(usuarioEnSesion);
        model.addAttribute("servicios", servicios);
        return "verMisServicios.jsp"; // Mostrar los servicios del usuario en esta vista
    }
}
