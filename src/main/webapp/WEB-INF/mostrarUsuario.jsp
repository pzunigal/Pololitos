<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
   <meta charset="UTF-8">
   <title>Mostrar Usuario</title>
   <meta name="viewport" content="width=device-width, initial-scale=1">

   <!-- Bootstrap & Icons -->
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
   <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
   <link href="https://fonts.googleapis.com/css2?family=Quicksand&display=swap" rel="stylesheet">
   <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

   <style>
      body {
         font-family: 'Quicksand', sans-serif;
         background-color: #1e1e1e;
         color: white;
         min-height: 100vh;
         display: flex;
         flex-direction: column;
      }

      main {
         flex: 1;
      }

      .profile-card {
         background-color: #2c2c2c;
         border-radius: 10px;
         padding: 30px;
         text-align: center;
         color: white;
         box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
      }

      .profile-card img {
         width: 150px;
         height: 150px;
         border-radius: 50%;
         object-fit: cover;
         margin-bottom: 20px;
      }

      .edit-button {
         margin-top: 20px;
      }

      footer {
         background-color: #111;
         color: #ccc;
         text-align: center;
         padding: 15px 0;
         margin-top: auto;
      }

      .nav-footer .nav-link {
         color: #ccc;
      }

      .nav-footer .nav-link:hover {
         color: white;
      }
   </style>
</head>
<body>

<!-- Navbar -->
<%@ include file="/WEB-INF/componentes/nav.jsp" %>

<main class="container my-5">
   <div class="row justify-content-center">
      <div class="col-md-8">
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
</main>

<footer class="bg-dark text-white text-center py-3">
   <p>Pololitos &copy; 2025. Todos los derechos reservados</p>
   <ul class="nav justify-content-center nav-footer">
      <li class="nav-item"><a class="nav-link" href="/contacto">Contacto</a></li>
      <li class="nav-item"><a class="nav-link" href="/nosotros">Nosotros</a></li>
   </ul>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
   function confirmarEdicion() {
      Swal.fire({
         title: '¿Editar tu perfil?',
         text: 'Serás redirigido al formulario de edición.',
         icon: 'question',
         showCancelButton: true,
         confirmButtonColor: '#3085d6',
         cancelButtonColor: '#6c757d',
         confirmButtonText: 'Sí, continuar',
         cancelButtonText: 'Cancelar'
      }).then((result) => {
         if (result.isConfirmed) {
            window.location.href = '/editarPerfil';
         }
      });
   }
</script>

</body>
</html>
