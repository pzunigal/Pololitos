<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<c:forEach var="categoria" items="${categorias}">
      <c:if test="${empty param.categoriaId or param.categoriaId == categoria.id}">
         <h2 class="text-white mt-4">${categoria.nombre}</h2>
         <c:if test="${empty categoria.servicios}">
            <p class="text-white-50">No hay servicios disponibles en esta categoría.</p>
         </c:if>

         <div class="position-relative">
            <!-- Carrusel -->
            <div class="servicio-carrusel" id="carrusel-${categoria.id}">
               <div class="servicio-carrusel-inner" id="inner-${categoria.id}">
                  <c:forEach var="servicio" items="${categoria.servicios}">
                     <div class="servicio-card">
                        <div class="card bg-dark text-white h-100">
                           <a href="${pageContext.request.contextPath}/servicio/detalles/${servicio.id}">
                              <img src="${servicio.imgUrl}" class="card-img-top" style="height: 220px; object-fit: cover;" alt="${servicio.nombre}">
                           </a>
                           <div class="card-body d-flex flex-column">
                              <h5 class="card-title text-truncate">${servicio.nombre}</h5>
                              <p class="card-text mb-1"><strong>Precio:</strong> $<fmt:formatNumber value="${servicio.precio}" type="number" groupingUsed="true" /></p>
                              <p class="card-text"><small>Autor: ${servicio.usuario.nombre} ${servicio.usuario.apellido}</small></p>
                              <div class="mt-auto m-auto text-center">
                                 <c:choose>
                                    <c:when test="${empty usuarioSesion or usuarioSesion.id ne servicio.usuario.id}">
                                       <a href="${pageContext.request.contextPath}/servicio/detalles/${servicio.id}" class="btn btn-primary btn-sm me-2 mb-2">
                                          <i class="bi bi-hand-index-thumb"></i> Solicitar Servicio
                                       </a>
                                       <br>
                                       <button class="btn btn-outline-light btn-sm mb-2" onclick="openModal('${servicio.usuario.nombre}', '${servicio.nombre}')">
                                          <i class="bi bi-chat-dots"></i> Contactar
                                       </button>
                                    </c:when>
                                    <c:otherwise>
                                       <a href="${pageContext.request.contextPath}/servicio/detalles/${servicio.id}" class="btn btn-outline-info btn-sm">
                                          <i class="bi bi-eye"></i> Ver
                                       </a>
                                    </c:otherwise>
                                 </c:choose>
                              </div>
                           </div>
                        </div>
                     </div>
                  </c:forEach>
               </div>
            </div>
         </div>
      </c:if>
   </c:forEach>