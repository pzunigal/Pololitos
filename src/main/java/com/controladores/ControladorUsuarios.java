package com.controladores;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.modelos.LoginUsuario;
import com.modelos.Servicio;
import com.modelos.Usuario;
import com.servicios.ServicioCloudinary;
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

	@Autowired
	private ServicioCloudinary servicioCloudinary;

	@GetMapping("/registro")
	public String mostrarRegistro(Model model) {
		model.addAttribute("nuevoUsuario", new Usuario()); // Agregar el atributo al modelo
		return "registro.jsp";
	}

	@PostMapping("/registro")
	public String registro(@Valid @ModelAttribute("nuevoUsuario") Usuario nuevoUsuario,
			BindingResult result,
			HttpSession session) {
		System.out.println("===> Iniciando registro con MultipartFile dentro del modelo Usuario");

		if (nuevoUsuario.getFotoPerfilArchivo() != null && !nuevoUsuario.getFotoPerfilArchivo().isEmpty()) {
			try {
				String url = servicioCloudinary.subirArchivo(nuevoUsuario.getFotoPerfilArchivo(), "profile-images");
				nuevoUsuario.setFotoPerfil(url);
				System.out.println(" Imagen subida: " + url);
			} catch (IOException e) {
				result.rejectValue("fotoPerfilArchivo", "error", "Error al subir la imagen de perfil.");
			}
		} else {
			System.out.println("No se subió imagen de perfil.");
		}

		Usuario usuarioGuardado = servicioUsuarios.registrarUsuario(nuevoUsuario, result);

		if (result.hasErrors()) {
			return "registro.jsp";
		}

		session.setAttribute("usuarioEnSesion", usuarioGuardado);
		return "redirect:/";
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
	public String editarPerfil(HttpSession session, Model model) {
		Usuario usuarioEnSesion = (Usuario) session.getAttribute("usuarioEnSesion");

		if (usuarioEnSesion == null) {
			return "redirect:/login";
		}

		// Pasamos el usuario actual a la vista como modelo completo
		model.addAttribute("usuario", usuarioEnSesion);

		return "editarUsuario.jsp";
	}

	@PatchMapping("/actualizarPerfil")
	@jakarta.transaction.Transactional
	public String actualizarPerfil(
			@ModelAttribute("usuario") Usuario usuario,
			BindingResult result,
			@RequestParam(value = "fotoPerfilArchivo", required = false) MultipartFile nuevaImagen,
			HttpSession session) {

		Usuario usuarioEnSesion = (Usuario) session.getAttribute("usuarioEnSesion");
		if (usuarioEnSesion == null) {
			return "redirect:/login";
		}

		if (result.hasErrors()) {
			return "editarUsuario.jsp";
		}

		// Si hay nueva imagen, procesarla
		if (nuevaImagen != null && !nuevaImagen.isEmpty()) {
			try {
				// Eliminar anterior solo si era de Cloudinary
				if (usuarioEnSesion.getFotoPerfil() != null) {
					servicioCloudinary.eliminarArchivo(usuarioEnSesion.getFotoPerfil());
				}

				// Subir nueva imagen
				String nuevaUrl = servicioCloudinary.subirArchivo(nuevaImagen, "profile-images");
				usuarioEnSesion.setFotoPerfil(nuevaUrl);
			} catch (IOException e) {
				result.rejectValue("fotoPerfilArchivo", "error", "Error al actualizar imagen de perfil.");
				return "editarUsuario.jsp";
			}
		}

		// Actualizar otros datos
		usuarioEnSesion.setNombre(usuario.getNombre());
		usuarioEnSesion.setApellido(usuario.getApellido());
		usuarioEnSesion.setTelefono(usuario.getTelefono());
		usuarioEnSesion.setCiudad(usuario.getCiudad());

		// (Opcional: manejar password si agregas esa lógica)
		servicioUsuarios.actualizarUsuario(usuarioEnSesion);
		session.setAttribute("usuarioEnSesion", usuarioEnSesion);

		return "redirect:/perfilUsuario";
	}

}
