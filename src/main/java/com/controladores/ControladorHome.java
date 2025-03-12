package com.controladores;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.servicios.ServicioServicios;

@Controller
public class ControladorHome {

    @Autowired
    private ServicioServicios servicioServicios;

    @GetMapping("/")
	public String index(Model model) {
		model.addAttribute("servicios", servicioServicios.obtenerTodosLosServicios());
		return "index.jsp";
	}
}
