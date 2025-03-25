<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %>

<c:if test="${not isAuthorInSesion}">
  <div class="card bg-dark text-white mb-4 p-4">
    <h5>Enviar Solicitud</h5>
    <form
      action="${pageContext.request.contextPath}/crear-solicitud"
      method="post"
    >
      <textarea
        name="mensaje"
        class="form-control mb-3"
        placeholder="Mensaje para el proveedor..."
        required
      ></textarea>
      <input type="hidden" name="servicioId" value="${servicio.id}" />
      <button class="btn btn-success" type="submit">Enviar Solicitud</button>
    </form>
  </div>
</c:if>
