package com.servicios;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.validation.BindingResult;

import com.modelos.LoginUsuario;
import com.modelos.Usuario;
import com.repositorios.RepositorioUsuarios;

@Service
public class ServicioUsuarios {

    @Autowired
    private RepositorioUsuarios repositorioUsuarios;

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
}
