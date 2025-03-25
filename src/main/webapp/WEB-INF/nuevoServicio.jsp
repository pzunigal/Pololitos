<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<!DOCTYPE html>
<html lang="es">
<head>
   <meta charset="UTF-8">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <title>Publicar Servicio</title>

   <!-- Fuentes personalizadas -->
   <link rel="preconnect" href="https://fonts.googleapis.com">
   <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
   <link href="https://fonts.googleapis.com/css2?family=Noto+Sans:ital,wght@0,100..900;1,100..900&family=Quicksand:wght@300..700&family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&family=Winky+Sans:ital,wght@0,300..900;1,300..900&display=swap" rel="stylesheet">

   <!-- Bootstrap & Icons -->
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
   <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
   <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

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
   </style>
</head>

<body class="d-flex flex-column">

   <!-- Navbar -->
   <%@ include file="/WEB-INF/componentes/nav.jsp" %>

   <!-- Contenido principal -->
   <main class="container my-5">
      <div class="bg-dark text-white p-5 rounded shadow">
         <h1 class="mb-4 text-center">Publicar nuevo servicio</h1>

         <c:if test="${not empty error}">
            <div class="alert alert-danger text-center">${error}</div>
         </c:if>

         <form:form modelAttribute="servicio" action="/publicar" method="POST" enctype="multipart/form-data">
            <div class="mb-3">
               <label for="nombre" class="form-label">Nombre del Servicio:</label>
               <form:input path="nombre" class="form-control" required="true"/>
               <form:errors path="nombre" class="text-danger"/>
            </div>

            <div class="mb-3">
               <label for="descripcion" class="form-label">Descripción:</label>
               <form:textarea path="descripcion" class="form-control" rows="4" required="true"/>
               <form:errors path="descripcion" class="text-danger"/>
            </div>

            <div class="mb-3">
               <label for="precio" class="form-label">Precio:</label>
               <form:input path="precio" type="number" step="0.01" class="form-control" required="true"/>
               <form:errors path="precio" class="text-danger"/>
            </div>

            <div class="mb-3">
               <label for="ciudad" class="form-label">Ciudad:</label>
               <form:input path="ciudad" class="form-control"/>
               <form:errors path="ciudad" class="text-danger"/>
            </div>

            <div class="mb-3">
               <label for="file" class="form-label">Foto del Servicio:</label>
               <input type="file" name="file" id="fileInput" class="form-control" accept="image/*" required />
               <div class="mt-3 text-center">
                  <img id="previewImage" class="img-thumbnail" style="max-width: 300px; display: none;" alt="Vista previa" />
               </div>
            </div>

            <div class="mb-4">
               <label for="categoria" class="form-label">Categoría:</label>
               <form:select path="categoria.id" class="form-control" required="true">
                  <form:option value="" label="Seleccione una categoría"/>
                  <c:forEach var="categoria" items="${categorias}">
                     <form:option value="${categoria.id}" label="${categoria.nombre}"/>
                  </c:forEach>
               </form:select>
               <form:errors path="categoria" class="text-danger"/>
            </div>

            <div class="text-center">
               <button type="submit" class="btn btn-success btn-lg px-5">
                  <i class="bi bi-cloud-upload"></i> Publicar Servicio
               </button>
            </div>
         </form:form>
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
      const fileInput = document.getElementById("fileInput");
      const previewImage = document.getElementById("previewImage");

      fileInput.addEventListener("change", function () {
         const file = this.files[0];
         if (file) {
            const reader = new FileReader();
            reader.onload = function (e) {
               previewImage.src = e.target.result;
               previewImage.style.display = "block";
            }
            reader.readAsDataURL(file);
         } else {
            previewImage.style.display = "none";
            previewImage.src = "";
         }
      });
   </script>
</body>
</html>
