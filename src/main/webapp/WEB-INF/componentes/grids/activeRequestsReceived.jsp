<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<c:if test="${not empty solicitudesActivas}">
        <h4 class="text-warning">Solicitudes Activas</h4>
        <div class="table-responsive mb-5">
          <table
            class="table table-dark table-bordered table-hover text-center align-middle"
          >
            <thead>
              <tr>
                <th>ID</th>
                <th>Solicitante</th>
                <th>Servicio</th>
                <th>Estado</th>
                <th>Comentario</th>
                <th>Acciones</th>
                <th>Chat</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="solicitud" items="${solicitudesActivas}">
                <tr>
                  <td>${solicitud.id}</td>
                  <td>${solicitud.solicitante.nombre}</td>
                  <td>
                    <a
                      href="${pageContext.request.contextPath}/servicio/detalles/${solicitud.servicio.id}"
                      class="text-info text-decoration-underline"
                    >
                      ${solicitud.servicio.nombre}
                    </a>
                  </td>
                  <td>${solicitud.estado}</td>
                  <td>${solicitud.comentarioAdicional}</td>
                  <td>
                    <c:if test="${solicitud.estado == 'Enviado'}">
                      <button
                        class="btn btn-success btn-sm mb-1 btn-aceptar"
                        data-id="${solicitud.id}"
                      >
                        Aceptar
                      </button>

                      <button
                        class="btn btn-danger btn-sm mb-1 btn-rechazar"
                        data-id="${solicitud.id}"
                      >
                        Rechazar
                      </button>
                    </c:if>
                    <c:if test="${solicitud.estado == 'Aceptada'}">
                      <button
                        class="btn btn-outline-success btn-sm mb-1 btn-completar"
                        data-id="${solicitud.id}"
                      >
                        Trabajo Completado
                      </button>
                    </c:if>
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
                        <form action="/chat/crear" method="post">
                          <input
                            type="hidden"
                            name="solicitanteId"
                            value="${solicitud.solicitante.id}"
                          />
                          <input
                            type="hidden"
                            name="solicitudId"
                            value="${solicitud.id}"
                          />
                          <button type="submit" class="btn btn-primary btn-sm">
                            Iniciar Chat
                          </button>
                        </form>
                      </c:otherwise>
                    </c:choose>
                  </td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </div>
      </c:if>