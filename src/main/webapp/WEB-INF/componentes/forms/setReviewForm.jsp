<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

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