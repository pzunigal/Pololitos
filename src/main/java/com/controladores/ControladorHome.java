package com.controladores;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.modelos.Categoria;
import com.modelos.Servicio;
import com.modelos.Usuario;
import com.servicios.ServicioServicios;

@Controller
public class ControladorHome {

    @Autowired
    private ServicioServicios servicioServicios;

    @GetMapping("/")
    public String home(){
        return "home.jsp";
    }

    @GetMapping("/servicios")
	public String index(Model model) {
		model.addAttribute("servicios", servicioServicios.obtenerTodosLosServicios());
		return "servicios.jsp";
	}

    @GetMapping("/contacto")
    public String contacto() {
        return "contacto.jsp";
    }

    @GetMapping("/nosotros")
    public String nosotros() {
        return "nosotros.jsp";
    }

	// Método para manejar la búsqueda con filtros
    @GetMapping("/buscar")
    public String buscar(
        @RequestParam(value = "nombre", required = false) String nombre,
        @RequestParam(value = "usuario", required = false) Usuario usuario,
        @RequestParam(value = "categoria", required = false) Categoria categoria,
        @RequestParam(value = "precio", required = false) Double precio,
        Model model
    ) {
        List<Servicio> serviciosEncontrados = new ArrayList<>();

        // Filtrar por nombre
        if (nombre != null && !nombre.isEmpty()) {
            serviciosEncontrados = servicioServicios.buscarPorNombre(nombre);
        }

        // Filtrar por categoría
        if (categoria != null) {
            serviciosEncontrados.addAll(servicioServicios.buscarPorCategoria(categoria));
        }

        // Filtrar por precio
        if (precio != null) {
            serviciosEncontrados.addAll(servicioServicios.buscarPorPrecio(precio));
        }
		
        // Filtrar por usuario
        if (usuario != null) {
            serviciosEncontrados.addAll(servicioServicios.buscarPorUsuario(usuario));
        }

        // Pasamos los resultados de la búsqueda al modelo
        model.addAttribute("servicios", serviciosEncontrados);

        return "resultadoBusqueda.jsp";  // Nombre de la vista donde se mostrarán los resultados
    }
}
