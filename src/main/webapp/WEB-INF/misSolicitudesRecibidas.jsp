<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="es">
   <head>
      <meta charset="UTF-8">
      <meta http-equiv="X-UA-Compatible" content="IE=edge">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>Mis Solicitudes Recibidas</title>
      <link rel="stylesheet" href="/css/mis-solicitudes-recibidas.css">
   </head>
   <body>
      <header>
         <div class="nav-container">
            <a href="/">
               <div class="logo-pololitos">
                  <img src="img/pololitosBlanco.png" alt="Logo-pololitos">
               </div>
            </a>
            <nav>
               <ul class="nav-links">
                  <li><a href="/servicios">Servicios</a></li>
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
      <main>
         <div>
            <h1>Mis Solicitudes Recibidas</h1>
            <c:if test="${not empty solicitudes}">
               <table>
                  <thead>
                     <tr>
                        <th>ID</th>
                        <th>Solicitante</th>
                        <th>Servicio</th>
                        <th>Estado</th>
                        <th>Comentario Adicional</th>
                        <th>Acciones</th>
                        <th>Chat con cliente</th>
                     </tr>
                  </thead>
                  <tbody>
                     <c:forEach var="solicitud" items="${solicitudes}">
                        <tr>
                           <td>${solicitud.id}</td>
                           <td>${solicitud.solicitante.nombre}</td>
                           <td>${solicitud.servicio.nombre}</td>
                           <td>${solicitud.estado}</td>
                           <td>${solicitud.comentarioAdicional}</td>
                           <td>
                              <c:if test="${solicitud.estado != 'Aceptada'}">
                                 <form action="/aceptar-solicitud" method="post">
                                    <input type="hidden" name="solicitudId" value="${solicitud.id}">
                                    <button type="submit" class="btn-estado">Aceptar</button>
                                 </form>
                              </c:if>
                           </td>
                           <td>
                              <c:choose>
                                 <c:when test="${chatsCreados[solicitud.id]}">
                                    <form action="/chat/continuar" method="post">
                                       <input type="hidden" name="solicitudId" value="${solicitud.id}">
                                       <button type="submit" class="ContinuarChatButton">Continuar Chat</button>
                                    </form>
                                 </c:when>
                                 <c:otherwise>
                                    <form action="/chat/crear" method="post">
                                       <input type="hidden" name="solicitanteId" value="${solicitud.solicitante.id}">
                                       <input type="hidden" name="solicitudId" value="${solicitud.id}">
                                       <button type="submit" class="btn btn-chat">Iniciar Chat</button>
                                    </form>
                                 </c:otherwise>
                              </c:choose>
                           </td>
                        </tr>
                     </c:forEach>
                  </tbody>
               </table>
            </c:if>
            <c:if test="${empty solicitudes}">
               <p>No tienes solicitudes recibidas aún.</p>
            </c:if>
         </div>
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