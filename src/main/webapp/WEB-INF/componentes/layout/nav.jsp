<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark px-4">
  <a class="navbar-brand" href="/">
    <img src="<c:url value='/img/pololitosBlanco.png' />" alt="Logo pololitos" height="40">
  </a>
  <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarNav">
    <ul class="navbar-nav me-auto mb-2 mb-lg-0">
      <li class="nav-item"><a class="nav-link" href="/servicios">Servicios</a></li>
      <c:if test="${not empty usuarioEnSesion}">
        <li class="nav-item"><a class="nav-link" href="/mis-servicios">Mis Servicios</a></li>
        <li class="nav-item"><a class="nav-link" href="/mis-solicitudes-enviadas">Enviadas</a></li>
        <li class="nav-item"><a class="nav-link" href="/mis-solicitudes-recibidas">Recibidas</a></li>
      </c:if>
    </ul>

   

    <form class="d-flex me-3" action="/buscar-servicios" method="get">
      <input class="form-control me-2" type="search" name="query" placeholder="Buscar">
      <button class="btn btn-outline-light" type="submit"><i class="bi bi-search"></i></button>
      <!-- Notificaciones solo si hay sesión -->
     <c:if test="${not empty usuarioEnSesion}">
      <div class="dropdown ms-3">
          <button class="btn btn-outline-light position-relative"
                  id="notificacionesDropdown"
                  data-bs-toggle="dropdown"
                  aria-expanded="false">
            <i class="bi bi-bell-fill"></i>
            <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger"
                  id="notificacionBadge" style="display:none;">0</span>
          </button>

        </div>
        
  </c:if>
    </form>
     
    <div class="d-flex align-items-center flex-wrap gap-3 mt-3 mt-sm-3 mt-md-3 mt-lg-0">


      <c:choose>
        <c:when test="${not empty usuarioEnSesion}">
          <a href="/perfilUsuario">
            <img src="${usuarioEnSesion.fotoPerfil}" alt="Perfil" width="40" height="40" class="rounded-circle">
          </a>
          <a href="/servicios/publicar" class="btn btn-success">Crear Servicio</a>
          <a href="/logout" class="btn btn-danger">Cerrar Sesión</a>
        </c:when>
        <c:otherwise>
          <a href="/login" class="btn btn-outline-light">Iniciar sesión</a>
          <a href="/registro" class="btn btn-outline-info">Regístrate</a>
        </c:otherwise>
      </c:choose>
    </div>
    

  </div>
</nav>



<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

