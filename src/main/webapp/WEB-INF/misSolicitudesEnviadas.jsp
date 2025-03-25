<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
   <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
      <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
         <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!DOCTYPE html>
            <html lang="es">

            <head>
               <meta charset="UTF-8">
               <meta name="viewport" content="width=device-width, initial-scale=1.0">
               <title>Mis Solicitudes Enviadas</title>

               <!-- Bootstrap -->
               <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
               <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
               <link href="https://fonts.googleapis.com/css2?family=Quicksand&display=swap" rel="stylesheet">
               <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

               <style>
                  html,
                  body {
                     height: 100%;
                     margin: 0;
                     font-family: 'Quicksand', sans-serif;
                     background-color: #1e1e1e;
                     color: white;
                  }

                  body {
                     display: flex;
                     flex-direction: column;
                  }

                  main {
                     flex: 1;
                  }

                  .table thead {
                     color: #f1c40f;
                  }

                  .table td,
                  .table th {
                     vertical-align: middle;
                  }

                  .inactiva {
                     filter: grayscale(100%);
                     opacity: 0.6;
                  }

                  a.servicio-link {
                     display: block;
                     color: #0dcaf0;
                     text-decoration: underline;
                     font-weight: 600;
                  }
               </style>
            </head>

            <body>

               <!-- Navbar -->
               <%@ include file="/WEB-INF/componentes/layout/nav.jsp" %>

               <!-- Contenido -->
               <main class="container py-5">
                  <h2 class="mb-4 text-center">Mis Solicitudes Enviadas</h2>

                  <!-- ACTIVAS -->
                  <c:if test="${not empty error}">
                     <div class="alert alert-danger text-center" role="alert">
                        ${error}
                     </div>
                  </c:if>

                  <c:if test="${not empty solicitudesActivas}">
                     <h4 class="text-warning">Solicitudes Activas</h4>
                     <div class="table-responsive mb-5">
                        <table class="table table-dark table-bordered table-hover text-center align-middle">
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
                                       <a class="servicio-link"
                                          href="${pageContext.request.contextPath}/servicio/detalles/${solicitud.servicio.id}">
                                          ${solicitud.servicio.nombre}
                                       </a>
                                    </td>
                                    <td>${solicitud.estado}</td>
                                    <td>${solicitud.comentarioAdicional}</td>
                                    <td>
                                       <fmt:formatDate value="${solicitud.fechaSolicitud}" pattern="dd/MM/yyyy" />
                                    </td>
                                    <td>
                                       <button class="btn btn-outline-danger btn-sm mb-1 btn-cancelar"
                                          data-id="${solicitud.id}">
                                          Cancelar
                                       </button>



                                    </td>
                                    <td>
                                       <c:choose>
                                          <c:when test="${chatsCreados[solicitud.id]}">
                                             <form action="/chat/continuar" method="post">
                                                <input type="hidden" name="solicitudId" value="${solicitud.id}" />
                                                <button type="submit" class="btn btn-warning btn-sm">Continuar
                                                   Chat</button>
                                             </form>
                                          </c:when>
                                          <c:otherwise>
                                             <button type="button" class="btn btn-secondary btn-sm"
                                                onclick="chatNoDisponible()">
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

                  <!-- INACTIVAS -->
                  <c:if test="${not empty solicitudesInactivas}">
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
                                    <td>
                                       <fmt:formatDate value="${solicitud.fechaSolicitud}" pattern="dd/MM/yyyy" />
                                    </td>
                                 </tr>
                              </c:forEach>
                           </tbody>
                        </table>
                     </div>
                  </c:if>

                  <c:if test="${empty solicitudesActivas and empty solicitudesInactivas}">
                     <div class="alert alert-info text-center">Aún no has enviado ninguna solicitud.</div>
                  </c:if>
               </main>

               <!-- Footer -->
               <%@ include file="/WEB-INF/componentes/layout/footer.jsp" %>

               <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
               <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

               <script>
                  function chatNoDisponible() {
                     Swal.fire({
                        icon: 'info',
                        title: 'Chat no disponible',
                        text: 'El proveedor debe iniciar la conversación primero.',
                        confirmButtonColor: '#3085d6'
                     });
                  }

                  // Confirmar cancelar solicitud
                  document.querySelectorAll('.btn-cancelar').forEach(btn => {
                     btn.addEventListener('click', () => {
                        const id = btn.dataset.id;

                        Swal.fire({
                           title: '¿Estás seguro?',
                           text: 'Esta acción cancelará tu solicitud y no podrá ser revertida.',
                           icon: 'warning',
                           showCancelButton: true,
                           confirmButtonColor: '#d33',
                           cancelButtonColor: '#aaa',
                           confirmButtonText: 'Sí, cancelar',
                           cancelButtonText: 'No'
                        }).then((result) => {
                           if (result.isConfirmed) {
                              const form = document.createElement('form');
                              form.method = 'POST';
                              form.action = '/cancelar-solicitud';

                              const input = document.createElement('input');
                              input.type = 'hidden';
                              input.name = 'solicitudId';
                              input.value = id;
                              form.appendChild(input);

                              document.body.appendChild(form);
                              form.submit();
                           }
                        });
                     });
                  });
               </script>


            </body>

            </html>