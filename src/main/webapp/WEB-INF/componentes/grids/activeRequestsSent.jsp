<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>


<c:if test="${not empty error}">
        <div class="alert alert-danger text-center" role="alert">${error}</div>
      </c:if>

      <c:if test="${not empty solicitudesActivas}">
        <h4 class="text-warning">Solicitudes Activas</h4>
        <div class="table-responsive mb-5">
          <table
            class="table table-dark table-bordered table-hover text-center align-middle"
          >
            <thead>
              <tr>
                <th>ID</th>
                <th>Proveedor</th>
                <th>Servicio</th>
                <th>Estado</th>
                <th>Comentario</th>
                <th>Fecha</th>
                <th>Acciones</th>
                <th>Chat</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="solicitud" items="${solicitudesActivas}">
                <tr>
                  <td>${solicitud.id}</td>
                  <td>${solicitud.servicio.usuario.nombre}</td>
                  <td>
                    <a
                      class="servicio-link"
                      href="${pageContext.request.contextPath}/servicio/detalles/${solicitud.servicio.id}"
                    >
                      ${solicitud.servicio.nombre}
                    </a>
                  </td>
                  <td>${solicitud.estado}</td>
                  <td>${solicitud.comentarioAdicional}</td>
                  <td>
                    <fmt:formatDate
                      value="${solicitud.fechaSolicitud}"
                      pattern="dd/MM/yyyy"
                    />
                  </td>
                  <td>
                    <button
                      class="btn btn-outline-danger btn-sm mb-1 btn-cancelar"
                      data-id="${solicitud.id}"
                    >
                      Cancelar
                    </button>
                  </td>
                  <td>
                    <c:choose>
                      <c:when test="${chatsCreados[solicitud.id]}">
                        <form action="/chat/continuar" method="post">
                          <input
                            type="hidden"
                            name="solicitudId"
                            value="${solicitud.id}"
                          />
                          <button type="submit" class="btn btn-warning btn-sm">
                            Continuar Chat
                          </button>
                        </form>
                      </c:when>
                      <c:otherwise>
                        <button
                          type="button"
                          class="btn btn-secondary btn-sm"
                          onclick="chatNoDisponible()"
                        >
                          Chat no disponible
                        </button>
                      </c:otherwise>
                    </c:choose>
                  </td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </div>
      </c:if>