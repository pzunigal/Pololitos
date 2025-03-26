<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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