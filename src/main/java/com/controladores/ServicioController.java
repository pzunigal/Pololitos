package com.controladores;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.modelos.Categoria;
import com.modelos.Servicio;
import com.modelos.Usuario;
import com.servicios.ServicioCategorias;
import com.servicios.ServicioServicios;

import jakarta.validation.Valid;

@Controller
public class ServicioController {

    @Autowired
    private ServicioServicios servicioServicios;
    @Autowired
    private ServicioCategorias servicioCategorias;

    // endpoint para renderizar el formulario visual
    @GetMapping("/servicios/publicar")
    public String mostrarFormulario(Model model) {
        List<Categoria> categorias = servicioCategorias.obtenerTodas();
        model.addAttribute("categorias", categorias);
        model.addAttribute("servicio", new Servicio());
        return "testingFormAddService.jsp";
    }

    // endpoint para guardar el servicio
    @PostMapping("/servicios/publicar")
    public String crearServicio(@Valid @ModelAttribute("servicio") Servicio servicio,
            BindingResult result,
            @SessionAttribute("usuario") Usuario usuario,
            Model model) {
        if (result.hasErrors()) {
            List<Categoria> categorias = servicioCategorias.obtenerTodas();
            model.addAttribute("categorias", categorias);
            model.addAttribute("usuario", usuario); // para mantener el usuario en sesion incluso si tenemos errores
            return "testingFormAddService.jsp";
        }

        servicio.setUsuario(usuario); // Asigna el usuario de la sesión
        servicioServicios.guardar(servicio);
        return "redirect:/"; // de preferencia que rediriga ala vista personal de usuario donde ve unicamente
                             // sus servicios
    }

}
