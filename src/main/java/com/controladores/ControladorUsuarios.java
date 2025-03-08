package com.controladores;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import com.modelos.LoginUsuario;
import com.modelos.Usuario;
import com.servicios.ServicioUsuarios;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
public class ControladorUsuarios {

    @Autowired
	private ServicioUsuarios servicioUsuarios;

	@PostMapping("/registro")
	public String registro(@Valid @ModelAttribute("nuevoUsuario") Usuario nuevoUsuario,
						   BindingResult result,
						   HttpSession session) {
		servicioUsuarios.registrarUsuario(nuevoUsuario, result);
		
		if(result.hasErrors()) {
			return "index.jsp";
		} else {
			//Guardo al nuevo usuario en sesión
			session.setAttribute("usuarioEnSesion", nuevoUsuario);
			return "redirect:/";
		}
		
	}
	
	@GetMapping("/login")
	public String login(@ModelAttribute("loginUsuario") LoginUsuario loginUsuario) {
		return "login.jsp";
	}
	
	@PostMapping("/iniciarSesion")
	public String iniciarSesion(@Valid @ModelAttribute("loginUsuario") LoginUsuario loginUsuario,
								BindingResult result,
								HttpSession session) {
		Usuario usuario = servicioUsuarios.login(loginUsuario, result);
		
		if(result.hasErrors()) {
			return "login.jsp";
		} else {
			session.setAttribute("usuarioEnSesion", usuario);
			return "redirect:/";
		}
		
	}
	
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
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

		return "editarPerfil.jsp";
	}

	@PostMapping("/actualizarPerfil")
	public String actualizarPerfil(@Valid @ModelAttribute("usuario") Usuario usuario,
								   BindingResult result,
								   HttpSession session) {
	if (result.hasErrors()) {
		return "editarPerfil.jsp";
	}

	Usuario usuarioEnSesion = (Usuario) session.getAttribute("usuarioEnSesion");
    if (usuarioEnSesion == null) {
        return "redirect:/login";
    }
	
	usuarioEnSesion.setNombre(usuario.getNombre());
	usuarioEnSesion.setEmail(usuario.getEmail());
	usuarioEnSesion.setTelefono(usuario.getTelefono());

	servicioUsuarios.actualizarUsuario(usuarioEnSesion);

	session.setAttribute("usuarioEnSession", usuarioEnSesion);

	return "redirect:/perfil";
	
	}

}
