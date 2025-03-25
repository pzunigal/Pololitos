<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="es">
<head>
   <meta charset="UTF-8">
   <title>Resultados de Búsqueda</title>
   <meta name="viewport" content="width=device-width, initial-scale=1">
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
   <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
   <link href="https://fonts.googleapis.com/css2?family=Quicksand&family=Roboto&family=Noto+Sans&display=swap" rel="stylesheet">
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
   </style>
</head>
<body>

   <%@ include file="/WEB-INF/componentes/nav.jsp" %>

<main class="container py-5">
   <h1 class="mb-4">Resultados de la búsqueda: "${query}"</h1>
   <c:choose>
      <c:when test="${not empty servicios}">
         <div class="row">
            <c:forEach var="servicio" items="${servicios}">
               <div class="col-md-4 mb-4">
                  <div class="card bg-dark text-white h-100">
                     <a href="/servicio/detalles/${servicio.id}">
                        <img src="${servicio.imgUrl}" class="card-img-top" style="height: 220px; object-fit: cover;" alt="${servicio.nombre}">
                     </a>
                     <div class="card-body d-flex flex-column">
                        <h5 class="card-title text-truncate">${servicio.nombre}</h5>
                        <p class="card-text mb-1"><strong>Precio:</strong> $${servicio.precio}</p>
                        <p class="card-text"><small>Autor: ${servicio.usuario.nombre} ${servicio.usuario.apellido}</small></p>
                        <div class="mt-auto">
                           <c:choose>
                              <c:when test="${empty usuarioSesion or usuarioSesion.id ne servicio.usuario.id}">
                                 <a href="/servicio/detalles/${servicio.id}" class="btn btn-primary btn-sm me-2 mb-2">
                                    <i class="bi bi-hand-index-thumb"></i> Solicitar Servicio
                                 </a>
                              </c:when>
                              <c:otherwise>
                                 <a href="/servicio/detalles/${servicio.id}" class="btn btn-outline-info btn-sm">
                                    <i class="bi bi-eye"></i> Ver
                                 </a>
                              </c:otherwise>
                           </c:choose>
                        </div>
                     </div>
                  </div>
               </div>
            </c:forEach>
         </div>
      </c:when>
      <c:otherwise>
         <div class="alert alert-warning">No se encontraron servicios para la búsqueda: "${query}".</div>
      </c:otherwise>
   </c:choose>

   <div class="text-center mt-5">
      <a href="/servicios" class="btn btn-outline-light">
         <i class="bi bi-arrow-left"></i> Volver a Servicios
      </a>
   </div>
</main>

<footer class="bg-dark text-white text-center py-3 mt-auto">
   <p class="mb-1">Pololitos &copy; 2025. Todos los derechos reservados</p>
   <ul class="nav justify-content-center">
      <li class="nav-item"><a class="nav-link text-white" href="/contacto">Contacto</a></li>
      <li class="nav-item"><a class="nav-link text-white" href="/nosotros">Nosotros</a></li>
   </ul>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
