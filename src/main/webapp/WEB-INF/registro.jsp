<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="es">
<head>
   <meta charset="UTF-8">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <title>Registro</title>

   <!-- Fuentes -->
   <link href="https://fonts.googleapis.com/css2?family=Quicksand&display=swap" rel="stylesheet">
   <!-- Bootstrap & Icons -->
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
   <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

   <style>
      body {
         font-family: 'Quicksand', sans-serif;
         background-image: url('https://c1.wallpaperflare.com/path/427/745/192/notebook-natural-laptop-macbook-497500668a927f46aa19fafb668d8702.jpg');
         background-size: cover;
         background-position: center;
         color: white;
         min-height: 100vh;
         display: flex;
         flex-direction: column;
      }

      .registro-wrapper {
         flex: 1;
         display: flex;
         justify-content: center;
         align-items: center;
         padding-top: 80px;
      }

      .registro-container {
         background-color: rgba(0,0,0,0.75);
         padding: 40px;
         border-radius: 12px;
         width: 100%;
         max-width: 700px;
         color: white;
      }

      .form-label {
         color: white;
         margin-top: 10px;
      }

      .form-control {
         background-color: #2c2c2c;
         color: white;
         border: 1px solid #555;
      }

      .form-control::placeholder {
         color: #bbb;
      }

      .btn-primary {
         width: 100%;
         margin-top: 15px;
      }

      .btn-google {
         background-color: #fff;
         color: #444;
         border: none;
         width: 100%;
         margin-top: 10px;
         display: flex;
         align-items: center;
         justify-content: center;
         gap: 8px;
         font-weight: bold;
         border-radius: 4px;
      }

      .btn-google img {
         width: 20px;
         height: 20px;
      }

      footer {
         background-color: rgba(15, 16, 20, 0.95);
         color: #ddd;
         text-align: center;
         padding: 12px 0;
         font-size: 15px;
         font-weight: 300;
      }

      .nav-footer {
         display: flex;
         justify-content: center;
         gap: 15px;
         list-style: none;
         padding: 0;
         margin-top: 5px;
      }

      .nav-footer a {
         color: #bbb;
         text-decoration: none;
         font-size: 14px;
         transition: color 0.3s ease;
      }

      .nav-footer a:hover {
         color: #fff;
      }

      #preview {
         display: none;
         max-width: 150px;
         margin-top: 10px;
      }
      
   </style>
</head>
<body>

<!-- Navbar -->
<%@ include file="/WEB-INF/componentes/nav.jsp" %>

<!-- Registro -->
<div class="registro-wrapper container">
   <div class="registro-container">
      <h2 class="text-center mb-4">Crear Cuenta</h2>
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
      <button class="btn btn-google">
         <img src="https://res.cloudinary.com/dwz4chwv7/image/upload/v1742869751/google_yqrlgh.png" alt="Google Logo">
         Registrarse con Google
      </button>
      <p class="text-center mt-3">¿Ya tienes una cuenta? <a href="/login" class="text-warning">Acceder</a></p>
   </div>
</div>

<!-- Footer -->
<footer class="mt-auto">
   <p class="mb-1">Pololitos &copy; 2025, Todos los derechos reservados</p> 
   <ul class="nav-footer">
      <li><a href="/contacto">Contacto</a></li>
      <li><a href="/nosotros">Nosotros</a></li>
   </ul>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
   document.getElementById('fotoPerfil').addEventListener('change', function (event) {
      const preview = document.getElementById('preview');
      const file = event.target.files[0];
      if (file) {
         const reader = new FileReader();
         reader.onload = function (e) {
            preview.src = e.target.result;
            preview.style.display = 'block';
         };
         reader.readAsDataURL(file);
      } else {
         preview.style.display = 'none';
      }
   });
</script>
</body>
</html>
