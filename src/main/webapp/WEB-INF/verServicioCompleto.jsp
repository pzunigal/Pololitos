<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="es">
<head>
   <meta charset="UTF-8">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <title>Detalles del Servicio</title>

   <!-- Bootstrap & Icons -->
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
   <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
   <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Quicksand&display=swap">
   <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
   <link rel="stylesheet" href="<c:url value='/css/global.css' />" />

</head>

<body class="body-without-bg">
   <!-- Navbar -->
   <%@ include file="/WEB-INF/componentes/layout/nav.jsp" %>

   <!-- Contenido principal -->
   <main class="container py-4">
      <c:if test="${not empty servicio}">
         <div class="card mb-4 bg-dark text-white">
            <div class="row g-0">
               <div class="col-md-5">
                  <img src="${servicio.imgUrl}" class="img-fluid rounded-start" alt="${servicio.nombre}">
               </div>
               <div class="col-md-7">
                  <div class="card-body">
                     <h3 class="card-title">${servicio.nombre}</h3>
                     <p class="card-text">${servicio.descripcion}</p>
                     <p><strong>Precio:</strong> $${servicio.precio}</p>
                     <p><strong>Ciudad:</strong> ${servicio.ciudad}</p>
                     <p><strong>Fecha publicación:</strong> <fmt:formatDate value="${servicio.createdAt}" pattern="dd/MM/yyyy" /></p>
                  </div>
               </div>
            </div>
         </div>

         <!-- Promedio de calificaciones -->
   <%@ include file="/WEB-INF/componentes/labels/calificationAverage.jsp" %>
         
         

         <!-- Solicitar Servicio -->
   <%@ include file="/WEB-INF/componentes/forms/createRequestServiceForm.jsp" %>
         

         <!-- Formulario de reseña -->
   <%@ include file="/WEB-INF/componentes/forms/setReviewForm.jsp" %>
         

         <!-- Lista de reseñas -->
   <%@ include file="/WEB-INF/componentes/cards/cardReviews.jsp" %>
         
      </c:if>
   </main>
   <%@ include file="/WEB-INF/componentes/layout/footer.jsp" %>
   <!-- Modal Bootstrap para editar reseña -->
   <%@ include file="/WEB-INF/componentes/modals/editReview.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
   function mostrarModalEditar(id, calificacion, comentario) {
      document.getElementById('editarResenaId').value = id;
      document.getElementById('comentarioEditar').value = comentario;

      const radios = document.querySelectorAll('#editarStars input[name="calificacion"]');
      radios.forEach(r => r.checked = false);

      const selected = document.getElementById('editarStar' + calificacion);
      if (selected) selected.checked = true;

      new bootstrap.Modal(document.getElementById('modalEditar')).show();
   }

   function confirmDelete(e) {
      e.preventDefault();
      Swal.fire({
         title: '¿Eliminar reseña?',
         text: 'Esta acción no se puede deshacer',
         icon: 'warning',
         showCancelButton: true,
         confirmButtonColor: '#d33',
         cancelButtonColor: '#6c757d',
         confirmButtonText: 'Sí, eliminar',
         cancelButtonText: 'Cancelar'
      }).then((result) => {
         if (result.isConfirmed) e.target.submit();
      });
   }

   function validarEstrellasEdit() {
      const seleccion = document.querySelector('#editarStars input[name="calificacion"]:checked');
      if (!seleccion) {
         Swal.fire({
            icon: 'warning',
            title: 'Selecciona una calificación',
            text: 'Debes seleccionar una cantidad de estrellas para continuar',
            confirmButtonColor: '#f39c12'
         });
         return false;
      }
      return true;
   }

   document.addEventListener("DOMContentLoaded", () => {
      const formNuevaResena = document.getElementById("formNuevaResena");
      if (formNuevaResena) {
         formNuevaResena.addEventListener("submit", function (e) {
            const comentario = this.querySelector('textarea[name="comentario"]').value.trim();
            if (!comentario) {
               e.preventDefault();
               Swal.fire({
                  icon: 'warning',
                  title: 'Escribe tu reseña',
                  text: 'No puedes dejar una reseña vacía',
                  confirmButtonColor: '#f39c12'
               });
               return;
            }

            const estrellasSeleccionadas = this.querySelector('input[name="calificacion"]:checked');
            if (!estrellasSeleccionadas) {
               e.preventDefault();
               Swal.fire({
                  icon: 'warning',
                  title: 'Selecciona una calificación',
                  text: 'Debes seleccionar una cantidad de estrellas para dejar tu reseña',
                  confirmButtonColor: '#f39c12'
               });
            }
         });
      }
   });
</script>

</body>
</html>
