<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark px-4">
  <a class="navbar-brand" href="/">
    <img src="<c:url value='/img/pololitosBlanco.png' />" alt="Logo pololitos" height="40">
  </a>
  <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
          aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarNav">
    <!-- Enlaces -->
    <ul class="navbar-nav me-auto mb-2 mb-lg-0 container-fluid">
      <li class="nav-item"><a class="nav-link" href="/servicios">Servicios</a></li>
      <c:if test="${not empty usuarioEnSesion}">
        <li class="nav-item"><a class="nav-link" href="/mis-servicios">Mis Servicios</a></li>
        <li class="nav-item"><a class="nav-link" href="/mis-solicitudes-enviadas">Enviadas</a></li>
        <li class="nav-item"><a class="nav-link" href="/mis-solicitudes-recibidas">Recibidas</a></li>
      </c:if>
    </ul>

    <!-- Contenedor adicional -->
    <div class="d-lg-flex w-100 justify-content-end align-items-center flex-wrap gap-3">
      
      <!-- Buscador y notificación -->
      <div class="d-flex align-items-center gap-2">
        <form class="d-flex" action="/buscar-servicios" method="get">
          <input class="form-control me-2" type="search" name="query" placeholder="Buscar">
          <button class="btn btn-outline-light" type="submit"><i class="bi bi-search"></i></button>
        </form>

        <c:if test="${not empty usuarioEnSesion}">
          <div class="dropdown">
            <button class="btn btn-outline-light position-relative"
                    id="notificacionesDropdown"
                    data-bs-toggle="dropdown"
                    aria-expanded="false">
              <i class="bi bi-bell-fill"></i>
              <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger"
                    id="notificacionBadge" style="display:none;">0</span>
            </button>
            <ul class="dropdown-menu dropdown-menu-end bg-dark text-white"
                aria-labelledby="notificacionesDropdown"
                id="notificacionesLista"
                style="width: 300px; max-height: 400px; overflow-y: auto;">
              <li class="dropdown-item text-white">Cargando notificaciones...</li>
            </ul>
          </div>
        </c:if>
      </div>

      <!-- Perfil y botones -->
      <div class="d-flex align-items-center gap-3 mt-3 mt-lg-0">
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
  </div>
</nav>

<!-- Script para cerrar el navbar en dispositivos móviles -->
<script>
  document.addEventListener("DOMContentLoaded", function () {
    const navbarCollapse = document.getElementById('navbarNav');
    const navLinks = navbarCollapse.querySelectorAll('.nav-link');
    const collapse = new bootstrap.Collapse(navbarCollapse, { toggle: false });

    navLinks.forEach(link => {
      link.addEventListener('click', () => {
        if (window.innerWidth < 992) {
          collapse.hide();
        }
      });
    });
  });
</script>
