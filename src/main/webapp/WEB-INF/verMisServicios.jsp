<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="es">
   <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>Mis Servicios</title>
      <!-- Agregar Bootstrap Icons -->
      <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
      <link rel="stylesheet" href="/css/mis-servicios.css">
   </head>
   <header>
      <div class="nav-container">
         <a href="/">
            <div class="logo">
               <img src="img/pololitosBlanco.png" alt="Logo pololitos">
            </div>
         </a>
         <nav>
            <ul class="nav-links">
               <li><a href="/servicios">Servicios</a></li>
               <!-- Agregar la opción Mis Servicios solo si el usuario está logueado -->
               <c:choose>
                  <c:when test="${not empty sessionScope.usuarioEnSesion}">
                     <li><a href="/mis-servicios">Mis Servicios</a></li>
                  </c:when>
               </c:choose>
               <c:choose>
                  <c:when test="${not empty sessionScope.usuarioEnSesion}">
                     <li><a href="/mis-solicitudes-enviadas">Enviadas</a></li>
                  </c:when>
               </c:choose>
               <c:choose>
                  <c:when test="${not empty sessionScope.usuarioEnSesion}">
                     <li><a href="/mis-solicitudes-recibidas">Recibidas</a></li>
                  </c:when>
               </c:choose>
            </ul>
         </nav>
      </div>
      <div class="user-info">
         <form action="/buscar-servicios" method="get">
            <div class="circle-busqueda" id="busqueda-container">
                <input type="text" name="query" id="busqueda-input" placeholder="¿Qué servicio buscas?">
                <button type="submit" id="busqueda-btn">
                    <img src="img/busqueda.png" alt="lupa de busqueda" id="busqueda-icon">
                </button>
            </div>
        </form>
         <c:choose>
            <c:when test="${not empty sessionScope.usuarioEnSesion}">
               <a href="/perfilUsuario">
               <img src="${sessionScope.usuarioEnSesion.fotoPerfil}" alt="Foto de perfil"
                  width="40" height="40" style="border-radius: 50%;">
               </a>
               <a href="/servicios/publicar"><button>Crear Servicio</button></a>
               <a href="/logout"><button>Cerrar Sesión</button></a>
            </c:when>
            <c:otherwise>
               <a href="/login"><button>Iniciar sesión</button></a>
               <a href="/registro"><button>Regístrate</button></a>
            </c:otherwise>
         </c:choose>
      </div>
   </header>
   <body>
      <main>
         <h1>Mis Servicios</h1>
         <c:if test="${not empty error}">
            <div class="alert alert-danger">Hubo un error al intentar eliminar el servicio.</div>
         </c:if>
         <c:if test="${not empty servicios}">
            <div class="container">
               <div class="row">
                  <c:forEach var="servicio" items="${servicios}">
                     <div class="col-md-4">
                        <div class="card">
                           <img src="${servicio.imgUrl}" class="card-img-top" alt="${servicio.nombre}">
                           <div class="card-body">
                              <h5 class="card-title">${servicio.nombre}</h5>
                              <p><strong>Precio:</strong> $${servicio.precio}</p>
                              <p><strong>Ubicación:</strong> ${servicio.ciudad}</p>
                              <!-- Botón de editar con icono de lápiz -->
                               <div class="button-container">
                                    <form action="${pageContext.request.contextPath}/eliminar-servicio/${servicio.id}" method="post" style="display:inline;">
                                        <button type="submit" class="btn btn-danger" onclick="return confirm('¿Estás seguro de que quieres eliminar este servicio?');">
                                        <i class="bi bi-trash"></i>
                                        </button>
                                    </form>
                                    <!-- Botón de ojo para ver detalles con icono de ojo -->
                                    <a href="${pageContext.request.contextPath}/servicio/detalles/${servicio.id}" class="btn btn-info">
                                    <i class="bi bi-eye"></i>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/editar-servicio/${servicio.id}" class="btn btn-info">
                                    <i class="bi bi-pencil"></i>
                                    </a>
                                </div>
                           </div>
                        </div>
                     </div>
               </div>
               </c:forEach>
            </div>
         </c:if>
         <c:if test="${empty servicios}">
            <p>No tienes servicios publicados.</p>
         </c:if>
         <a href="${pageContext.request.contextPath}/servicios/publicar" class="btn-publicar">Publicar un nuevo servicio</a>
      </main>
      <footer>
         <p>Pololitos &copy; 2025. Todos los derechos reservados</p>
         <ul class="nav-footer">
            <li><a href="/contacto">Contacto</a></li>
            <li><a href="/nosotros">Nosotros</a></li>
         </ul>
      </footer>
   </body>
</html>