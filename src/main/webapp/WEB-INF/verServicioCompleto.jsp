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

   <style>
      body {
         font-family: 'Quicksand', sans-serif;
         background-color: #1e1e1e;
         color: white;
         min-height: 100vh;
      }

      .star-rating {
         margin-top: 15px;
      }

      .stars {
         display: flex;
         flex-direction: row-reverse;
         justify-content: flex-start;
      }

      .stars input[type="radio"] {
         display: none;
      }

      .stars .star {
         font-size: 2rem;
         color: #ccc;
         cursor: pointer;
         transition: color 0.2s;
      }

      .stars .star:hover,
      .stars .star:hover ~ .star {
         color: #f1c40f;
      }

      .stars input[type="radio"]:checked ~ .star {
         color: #f1c40f;
      }

      .star.filled {
         color: #f1c40f;
      }

      .modal .modal-header,
      .modal .modal-footer {
         background-color: #f8f9fa;
         color: black;
      }

      .cardListaResenas {
         background-color: rgba(0, 0, 0, 0.75);
         border-radius: 10px;
         padding: 20px;
         max-height: 400px;
         overflow-y: auto;
         margin-top: 2rem;
      }

      .resena-comentario {
         font-style: italic;
         color: #ccc;
      }

      .filaBotones {
         display: flex;
         gap: 10px;
      }

      .star {
         font-size: 1.5rem;
         color: #888;
      }

      .star.filled {
         color: #f1c40f;
      }

      .promedio-star {
         display: flex;
         justify-content: center;
         align-items: center;
         gap: 5px;
         font-size: 1.3rem;
         color: #f1c40f;
      }
   </style>
</head>

<body>
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
         <c:if test="${not empty promedio}">
            <div class="text-center mb-4">
               <h5>Promedio de calificaciones</h5>
               <div class="promedio-star">
                  <c:forEach var="i" begin="1" end="5">
                     <span class="star ${i <= promedio ? 'filled' : ''}">&#9733;</span>
                  </c:forEach>
                  <span class="promedio-num">
                     (<fmt:formatNumber value="${promedio}" maxFractionDigits="1" /> / 5)
                  </span>
               </div>
            </div>
         </c:if>
         

         <!-- Solicitar Servicio -->
         <c:if test="${not isAuthorInSesion}">
            <div class="card bg-dark text-white mb-4 p-4">
               <h5>Enviar Solicitud</h5>
               <form action="${pageContext.request.contextPath}/crear-solicitud" method="post">
                  <textarea name="mensaje" class="form-control mb-3" placeholder="Mensaje para el proveedor..." required></textarea>
                  <input type="hidden" name="servicioId" value="${servicio.id}" />
                  <button class="btn btn-success" type="submit">Enviar Solicitud</button>
               </form>
            </div>
         </c:if>

         <!-- Formulario de reseña -->
         <c:if test="${not isAuthorInSesion}">
            <div class="card bg-dark text-white mb-4 p-4">
               <h5>Deja tu Reseña</h5>
               <form id="formNuevaResena" action="${pageContext.request.contextPath}/publicar-resena" method="post">
                  <input type="hidden" name="servicioId" value="${servicio.id}" />
                  <div class="star-rating mb-3">
                     <div class="stars">
                        <c:forEach var="i" begin="1" end="5">
                           <c:set var="rev" value="${6 - i}" />
                           <input type="radio" id="star${rev}" name="calificacion" value="${rev}">
                           <label for="star${rev}" class="star">&#9733;</label>
                        </c:forEach>
                        
                     </div>
                  </div>
                  <textarea name="comentario" rows="3" class="form-control mb-3" placeholder="Escribe tu comentario..."></textarea>
                  <button class="btn btn-primary">Enviar Reseña</button>
               </form>
            </div>
         </c:if>

         <!-- Lista de reseñas -->
         <div class="cardListaResenas">
            <h5>Calificaciones recientes</h5>
            <c:forEach var="resena" items="${resenas}">
               <p><strong>${resena.usuario.nombre}</strong>
                  <span class="estrellas-user">
                     <c:forEach var="i" begin="1" end="5">
                        <span class="star ${i <= resena.calificacion ? 'filled' : ''}">&#9733;</span>
                     </c:forEach>
                  </span>
               </p>
               <c:if test="${not empty resena.comentario}">
                  <p class="resena-comentario">${resena.comentario}</p>
                  <c:if test="${sessionScope.usuarioEnSesion.id == resena.usuario.id}">
                     <div class="filaBotones">
                        <form action="${pageContext.request.contextPath}/resena/eliminar" method="post" onsubmit="return confirmDelete(event)">
                           <input type="hidden" name="resenaId" value="${resena.id}" />
                           <button type="submit" class="btn btn-danger btn-sm">Eliminar</button>
                           <button type="button" class="btn btn-warning btn-sm"
                              onclick="mostrarModalEditar('${resena.id}', '${resena.calificacion}', '${fn:escapeXml(resena.comentario)}')">
                              Editar
                           </button>
                        </form>
                     </div>
                  </c:if>
               </c:if>
               <hr />
            </c:forEach>
         </div>
      </c:if>
   </main>


   <%@ include file="/WEB-INF/componentes/layout/footer.jsp" %>


   <!-- Modal Bootstrap para editar reseña -->
<div class="modal fade" id="modalEditar" tabindex="-1">
   <div class="modal-dialog">
      <form id="formEditarResena" method="post" action="${pageContext.request.contextPath}/resena/editar" class="modal-content text-dark" onsubmit="return validarEstrellasEdit()">
         <div class="modal-header">
            <h5 class="modal-title">Editar Reseña</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
         </div>
         <div class="modal-body">
            <input type="hidden" name="resenaId" id="editarResenaId">
            <label class="form-label">Calificación:</label>
            <div class="stars" id="editarStars">
               <c:forEach var="i" begin="1" end="5">
                  <c:set var="rev" value="${6 - i}" />
                  <input type="radio" id="editarStar${rev}" name="calificacion" value="${rev}" />
                  <label for="editarStar${rev}" class="star">&#9733;</label>
               </c:forEach>
            </div>
            <label for="comentarioEditar" class="mt-2">Comentario:</label>
            <textarea id="comentarioEditar" name="comentario" class="form-control" rows="3"></textarea>
         </div>
         <div class="modal-footer">
            <button type="submit" class="btn btn-primary">Guardar cambios</button>
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
         </div>
      </form>
   </div>
</div>

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
