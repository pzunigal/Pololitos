<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="es">
<head>
   <meta charset="UTF-8">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <title>Servicios</title>

   <!-- Fuentes -->
   <link rel="preconnect" href="https://fonts.googleapis.com">
   <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
   <link href="https://fonts.googleapis.com/css2?family=Noto+Sans&family=Quicksand&family=Roboto&display=swap" rel="stylesheet">

   <!-- Bootstrap & Icons -->
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
   <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

   <style>
      body {
         font-family: 'Quicksand', 'Roboto', 'Noto Sans', sans-serif;
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
<nav class="navbar navbar-expand-lg navbar-dark bg-dark px-4">
   <a class="navbar-brand" href="/">
      <img src="<c:url value='/img/pololitosBlanco.png' />" alt="Logo" height="40">
   </a>
   <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
      <span class="navbar-toggler-icon"></span>
   </button>
   <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
         <li class="nav-item"><a class="nav-link active" href="/servicios">Servicios</a></li>
         <c:if test="${not empty sessionScope.usuarioEnSesion}">
            <li class="nav-item"><a class="nav-link" href="/mis-servicios">Mis Servicios</a></li>
            <li class="nav-item"><a class="nav-link" href="/mis-solicitudes-enviadas">Enviadas</a></li>
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

   <!-- Botón para abrir filtros -->
   <div class="d-flex justify-content-start mb-4">
      <button class="btn btn-outline-light" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasFiltro">
         <i class="bi bi-funnel"></i> Filtros
      </button>
   </div>

   <!-- Offcanvas lateral -->
   <div class="offcanvas offcanvas-start text-bg-dark" tabindex="-1" id="offcanvasFiltro" aria-labelledby="offcanvasFiltroLabel">
      <div class="offcanvas-header">
         <h5 class="offcanvas-title" id="offcanvasFiltroLabel">Filtrar Servicios</h5>
         <button type="button" class="btn-close btn-close-white" data-bs-dismiss="offcanvas"></button>
      </div>
      <div class="offcanvas-body">
         <form action="/servicios" method="get">
            <div class="mb-3">
               <label for="categoriaId" class="form-label">Categoría</label>
               <select name="categoriaId" id="categoriaId" class="form-select">
                  <option value="">Todas las categorías</option>
                  <c:forEach var="categoria" items="${categorias}">
                     <option value="${categoria.id}" <c:if test="${param.categoriaId == categoria.id}">selected</c:if>>
                        ${categoria.nombre}
                     </option>
                  </c:forEach>
               </select>
            </div>
            <button type="submit" class="btn btn-warning w-100">
               <i class="bi bi-search"></i> Aplicar Filtro
            </button>
         </form>
      </div>
   </div>

   <h1 class="text-center mb-4">Servicios por Categoría</h1>

   <c:forEach var="categoria" items="${categorias}">
      <c:if test="${empty param.categoriaId or param.categoriaId == categoria.id}">
         <h2 class="text-white mt-4">${categoria.nombre}</h2>
         <c:if test="${empty categoria.servicios}">
            <p class="text-white-50">No hay servicios disponibles en esta categoría.</p>
         </c:if>
         <div class="row">
            <c:forEach var="servicio" items="${categoria.servicios}">
               <div class="col-md-4 mb-4">
                  <div class="card bg-dark text-white h-100">
                     <a href="${pageContext.request.contextPath}/servicio/detalles/${servicio.id}">
                        <img src="${servicio.imgUrl}" class="card-img-top" style="height: 220px; object-fit: cover;" alt="${servicio.nombre}">
                     </a>
                     <div class="card-body d-flex flex-column">
                        <h5 class="card-title text-truncate">${servicio.nombre}</h5>
                        <p class="card-text mb-1"><strong>Precio:</strong> $${servicio.precio}</p>
                        <p class="card-text"><small>Autor: ${servicio.usuario.nombre} ${servicio.usuario.apellido}</small></p>
                        <div class="mt-auto">
                           <c:choose>
                              <c:when test="${empty usuarioSesion or usuarioSesion.id ne servicio.usuario.id}">
                                 <a href="${pageContext.request.contextPath}/servicio/detalles/${servicio.id}" class="btn btn-primary btn-sm me-2 mb-2">
                                    <i class="bi bi-hand-index-thumb"></i> Solicitar Servicio
                                 </a>
                                 <button class="btn btn-outline-light btn-sm mb-2" data-bs-toggle="modal" data-bs-target="#contactModal"
                                    onclick="openModal('${servicio.usuario.nombre}', '${servicio.nombre}')">
                                    <i class="bi bi-chat-dots"></i> Contactar
                                 </button>
                              </c:when>
                              <c:otherwise>
                                 <a href="${pageContext.request.contextPath}/servicio/detalles/${servicio.id}" class="btn btn-outline-info btn-sm">
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
      </c:if>
   </c:forEach>
</main>

<!-- Footer -->
<footer class="bg-dark text-white text-center py-3 mt-auto">
   <p class="mb-1">Pololitos &copy; 2025. Todos los derechos reservados</p>
   <ul class="nav justify-content-center">
      <li class="nav-item"><a class="nav-link text-white" href="/contacto">Contacto</a></li>
      <li class="nav-item"><a class="nav-link text-white" href="/nosotros">Nosotros</a></li>
   </ul>
</footer>

<!-- Scripts -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
   function openModal(nombreVendedor, nombreServicio) {
      alert(`Simulación de contacto con ${nombreVendedor} para el servicio: ${nombreServicio}`);
   }
</script>
</body>
</html>
