<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

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
   
      .servicio-carrusel {
         overflow-x: auto;
         padding: 10px 10px 20px 10px;
         white-space: nowrap;
         -webkit-overflow-scrolling: touch;
         scroll-behavior: smooth;
      }
   
      .servicio-carrusel-inner {
         display: inline-flex;
         gap: 16px;
      }
      .scroll-hint {
   position: absolute;
   top: 50%;
   transform: translateY(-50%);
   background-color: rgba(0, 0, 0, 0.7);
   color: white;
   padding: 8px 12px;
   border-radius: 20px;
   font-size: 0.85rem;
   display: flex;
   align-items: center;
   gap: 6px;
   z-index: 10;
   pointer-events: none;
   opacity: 0;
   transition: opacity 0.3s ease;
}

.scroll-hint-left {
   left: 10px;
}

.scroll-hint-right {
   right: 10px;
}

.scroll-hint.visible {
   opacity: 1;
}

   
      .servicio-card {
         flex: 0 0 auto;
         width: 300px;
      }
   
      .skeleton {
         background-color: rgba(255,255,255,0.1);
         border-radius: 8px;
         animation: pulse 1.5s infinite;
         height: 300px;
         width: 300px;
      }
   
      @keyframes pulse {
         0% { opacity: 1; }
         50% { opacity: 0.4; }
         100% { opacity: 1; }
      }
   
      /* Scrollbar (opcional) */
      .servicio-carrusel::-webkit-scrollbar {
         height: 8px;
      }
      .servicio-carrusel::-webkit-scrollbar-thumb {
         background-color: rgba(255,255,255,0.2);
         border-radius: 4px;
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
            <div class="mb-3">
               <label for="rangeSlider" class="form-label">Rango de Precio</label>
               <div class="d-flex justify-content-between">
                  <span>$<span id="minValueLabel">0</span></span>
                  <span>$<span id="maxValueLabel">500000</span></span>
               </div>
               <input type="range" class="form-range" id="precioMinSlider" name="precioMin" min="0" max="500000" step="500" value="${param.precioMin != null ? param.precioMin : 0}" oninput="updateSliderLabels()">
               <input type="range" class="form-range mt-2" id="precioMaxSlider" name="precioMax" min="0" max="500000" step="500" value="${param.precioMax != null ? param.precioMax : 500000}" oninput="updateSliderLabels()">
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

         <div class="position-relative">
            <!-- Hints laterales -->
            <div class="scroll-hint scroll-hint-left" id="hint-left-${categoria.id}">
               <i class="bi bi-arrow-left-short"></i> Scrollea
            </div>
            <div class="scroll-hint scroll-hint-right" id="hint-right-${categoria.id}">
               Scrollea <i class="bi bi-arrow-right-short"></i>
            </div>

            <!-- Carrusel -->
            <div class="servicio-carrusel" id="carrusel-${categoria.id}">
               <div class="servicio-carrusel-inner" id="inner-${categoria.id}">
                  <c:forEach var="servicio" items="${categoria.servicios}">
                     <div class="servicio-card">
                        <div class="card bg-dark text-white h-100">
                           <a href="${pageContext.request.contextPath}/servicio/detalles/${servicio.id}">
                              <img src="${servicio.imgUrl}" class="card-img-top" style="height: 220px; object-fit: cover;" alt="${servicio.nombre}">
                           </a>
                           <div class="card-body d-flex flex-column">
                              <h5 class="card-title text-truncate">${servicio.nombre}</h5>
                              <p class="card-text mb-1"><strong>Precio:</strong> $<fmt:formatNumber value="${servicio.precio}" type="number" groupingUsed="true" /></p>
                              <p class="card-text"><small>Autor: ${servicio.usuario.nombre} ${servicio.usuario.apellido}</small></p>
                              <div class="mt-auto">
                                 <c:choose>
                                    <c:when test="${empty usuarioSesion or usuarioSesion.id ne servicio.usuario.id}">
                                       <a href="${pageContext.request.contextPath}/servicio/detalles/${servicio.id}" class="btn btn-primary btn-sm me-2 mb-2">
                                          <i class="bi bi-hand-index-thumb"></i> Solicitar Servicio
                                       </a>
                                       <button class="btn btn-outline-light btn-sm mb-2" onclick="openModal('${servicio.usuario.nombre}', '${servicio.nombre}')">
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
            </div>
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

   function updateSliderLabels() {
      const min = document.getElementById('precioMinSlider').value;
      const max = document.getElementById('precioMaxSlider').value;
      document.getElementById('minValueLabel').textContent = formatCLP(min);
      document.getElementById('maxValueLabel').textContent = formatCLP(max);
   }

   function formatCLP(value) {
      return Number(value).toLocaleString('es-CL');
   }

   updateSliderLabels();

   // Scroll horizontal solo si no estamos en los extremos
   document.querySelectorAll('.servicio-carrusel').forEach(carrusel => {
      carrusel.addEventListener('wheel', function(e) {
         const delta = e.deltaY;
         const atStart = carrusel.scrollLeft === 0;
         const atEnd = carrusel.scrollLeft + carrusel.clientWidth >= carrusel.scrollWidth - 1;

         // Si NO estamos en el inicio o fin, prevenir scroll vertical
         if ((delta < 0 && !atStart) || (delta > 0 && !atEnd)) {
            e.preventDefault();
            carrusel.scrollBy({
               left: delta < 0 ? -300 : 300,
               behavior: 'smooth'
            });
         }
         // Si estamos al inicio o al final, dejamos pasar el scroll vertical
         // automáticamente (no hacemos nada).
      }, { passive: false });
   });
</script>


</body>
</html>
