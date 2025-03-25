<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="es">
<head>
   <meta charset="UTF-8">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <title>Mis Solicitudes Enviadas</title>

   <!-- Bootstrap -->
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
   <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

   <!-- Google Fonts -->
   <link href="https://fonts.googleapis.com/css2?family=Quicksand&display=swap" rel="stylesheet">

   <!-- SweetAlert2 -->
   <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

   <style>
      html, body {
         height: 100%;
         margin: 0;
         font-family: 'Quicksand', sans-serif;
         background-color: #1e1e1e;
         color: white;
      }

      body {
         display: flex;
         flex-direction: column;
      }

      main {
         flex: 1;
      }

      .table thead {
         color: #f1c40f;
      }

      .table td, .table th {
         vertical-align: middle;
      }
   </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark px-4">
   <a class="navbar-brand" href="/">
      <img src="<c:url value='/img/pololitosBlanco.png' />" alt="Logo" height="40">
   </a>
   <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
      <span class="navbar-toggler-icon"></span>
   </button>
   <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav me-auto">
         <li class="nav-item"><a class="nav-link" href="/servicios">Servicios</a></li>
         <c:if test="${not empty sessionScope.usuarioEnSesion}">
            <li class="nav-item"><a class="nav-link" href="/mis-servicios">Mis Servicios</a></li>
            <li class="nav-item"><a class="nav-link active" href="/mis-solicitudes-enviadas">Enviadas</a></li>
            <li class="nav-item"><a class="nav-link" href="/mis-solicitudes-recibidas">Recibidas</a></li>
         </c:if>
      </ul>
      <form class="d-flex me-3" action="/buscar-servicios" method="get">
         <input class="form-control me-2" type="search" name="query" placeholder="¿Qué servicio buscas?">
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
<main class="container py-5">
   <h2 class="mb-4 text-center">Mis Solicitudes Enviadas</h2>

   <c:if test="${not empty solicitudes}">
      <div class="table-responsive">
         <table class="table table-dark table-bordered table-hover text-center align-middle">
            <thead>
               <tr>
                  <th>ID</th>
                  <th>Proveedor</th>
                  <th>Servicio</th>
                  <th>Estado</th>
                  <th>Comentario</th>
                  <th>Fecha</th>
                  <th>Chat</th>
               </tr>
            </thead>
            <tbody>
               <c:forEach var="solicitud" items="${solicitudes}">
                  <tr>
                     <td>${solicitud.id}</td>
                     <td>${solicitud.servicio.usuario.nombre}</td>
                     <td>${solicitud.servicio.nombre}</td>
                     <td>${solicitud.estado}</td>
                     <td>${solicitud.comentarioAdicional}</td>
                     <td><fmt:formatDate value="${solicitud.fechaSolicitud}" pattern="dd/MM/yyyy" /></td>
                     <td>
                        <c:choose>
                           <c:when test="${chatsCreados[solicitud.id]}">
                              <form action="/chat/continuar" method="post">
                                 <input type="hidden" name="solicitudId" value="${solicitud.id}" />
                                 <button type="submit" class="btn btn-warning btn-sm">Continuar Chat</button>
                              </form>
                           </c:when>
                           <c:otherwise>
                              <button type="button" class="btn btn-secondary btn-sm" onclick="chatNoDisponible()">
                                 Chat no disponible
                              </button>
                           </c:otherwise>
                        </c:choose>
                     </td>
                  </tr>
               </c:forEach>
            </tbody>
         </table>
      </div>
   </c:if>

   <c:if test="${empty solicitudes}">
      <div class="alert alert-info text-center">Aún no has enviado ninguna solicitud.</div>
   </c:if>
</main>

<!-- Footer -->
<footer class="bg-dark text-white text-center py-3 mt-auto">
   <p>Pololitos &copy; 2025. Todos los derechos reservados</p>
   <ul class="nav justify-content-center">
      <li class="nav-item"><a class="nav-link text-white" href="/contacto">Contacto</a></li>
      <li class="nav-item"><a class="nav-link text-white" href="/nosotros">Nosotros</a></li>
   </ul>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
   function chatNoDisponible() {
      Swal.fire({
         icon: 'info',
         title: 'Chat no disponible',
         text: 'El proveedor debe iniciar la conversación primero.',
         confirmButtonColor: '#3085d6'
      });
   }
</script>
</body>
</html>
