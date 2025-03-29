<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<!DOCTYPE html>
<html lang="es">
<head>
   <meta charset="UTF-8">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <title>Mis Servicios</title>

   <!-- Fuentes personalizadas -->
   <link rel="preconnect" href="https://fonts.googleapis.com">
   <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
   <link href="https://fonts.googleapis.com/css2?family=Noto+Sans:ital,wght@0,100..900;1,100..900&family=Quicksand:wght@300..700&family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&family=Winky+Sans:ital,wght@0,300..900;1,300..900&display=swap" rel="stylesheet">

   <!-- Bootstrap & Icons -->
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
   <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

   <!-- Estilos integrados -->
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

<body class="d-flex flex-column body-with-bg">

   <!-- Navbar -->
   <%@ include file="/WEB-INF/componentes/layout/nav.jsp" %>

   <!-- Contenido principal -->
   <main class="container py-5">
      <h1 class="text-center mb-4">Mis Servicios</h1>

      <c:if test="${not empty error}">
         <div class="alert alert-danger alert-dismissible fade show text-center" role="alert">
            ${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
         </div>
      </c:if>

      <c:if test="${not empty servicios}">
         <div class="row justify-content-center">
            <c:forEach var="servicio" items="${servicios}">
               <div class="col-md-3 col-sm-6 mb-4">
                  <div class="card text-white bg-dark h-100" style="min-height: 450px;">
                     <img src="${servicio.imgUrl}" class="card-img-top" alt="${servicio.nombre}" style="height: 200px; object-fit: cover;">
                     <div class="card-body d-flex flex-column">
                        <h5 class="card-title text-truncate">${servicio.nombre}</h5>
                        <p class="card-text mb-1"><strong>Precio:</strong> $<fmt:formatNumber value="${servicio.precio}" type="number" groupingUsed="true" /></p>

                        <p class="card-text mb-3"><strong>Ubicación:</strong> ${servicio.ciudad}</p>
                        <div class="mt-auto d-flex justify-content-between">
                           <form action="${pageContext.request.contextPath}/eliminar-servicio/${servicio.id}" method="post">
                              <button type="submit" class="btn btn-sm btn-danger" onclick="return confirm('¿Estás seguro de que quieres eliminar este servicio?');">
                                 <i class="bi bi-trash"></i>
                              </button>
                           </form>
                           <a href="${pageContext.request.contextPath}/servicio/detalles/${servicio.id}" class="btn btn-sm btn-primary">
                              <i class="bi bi-eye"></i>
                           </a>
                           <a href="${pageContext.request.contextPath}/editar-servicio/${servicio.id}" class="btn btn-sm btn-secondary">
                              <i class="bi bi-pencil"></i>
                           </a>
                        </div>
                     </div>
                  </div>
               </div>
            </c:forEach>
         </div>
      </c:if>

      <c:if test="${empty servicios}">
         <p class="text-center fs-5">No tienes servicios publicados.</p>
      </c:if>

      <div class="text-center mt-4">
         <a href="${pageContext.request.contextPath}/servicios/publicar" class="btn btn-success btn-lg">Publicar un nuevo servicio</a>
      </div>
   </main>

   <!-- Footer -->
   <%@ include file="/WEB-INF/componentes/layout/footer.jsp" %>

   <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
   <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
   <c:if test="${not empty exito}">
   <script>
      document.addEventListener("DOMContentLoaded", () => {
         Swal.fire({
            icon: 'success',
            title: '¡Éxito!',
            text: '${exito}',
            confirmButtonColor: '#198754',
            background: '#1e1e1e',
            color: '#fff'
         });
      });
   </script>
</c:if>
</body>
</html>
