<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="es">
   <head>
      <meta charset="UTF-8">
      <title>Editar Servicio</title>
      <link rel="stylesheet" href="/css/editarServicio.css">
      <style>
         .imagen-preview {
            max-width: 200px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            padding: 4px;
         }
      </style>
   </head>
   <body>
      <header>
         <div class="nav-container">
            <a href="/">
               <img src="${pageContext.request.contextPath}/img/pololitosBlanco.png" alt="Logo Pololitos" class="logo">
            </a>
            <nav>
               <ul class="nav-links">
                  <li><a href="/mis-servicios">Mis Servicios</a></li>
               </ul>
            </nav>
         </div>
      </header>
      <main>
         <div class="form-container">
            <h1>Editar Servicio</h1>
            <form action="/actualizar-servicio/${servicio.id}" method="post" enctype="multipart/form-data">
               <input type="hidden" name="_method" value="PATCH">

               <label for="nombre">Nombre</label>
               <input type="text" id="nombre" name="nombre" value="${servicio.nombre}" required>

               <label for="descripcion">Descripción</label>
               <textarea id="descripcion" name="descripcion" required>${servicio.descripcion}</textarea>

               <label for="precio">Precio</label>
               <input type="number" id="precio" name="precio" value="${servicio.precio}" required>

               <label for="ciudad">Ciudad</label>
               <input type="text" id="ciudad" name="ciudad" value="${servicio.ciudad}" required>

               <label for="fechaPublicacion">Fecha de Publicación</label>
               <input type="text" id="fechaPublicacion" name="fechaPublicacion" 
                  value="<fmt:formatDate value='${servicio.fechaPublicacion}' pattern='dd/MM/yyyy'/>" disabled>
               
               <label for="categoria">Categoría</label>
               <select id="categoria" name="categoria" required>
                  <c:forEach var="categoria" items="${categorias}">
                     <option value="${categoria.id}" ${categoria.id == servicio.categoria.id ? 'selected' : ''}>
                        ${categoria.nombre}
                     </option>
                  </c:forEach>
               </select>

               <label for="imagenActual">Imagen actual</label>
               <img src="${servicio.imgUrl}" alt="Imagen actual" class="imagen-preview" id="imagenActual">

               <label for="imagen">Nueva imagen (opcional)</label>
               <input type="file" id="imagen" name="imagen" accept="image/png, image/jpeg, image/jpg">
               <div id="previewContainer">
                  <label>Vista previa de nueva imagen:</label>
                  <img id="preview" class="imagen-preview" style="display:none;">
               </div>

               <div class="button-group">
                  <button type="submit" class="btn">Actualizar Servicio</button>
                  <a href="/mis-servicios" class="btn-secondary">Volver</a>
               </div>
            </form>
         </div>
      </main>
      <footer>
         <p>Pololitos &copy; 2025. Todos los derechos reservados</p>
         <ul class="nav-footer">
            <li><a href="/contacto">Contacto</a></li>
            <li><a href="/nosotros">Nosotros</a></li>
         </ul>
      </footer>

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
