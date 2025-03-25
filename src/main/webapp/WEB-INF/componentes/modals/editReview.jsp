<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<div class="modal fade" id="modalEditar" tabindex="-1">
    <div class="modal-dialog">
       <form id="formEditarResena" method="post" action="${pageContext.request.contextPath}/resena/editar" class="modal-content text-dark" onsubmit="return validarEstrellasEdit()">
          <div class="modal-header">
             <h5 class="modal-title">Editar Reseña</h5>
             <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
          </div>
          <div class="modal-body">
             <input type="hidden" name="resenaId" id="editarResenaId">
             <label class="form-label">Calificación:</label>
             <div class="stars" id="editarStars">
                <c:forEach var="i" begin="1" end="5">
                   <c:set var="rev" value="${6 - i}" />
                   <input type="radio" id="editarStar${rev}" name="calificacion" value="${rev}" />
                   <label for="editarStar${rev}" class="star">&#9733;</label>
                </c:forEach>
             </div>
             <label for="comentarioEditar" class="mt-2">Comentario:</label>
             <textarea id="comentarioEditar" name="comentario" class="form-control" rows="3"></textarea>
          </div>
          <div class="modal-footer">
             <button type="submit" class="btn btn-primary">Guardar cambios</button>
             <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
          </div>
       </form>
    </div>
 </div>