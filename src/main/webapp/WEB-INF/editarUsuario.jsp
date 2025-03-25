<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
   <meta charset="UTF-8">
   <title>Editar Usuario</title>
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
 
    main { flex: 1; }
 
    .form-control, .form-label {
       color: white;
    }
 
    .form-control {
       background-color: #2c2c2c;
       border: 1px solid #555;
    }
 
    .form-control::placeholder {
       color: #bbb;
    }
 
    .form-control:focus {
       background-color: #2c2c2c;
       color: white;
       border-color: #f1c40f;
       box-shadow: none;
    }
    .nav-footer .nav-link {
      color: #ccc;
      transition: color 0.3s;
   }

   .nav-footer .nav-link:hover {
      color: white;
   }
 </style>
 
</head>
<body>

<!-- Navbar -->
<%@ include file="/WEB-INF/componentes/nav.jsp" %>

<!-- Contenido -->
<main class="container my-5">
   <div class="row justify-content-center">
      <div class="col-md-8">
         <div class="card bg-dark border-light p-4">
            <h2 class="text-center mb-4">Editar Perfil</h2>
            <form method="post" action="/actualizarPerfil" enctype="multipart/form-data" onsubmit="return confirmarActualizacion(event)">
               <input type="hidden" name="_method" value="PATCH">

               <div class="mb-3">
                  <label for="nombre" class="form-label">Nombre</label>
                  <input type="text" class="form-control" name="nombre" value="${usuario.nombre}" required>
               </div>

               <div class="mb-3">
                  <label for="apellido" class="form-label">Apellido</label>
                  <input type="text" class="form-control" name="apellido" value="${usuario.apellido}" required>
               </div>

               <div class="mb-3">
                  <label for="ciudad" class="form-label">Ciudad</label>
                  <input type="text" class="form-control" name="ciudad" value="${usuario.ciudad}" required>
               </div>

               <div class="mb-3">
                  <label for="telefono" class="form-label">Teléfono</label>
                  <input type="text" class="form-control" name="telefono" value="${usuario.telefono}" required>
               </div>

               <div class="mb-3">
                  <label class="form-label">Imagen actual</label><br>
                  <img src="${usuario.fotoPerfil}" alt="Imagen actual" class="img-thumbnail" style="max-width: 200px;">
               </div>

               <div class="mb-3">
                  <label for="fotoPerfilArchivo" class="form-label">Nueva imagen (opcional)</label>
                  <input type="file" class="form-control" id="fotoPerfilArchivo" name="fotoPerfilArchivo" accept="image/*">
                  <img id="preview" class="img-thumbnail mt-2" style="display:none; max-width: 200px;">
               </div>

               <button type="submit" class="btn btn-primary w-100">Guardar Cambios</button>
            </form>
         </div>
      </div>
   </div>
</main>

<footer class="bg-dark text-white text-center py-3 mt-auto">
    <p>Pololitos &copy; 2025. Todos los derechos reservados</p>
    <ul class="nav justify-content-center nav-footer">
       <li class="nav-item">
          <a class="nav-link text-white" href="/contacto">Contacto</a>
       </li>
       <li class="nav-item">
          <a class="nav-link text-white" href="/nosotros">Nosotros</a>
       </li>
    </ul>
 </footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
   document.getElementById('fotoPerfilArchivo').addEventListener('change', function(event) {
      const preview = document.getElementById('preview');
      const file = event.target.files[0];
      if (file) {
         const reader = new FileReader();
         reader.onload = function(e) {
            preview.src = e.target.result;
            preview.style.display = 'block';
         };
         reader.readAsDataURL(file);
      } else {
         preview.style.display = 'none';
      }
   });

   function confirmarActualizacion(e) {
      e.preventDefault();
      Swal.fire({
         title: '¿Guardar cambios?',
         text: 'Tu perfil será actualizado con la nueva información.',
         icon: 'warning',
         showCancelButton: true,
         confirmButtonColor: '#3085d6',
         cancelButtonColor: '#6c757d',
         confirmButtonText: 'Sí, actualizar',
         cancelButtonText: 'Cancelar'
      }).then((result) => {
         if (result.isConfirmed) {
            e.target.submit();
         }
      });
      return false;
   }
</script>
</body>
</html>