package com.services;

import java.util.List;
import java.util.Optional;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.validation.BindingResult;

import com.models.LoginUsuario;
import com.models.Usuario;
import com.repositories.RepositorioUsuarios;

@Service
public class ServicioUsuarios {

    @Autowired
    private RepositorioUsuarios repositorioUsuarios;


    //Registrar un usuario
    public Usuario registrarUsuario(Usuario nuevoUsuario, BindingResult result) {
        
        String password = nuevoUsuario.getPassword();
        String confirmacion = nuevoUsuario.getConfirmacion();
        
        if(!password.equals(confirmacion)) {
			result.rejectValue("confirmacion", "Matches", "Password y Confirmación deben ser iguales");
		}
		
		String email = nuevoUsuario.getEmail();
		Usuario existeUsuario = repositorioUsuarios.findByEmail(email); 
		
		if(existeUsuario != null) {
			result.rejectValue("email", "Unique", "E-mail ya se encuentra registrado.");
		}
        
        if(result.hasErrors()) {
			return null;
		} else {
			String passwordHasheado = BCrypt.hashpw(password, BCrypt.gensalt());
			nuevoUsuario.setPassword(passwordHasheado);
			return repositorioUsuarios.save(nuevoUsuario);
		}
    }

    //Iniciar sesión
    public Usuario login(LoginUsuario datosInicioDeSesion, BindingResult result) {
		
		String email = datosInicioDeSesion.getEmailLogin();
		Usuario existeUsuario = repositorioUsuarios.findByEmail(email); 
		
		if(existeUsuario == null) {
			result.rejectValue("emailLogin", "Unique", "E-mail no registrado");
		} else {
			if(! BCrypt.checkpw(datosInicioDeSesion.getPasswordLogin(), existeUsuario.getPassword())) {
				result.rejectValue("passwordLogin", "Matches", "Password incorrecto");
			}
		}
		
		if(result.hasErrors()) {
			return null;
		} else {
			return existeUsuario;
		}
	}
    
    //Buscar usuario por ID
    public Usuario buscarUsuarioPorId(Long id) {
        Optional<Usuario> usuario = repositorioUsuarios.findById(id);
        if(usuario.isPresent()) {
            return usuario.get();
        } else {
            return null;
        }
    }

    //Buscar usuario por email
    public Usuario buscarUsuarioPorEmail(String email) {
        return repositorioUsuarios.findByEmail(email);
    }

    //Buscar todos los usuarios
    public List<Usuario> buscarTodosLosUsuarios() {
        return (List<Usuario>) repositorioUsuarios.findAll();
    }

    //Actualizar usuario
    public Usuario actualizarUsuario(Usuario usuario) {
        return repositorioUsuarios.save(usuario);
    }

    //Eliminar usuario
    public void eliminarUsuario(Long id) {
        repositorioUsuarios.deleteById(id);
    }
}
