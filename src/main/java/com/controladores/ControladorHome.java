package com.controladores;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;


import com.modelos.Categoria;
import com.modelos.Servicio;
import com.modelos.Usuario;
import com.servicios.ServicioServicios;

import jakarta.servlet.http.HttpSession;

@Controller
public class ControladorHome {

    @Autowired
    private ServicioServicios servicioServicios;

    @GetMapping("/")
    public String index(Model model, HttpSession session) {
        List<Categoria> categorias = servicioServicios.obtenerCategoriasConServicios();
        model.addAttribute("categorias", categorias);

        List<Servicio> ultimosServicios = servicioServicios.obtenerUltimosServicios(8);
        model.addAttribute("ultimosServicios", ultimosServicios);

        // Obtener usuario en sesión
        Usuario usuarioEnSesion = (Usuario) session.getAttribute("usuarioEnSesion");
    
        // Pasar datos al modelo
        model.addAttribute("usuarioSesion", usuarioEnSesion); // Se envía el usuario en sesión
        return "home.jsp";
    }


    @GetMapping("/contacto")
    public String contacto() {
        return "contacto.jsp";
    }

    @GetMapping("/nosotros")
    public String nosotros() {
        return "nosotros.jsp";
    }
}
