<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<c:if test="${not empty solicitudesInactivas}">
        <h4 class="text-white">Solicitudes Rechazadas o Completadas</h4>
        <div class="table-responsive">
          <table
            class="table table-bordered table-hover text-center align-middle inactiva"
          >
            <thead>
              <tr>
                <th>ID</th>
                <th>Solicitante</th>
                <th>Servicio</th>
                <th>Estado</th>
                <th>Comentario</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="solicitud" items="${solicitudesInactivas}">
                <tr>
                  <td>${solicitud.id}</td>
                  <td>${solicitud.solicitante.nombre}</td>
                  <td>${solicitud.servicio.nombre}</td>
                  <td>${solicitud.estado}</td>
                  <td>${solicitud.comentarioAdicional}</td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </div>
      </c:if>

      <c:if test="${empty solicitudesActivas and empty solicitudesInactivas}">
        <div class="alert alert-info text-center">
          No tienes solicitudes recibidas aún.
        </div>
      </c:if>