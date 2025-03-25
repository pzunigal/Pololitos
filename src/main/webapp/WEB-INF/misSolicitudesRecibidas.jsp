<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
   <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
      <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

         <!DOCTYPE html>
         <html lang="es">

         <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Mis Solicitudes Recibidas</title>
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
            </style>
         </head>

         <body>

            <!-- Navbar -->
            <%@ include file="/WEB-INF/componentes/layout/nav.jsp" %>

            <main class="container py-5">
               <h2 class="mb-4 text-center">Mis Solicitudes Recibidas</h2>

               <c:if test="${not empty error}">
                  <div class="alert alert-danger text-center">${error}</div>
               </c:if>

               <!-- ACTIVAS -->
               <c:if test="${not empty solicitudesActivas}">
                  <h4 class="text-warning">Solicitudes Activas</h4>
                  <div class="table-responsive mb-5">
                     <table class="table table-dark table-bordered table-hover text-center align-middle">
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
                                    <a href="${pageContext.request.contextPath}/servicio/detalles/${solicitud.servicio.id}"
                                       class="text-info text-decoration-underline">
                                       ${solicitud.servicio.nombre}
                                    </a>
                                 </td>
                                 <td>${solicitud.estado}</td>
                                 <td>${solicitud.comentarioAdicional}</td>
                                 <td>
                                    <c:if test="${solicitud.estado == 'Enviado'}">
                                       <button class="btn btn-success btn-sm mb-1 btn-aceptar"
                                          data-id="${solicitud.id}">
                                          Aceptar
                                       </button>

                                       <button class="btn btn-danger btn-sm mb-1 btn-rechazar"
                                          data-id="${solicitud.id}">
                                          Rechazar
                                       </button>
                                    </c:if>
                                    <c:if test="${solicitud.estado == 'Aceptada'}">
                                       <button class="btn btn-outline-success btn-sm mb-1 btn-completar"
                                          data-id="${solicitud.id}">
                                          Trabajo Completado
                                       </button>
                                    </c:if>




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
                                          <form action="/chat/crear" method="post">
                                             <input type="hidden" name="solicitanteId"
                                                value="${solicitud.solicitante.id}" />
                                             <input type="hidden" name="solicitudId" value="${solicitud.id}" />
                                             <button type="submit" class="btn btn-primary btn-sm">Iniciar Chat</button>
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

               <!-- INACTIVAS -->
               <c:if test="${not empty solicitudesInactivas}">
                  <h4 class="text-white">Solicitudes Rechazadas o Completadas</h4>
                  <div class="table-responsive">
                     <table class="table table-bordered table-hover text-center align-middle inactiva">
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
                  <div class="alert alert-info text-center">No tienes solicitudes recibidas aún.</div>
               </c:if>
            </main>

            <!-- Footer -->
            <%@ include file="/WEB-INF/componentes/layout/footer.jsp" %>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
            
            <script>
               document.addEventListener("DOMContentLoaded", function () {
            
                  // Chat no disponible
                  window.chatNoDisponible = function () {
                     Swal.fire({
                        icon: 'info',
                        title: 'Chat no disponible',
                        text: 'El proveedor debe iniciar la conversación primero.',
                        confirmButtonColor: '#3085d6'
                     });
                  };
            
                  // Confirmar ACEPTAR solicitud
                  document.querySelectorAll('.btn-aceptar').forEach(btn => {
                     btn.addEventListener('click', () => {
                        const id = btn.dataset.id;
            
                        Swal.fire({
                           title: '¿Estás seguro que deseas aceptar esta solicitud?',
                           icon: 'question',
                           showCancelButton: true,
                           confirmButtonText: 'Sí, aceptar',
                           cancelButtonText: 'Cancelar',
                           confirmButtonColor: '#28a745',
                           cancelButtonColor: '#aaa'
                        }).then((result) => {
                           if (result.isConfirmed) {
                              const form = document.createElement('form');
                              form.method = 'POST';
                              form.action = '/aceptar-solicitud';
            
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
            
                  // Confirmar RECHAZAR solicitud
                  document.querySelectorAll('.btn-rechazar').forEach(btn => {
                     btn.addEventListener('click', () => {
                        const id = btn.dataset.id;
            
                        Swal.fire({
                           title: '¿Estás seguro que deseas rechazar esta solicitud?',
                           icon: 'warning',
                           showCancelButton: true,
                           confirmButtonText: 'Sí, rechazar',
                           cancelButtonText: 'Cancelar',
                           confirmButtonColor: '#d33',
                           cancelButtonColor: '#aaa'
                        }).then((result) => {
                           if (result.isConfirmed) {
                              const form = document.createElement('form');
                              form.method = 'POST';
                              form.action = '/rechazar-solicitud';
            
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
            
                  // Confirmar TRABAJO COMPLETADO
                  document.querySelectorAll('.btn-completar').forEach(btn => {
                     btn.addEventListener('click', () => {
                        const id = btn.dataset.id;
            
                        Swal.fire({
                           title: '¿Deseas marcar esta solicitud como trabajo completado?',
                           text: 'Esta acción confirmará que el servicio fue realizado.',
                           icon: 'success',
                           showCancelButton: true,
                           confirmButtonText: 'Sí, marcar como completado',
                           cancelButtonText: 'Cancelar',
                           confirmButtonColor: '#198754',
                           cancelButtonColor: '#aaa'
                        }).then((result) => {
                           if (result.isConfirmed) {
                              const form = document.createElement('form');
                              form.method = 'POST';
                              form.action = '/completar-solicitud';
            
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
            
               });
            </script>

         </body>

         </html>