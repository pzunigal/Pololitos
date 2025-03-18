package com.controladores;

import org.springframework.transaction.annotation.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;

import com.modelos.Categoria;
import com.modelos.Resena;
import com.modelos.Servicio;
import com.modelos.Usuario;
import com.servicios.ServicioCategorias;
import com.servicios.ServicioResenas;
import com.servicios.ServicioServicios;

import jakarta.persistence.EntityNotFoundException;
import jakarta.servlet.http.HttpSession;

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

    @Autowired
    private ServicioResenas servicioResenas;

    @GetMapping("/servicio/{id}/resenas")
    public String verResenas(@PathVariable("id") Long id, Model model) {
        Servicio servicio = servicioServicios.obtenerPorId(id);
        if (servicio == null ) {
            return "redirect:/";
        }

        List<Resena> resenas = servicioResenas.getResenasByServicio(id);
        model.addAttribute("servicio", servicio);
        model.addAttribute("resenas", resenas);
        return "verResenas.jsp";

    }

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
        return "redirect:/mis-servicios";
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

    @GetMapping("/editar-servicio/{id}")
    public String editarServicio(@PathVariable("id") Long id, HttpSession session, Model model) {
        Usuario usuarioEnSesion = (Usuario) session.getAttribute("usuarioEnSesion");
        if (usuarioEnSesion == null) {
            return "redirect:/login";
        }

        try {
            Servicio servicio = servicioServicios.obtenerPorId(id);

            if (!servicio.getUsuario().getId().equals(usuarioEnSesion.getId())) {
                return "redirect:/mis-servicios";
            }

            cargarDatosFormulario(model, usuarioEnSesion, servicio, null);
            model.addAttribute("servicio", servicio);
            return "editarServicio.jsp";
        } catch (EntityNotFoundException e) {
            return "redirect:/mis-servicios"; // Si no encuentra el servicio, redirige
        }
    }

    @PatchMapping("/actualizar-servicio/{id}")
    @Transactional
    public String actualizarServicio(@PathVariable("id") Long id,
            @Valid @ModelAttribute("servicio") Servicio servicio,
            BindingResult result,
            @RequestParam("imgUrl") String imgUrl,
            HttpSession session, Model model) {

        Usuario usuarioEnSesion = (Usuario) session.getAttribute("usuarioEnSesion");
        if (usuarioEnSesion == null) {
            return "redirect:/login";
        }

        // Buscar el servicio existente
        Servicio servicioExistente = servicioServicios.obtenerPorId(id);
        if (servicioExistente == null || !servicioExistente.getUsuario().getId().equals(usuarioEnSesion.getId())) {
            return "redirect:/mis-servicios";
        }

        // Validación del formulario
        if (result.hasErrors()) {
            model.addAttribute("error", "Existen errores en los campos del formulario.");
            model.addAttribute("servicio", servicioExistente);
            return "editarServicio.jsp";
        }

        // Validación de la URL de la imagen
        if (!esUrlValida(imgUrl)) {
            model.addAttribute("error", "La URL de la imagen debe terminar en .png, .jpg o .jpeg.");
            model.addAttribute("servicio", servicioExistente);
            return "editarServicio.jsp";
        }

        // Actualizar el servicio existente con los nuevos datos
        servicioExistente.setNombre(servicio.getNombre());
        servicioExistente.setDescripcion(servicio.getDescripcion());
        servicioExistente.setPrecio(servicio.getPrecio());
        servicioExistente.setCategoria(servicio.getCategoria());
        servicioExistente.setImgUrl(imgUrl);

        servicioServicios.guardar(servicioExistente); // Guardar los cambios
        return "redirect:/mis-servicios";
    }

    @PostMapping("/eliminar-servicio/{id}")
    @Transactional
    public String eliminarServicio(@PathVariable("id") Long id, Model model) {
        try {
            // Obtener el servicio a eliminar
            Servicio servicio = servicioServicios.obtenerPorId(id);
            if (servicio != null) {
                // Eliminar el servicio
                servicioServicios.eliminar(id);
            }
            // Redirigir de nuevo a la página de servicios
            return "redirect:/mis-servicios";
        } catch (Exception e) {
            // En caso de error, puedes redirigir a una página de error o mostrar un mensaje
            model.addAttribute("error", true);
            return "redirect:/mis-servicios";
        }
    }
    // Endpoint para ver los detalles completos de un servicio
    @GetMapping("/servicio/detalles/{id}")
    public String verDetallesServicio(@PathVariable("id") Long id, Model model) {
        // Obtener el servicio por su ID
        Servicio servicio = servicioServicios.obtenerPorId(id);

        // Si el servicio no existe, redirigir a la lista de servicios
        if (servicio == null) {
            return "redirect:/servicios";
        }

        // Pasar el servicio a la vista
        model.addAttribute("servicio", servicio);

        // Devolver la vista con el detalle del servicio
        return "verServicioCompleto.jsp";
    }

}
