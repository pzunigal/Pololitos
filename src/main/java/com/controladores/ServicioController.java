package com.controladores;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.modelos.Servicio;
import com.servicios.ServicioServicios;

@Controller
public class ServicioController {

    @Autowired
    private ServicioServicios servicioService;


    //COMENTANDO EN CASO DE SER INNECESARIO ESTA FUNCIONALIDAD PORQUE ESTA PRESENTE EN CONTROLADOR DASHBOARD

   /*  // obtener todos los servicios y mostrarlos en index.jsp
    @GetMapping("/")
    public String mostrarIndex(Model model) {
        List<Servicio> servicios = servicioService.obtenerTodosLosServicios();
        model.addAttribute("servicios", servicios); // pasamos la lista al modelo para renderizar en el archivo index.jsp
        return "index"; // Retorna index.jsp
    } */
}
