<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="row justify-content-center">
    <div class="col-md-5">
       <div class="profile-card">
          <img src="${usuario.fotoPerfil}" alt="Foto de perfil">
          <h2>${usuario.nombre} ${usuario.apellido}</h2>
          <p><strong>Ciudad:</strong> ${usuario.ciudad}</p>
          <p><strong>Teléfono:</strong> <a href="tel:${usuario.telefono}" class="text-info">${usuario.telefono}</a></p>
          <p><strong>Correo:</strong> <a href="mailto:${usuario.email}" class="text-info">${usuario.email}</a></p>
          <button class="btn btn-primary edit-button" onclick="confirmarEdicion()">Editar Perfil</button>
       </div>
    </div>
 </div>