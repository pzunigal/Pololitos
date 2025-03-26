<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<form:form action="" method="POST" modelAttribute="nuevoUsuario" enctype="multipart/form-data">
         <div class="row">
            <div class="col-md-6">
               <form:label path="nombre" class="form-label">Nombre:</form:label>
               <form:input path="nombre" class="form-control" />
               <form:errors path="nombre" class="text-danger" />
            </div>
            <div class="col-md-6">
               <form:label path="apellido" class="form-label">Apellido:</form:label>
               <form:input path="apellido" class="form-control" />
               <form:errors path="apellido" class="text-danger" />
            </div>
         </div>
         <div class="row mt-3">
            <div class="col-md-6">
               <form:label path="ciudad" class="form-label">Ciudad:</form:label>
               <form:input path="ciudad" class="form-control" />
               <form:errors path="ciudad" class="text-danger" />
            </div>
            <div class="col-md-6">
               <form:label path="telefono" class="form-label">Teléfono:</form:label>
               <form:input path="telefono" class="form-control" />
               <form:errors path="telefono" class="text-danger" />
            </div>
         </div>
         <div class="mt-3">
            <form:label path="email" class="form-label">Correo Electrónico:</form:label>
            <form:input path="email" class="form-control" />
            <form:errors path="email" class="text-danger" />
         </div>
         <div class="mt-3">
            <form:label path="fotoPerfilArchivo" class="form-label">Foto de Perfil:</form:label>
            <form:input path="fotoPerfilArchivo" type="file" class="form-control" accept="image/*" id="fotoPerfil" />
            <form:errors path="fotoPerfilArchivo" class="text-danger" />
            <img id="preview">
         </div>
         <div class="row mt-3">
            <div class="col-md-6">
               <form:label path="password" class="form-label">Contraseña:</form:label>
               <form:password path="password" class="form-control" />
               <form:errors path="password" class="text-danger" />
            </div>
            <div class="col-md-6">
               <form:label path="confirmacion" class="form-label">Confirmar Contraseña:</form:label>
               <form:password path="confirmacion" class="form-control" />
               <form:errors path="confirmacion" class="text-danger" />
            </div>
         </div>
         <p class="mt-3 small">
            Al crear una cuenta muestras tu conformidad con nuestros Términos de uso y nuestra Política de privacidad, confirmando además que tienes 18 años o más.
         </p>
         <button type="submit" class="btn btn-primary">Crear Cuenta</button>
      </form:form>