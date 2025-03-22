package com.controladores;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import com.modelos.LoginUsuario;
import com.modelos.Servicio;
import com.modelos.Usuario;
import com.servicios.ServicioServicios;
import com.servicios.ServicioUsuarios;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
public class ControladorUsuarios {

	@Autowired
	private ServicioUsuarios servicioUsuarios;

	@Autowired
	private ServicioServicios servicioServicios;

	@GetMapping("/registro")
	public String mostrarRegistro(Model model) {
		model.addAttribute("nuevoUsuario", new Usuario()); // Agregar el atributo al modelo
		return "registro.jsp";
	}

	@PostMapping("/registro")
	public String registro(@Valid @ModelAttribute("nuevoUsuario") Usuario nuevoUsuario,
			BindingResult result,
			HttpSession session) {
		servicioUsuarios.registrarUsuario(nuevoUsuario, result);

		if (result.hasErrors()) {
			return "registro.jsp";
		} else {
			// Guardo al nuevo usuario en sesión
			session.setAttribute("usuarioEnSesion", nuevoUsuario);
			return "redirect:/";
		}

	}

	@GetMapping("/login")
	public String login(Model model) {
		model.addAttribute("loginUsuario", new LoginUsuario()); // Asegurar el modelo
		return "login.jsp";
	}

	@PostMapping("/iniciarSesion")
	public String iniciarSesion(@Valid @ModelAttribute("loginUsuario") LoginUsuario loginUsuario,
			BindingResult result,
			HttpSession session,
			Model model) {
		if (result.hasErrors()) {
			model.addAttribute("loginUsuario", loginUsuario);
			return "login.jsp";
		}

		Usuario usuario = servicioUsuarios.login(loginUsuario, result);

		if (result.hasErrors()) {
			model.addAttribute("loginUsuario", loginUsuario);
			return "login.jsp";
		} else {
			session.setAttribute("usuarioEnSesion", usuario);

			// Verificar si hay una URL pendiente
			String urlPendiente = (String) session.getAttribute("urlPendiente");
			session.removeAttribute("urlPendiente"); // Limpiar la sesión después de redirigir

			if (urlPendiente != null) {
				return "redirect:" + urlPendiente; // Redirigir a la página deseada
			}
			return "redirect:/";
		}
	}

	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}

	@GetMapping("/perfilUsuario")
	public String mostrarPerfil(HttpSession session, Model model) {
		Usuario usuarioEnSesion = (Usuario) session.getAttribute("usuarioEnSesion");

		if (usuarioEnSesion == null) {
			return "redirect:/login";
		}

		// Obtener la lista de servicios creados por el usuario
		List<Servicio> serviciosUsuario = servicioServicios.obtenerServiciosPorUsuario(usuarioEnSesion.getId());

		// Agregar datos al modelo
		model.addAttribute("usuario", usuarioEnSesion);
		model.addAttribute("servicios", serviciosUsuario);
		return "mostrarUsuario.jsp";
	}

	@GetMapping("/editarPerfil")
	public String editarPerfil(HttpSession session, @ModelAttribute("usuario") Usuario usuario) {
		Usuario usuarioEnSesion = (Usuario) session.getAttribute("usuarioEnSesion");

		if (usuarioEnSesion == null) {
			return "redirect:/login";
		}

		usuario.setNombre(usuarioEnSesion.getNombre());
		usuario.setEmail(usuarioEnSesion.getEmail());
		usuario.setTelefono(usuarioEnSesion.getTelefono());

		return "editarUsuario.jsp";
	}

	@PostMapping("/actualizarPerfil")
	public String actualizarPerfil(@Valid @ModelAttribute("usuario") Usuario usuario,
			BindingResult result,
			HttpSession session) {
		if (result.hasErrors()) {
			return "editarUsuario.jsp";
		}

		Usuario usuarioEnSesion = (Usuario) session.getAttribute("usuarioEnSesion");
		if (usuarioEnSesion == null) {
			return "redirect:/login";
		}

		// Actualizar los datos del usuario en sesión
		usuarioEnSesion.setNombre(usuario.getNombre());
		usuarioEnSesion.setEmail(usuario.getEmail());
		usuarioEnSesion.setTelefono(usuario.getTelefono());

		servicioUsuarios.actualizarUsuario(usuarioEnSesion);

		session.setAttribute("usuarioEnSession", usuarioEnSesion);

		return "redirect:/perfil";
	}
}
