<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<h4 class="text-white">Solicitudes Canceladas o Completadas</h4>
<div class="table-responsive">
   <table class="table table-bordered table-hover text-center align-middle inactiva">
      <thead>
         <tr>
            <th>ID</th>
            <th>Proveedor</th>
            <th>Servicio</th>
            <th>Estado</th>
            <th>Comentario</th>
            <th>Fecha</th>
         </tr>
      </thead>
      <tbody>
         <c:forEach var="solicitud" items="${solicitudesInactivas}">
            <tr>
               <td>${solicitud.id}</td>
               <td>${solicitud.servicio.usuario.nombre}</td>
               <td>
                  <a class="servicio-link"
                     href="${pageContext.request.contextPath}/servicio/detalles/${solicitud.servicio.id}">
                     ${solicitud.servicio.nombre}
                  </a>
               </td>
               <td>${solicitud.estado}</td>
               <td>${solicitud.comentarioAdicional}</td>
               <td><fmt:formatDate value="${solicitud.fechaSolicitud}" pattern="dd/MM/yyyy" /></td>
            </tr>
         </c:forEach>
      </tbody>
   </table>
</div>
