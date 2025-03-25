<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="es">
<head>
   <meta charset="UTF-8">
   <title>Editar Servicio</title>

   <!-- Fuentes personalizadas -->
   <link rel="preconnect" href="https://fonts.googleapis.com">
   <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
   <link href="https://fonts.googleapis.com/css2?family=Noto+Sans:ital,wght@0,100..900;1,100..900&family=Quicksand:wght@300..700&family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&family=Winky+Sans:ital,wght@0,300..900;1,300..900&display=swap" rel="stylesheet">

   <!-- Bootstrap -->
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
   <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

   <style>
      body {
         font-family: 'Quicksand', 'Roboto', 'Noto Sans', 'Winky Sans', sans-serif;
         min-height: 100vh;
         background-image: url('https://c1.wallpaperflare.com/path/427/745/192/notebook-natural-laptop-macbook-497500668a927f46aa19fafb668d8702.jpg');
         background-size: cover;
         background-position: center;
         display: flex;
         flex-direction: column;
         color: white;
      }

      .imagen-preview {
         max-width: 200px;
         margin-bottom: 10px;
         border: 1px solid #ccc;
         padding: 4px;
      }
   </style>
</head>

<body class="d-flex flex-column">

   <!-- Navbar -->
   <nav class="navbar navbar-expand-lg navbar-dark bg-dark px-4">
      <a class="navbar-brand" href="/">
         <img src="<c:url value='/img/pololitosBlanco.png' />" alt="Logo Pololitos" height="40">
      </a>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
         <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarNav">
         <ul class="navbar-nav me-auto mb-2 mb-lg-0">
            <li class="nav-item"><a class="nav-link" href="/servicios">Servicios</a></li>
            <c:if test="${not empty sessionScope.usuarioEnSesion}">
               <li class="nav-item"><a class="nav-link" href="/mis-servicios">Mis Servicios</a></li>
               <li class="nav-item"><a class="nav-link" href="/mis-solicitudes-enviadas">Enviadas</a></li>
               <li class="nav-item"><a class="nav-link" href="/mis-solicitudes-recibidas">Recibidas</a></li>
            </c:if>
         </ul>
         <form class="d-flex me-3" action="/buscar-servicios" method="get">
            <input class="form-control me-2" type="search" name="query" placeholder="Busca Aquí">
            <button class="btn btn-outline-light" type="submit"><i class="bi bi-search"></i></button>
         </form>
         <c:choose>
            <c:when test="${not empty sessionScope.usuarioEnSesion}">
               <a href="/perfilUsuario" class="me-3">
                  <img src="${sessionScope.usuarioEnSesion.fotoPerfil}" alt="Perfil" width="40" height="40" class="rounded-circle">
               </a>
               <a href="/servicios/publicar" class="btn btn-success me-2">Crear Servicio</a>
               <a href="/logout" class="btn btn-danger">Cerrar Sesión</a>
            </c:when>
            <c:otherwise>
               <a href="/login" class="btn btn-outline-light me-2">Iniciar sesión</a>
               <a href="/registro" class="btn btn-outline-info">Regístrate</a>
            </c:otherwise>
         </c:choose>
      </div>
   </nav>

   <!-- Contenido -->
   <main class="container my-5">
      <div class="bg-dark text-white p-5 rounded shadow">
         <h1 class="mb-4 text-center">Editar Servicio</h1>

         <c:if test="${not empty error}">
            <div class="alert alert-danger text-center">${error}</div>
         </c:if>

         <form action="/actualizar-servicio/${servicio.id}" method="post" enctype="multipart/form-data">
            <input type="hidden" name="_method" value="PATCH">

            <div class="mb-3">
               <label for="nombre" class="form-label">Nombre</label>
               <input type="text" class="form-control" id="nombre" name="nombre" value="${servicio.nombre}" required>
            </div>

            <div class="mb-3">
               <label for="descripcion" class="form-label">Descripción</label>
               <textarea class="form-control" id="descripcion" name="descripcion" rows="4" required>${servicio.descripcion}</textarea>
            </div>

            <div class="mb-3">
               <label for="precio" class="form-label">Precio</label>
               <input type="number" class="form-control" id="precio" name="precio" value="${servicio.precio}" required>
            </div>

            <div class="mb-3">
               <label for="ciudad" class="form-label">Ciudad</label>
               <input type="text" class="form-control" id="ciudad" name="ciudad" value="${servicio.ciudad}" required>
            </div>

            <div class="mb-3">
               <label for="fechaPublicacion" class="form-label">Fecha de Publicación</label>
               <input type="text" class="form-control" id="fechaPublicacion" name="fechaPublicacion"
                  value="<fmt:formatDate value='${servicio.fechaPublicacion}' pattern='dd/MM/yyyy'/>" disabled>
            </div>

            <div class="mb-3">
               <label for="categoria" class="form-label">Categoría</label>
               <select id="categoria" name="categoria" class="form-select" required>
                  <c:forEach var="categoria" items="${categorias}">
                     <option value="${categoria.id}" ${categoria.id == servicio.categoria.id ? 'selected' : ''}>
                        ${categoria.nombre}
                     </option>
                  </c:forEach>
               </select>
            </div>

            <div class="mb-3">
               <label class="form-label">Imagen actual:</label><br>
               <img src="${servicio.imgUrl}" alt="Imagen actual" class="imagen-preview">
            </div>

            <div class="mb-3">
               <label for="imagen" class="form-label">Nueva imagen (opcional)</label>
               <input type="file" class="form-control" id="imagen" name="imagen" accept="image/*">
               <div class="mt-2" id="previewContainer">
                  <label class="form-label">Vista previa:</label><br>
                  <img id="preview" class="imagen-preview" style="display:none;">
               </div>
            </div>

            <div class="text-center mt-4">
               <button type="submit" class="btn btn-primary px-4 me-2">Actualizar Servicio</button>
               <a href="/mis-servicios" class="btn btn-secondary">Volver</a>
            </div>
         </form>
      </div>
   </main>

   <!-- Footer -->
   <footer class="bg-dark text-white text-center py-3 mt-auto">
      <p class="mb-1">Pololitos &copy; 2025. Todos los derechos reservados</p>
      <ul class="nav justify-content-center">
         <li class="nav-item"><a class="nav-link text-white" href="/contacto">Contacto</a></li>
         <li class="nav-item"><a class="nav-link text-white" href="/nosotros">Nosotros</a></li>
      </ul>
   </footer>

   <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
   <script>
      const inputImagen = document.getElementById('imagen');
      const preview = document.getElementById('preview');

      inputImagen.addEventListener('change', function(event) {
         const archivo = event.target.files[0];
         if (archivo) {
            const reader = new FileReader();
            reader.onload = function(e) {
               preview.src = e.target.result;
               preview.style.display = 'block';
            }
            reader.readAsDataURL(archivo);
         } else {
            preview.src = '';
            preview.style.display = 'none';
         }
      });
   </script>
</body>
</html>
