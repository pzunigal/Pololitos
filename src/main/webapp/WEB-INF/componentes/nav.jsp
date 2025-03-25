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
            <c:if test="${not empty sessionScope.usuarioEnSesion}">
                <li class="nav-item"><a class="nav-link" href="/mis-servicios">Mis Servicios</a></li>
                <li class="nav-item"><a class="nav-link" href="/mis-solicitudes-enviadas">Enviadas</a></li>
                <li class="nav-item"><a class="nav-link" href="/mis-solicitudes-recibidas">Recibidas</a></li>
            </c:if>
        </ul>
        <form class="d-flex me-3" action="/buscar-servicios" method="get">
            <input class="form-control me-2" type="search" name="query" placeholder="Buscar">
            <button class="btn btn-outline-light" type="submit"><i class="bi bi-search"></i></button>
        </form>
        <c:choose>
            <c:when test="${not empty sessionScope.usuarioEnSesion}">
                <a href="/perfilUsuario" class="me-3">
                    <img src="${sessionScope.usuarioEnSesion.fotoPerfil}" alt="Perfil" width="40" height="40" class="rounded-circle">
                </a>
                <a href="/servicios/publicar" class="btn btn-success me-2">Crear Servicio</a>
                <a href="/logout" class="btn btn-danger">Cerrar Sesión</a>
            </c:when>
            <c:otherwise>
                <a href="/login" class="btn btn-outline-light me-2">Iniciar sesión</a>
                <a href="/registro" class="btn btn-outline-info">Regístrate</a>
            </c:otherwise>
        </c:choose>
    </div>
</nav>
