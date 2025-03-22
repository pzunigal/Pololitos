<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Servicios</title>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link rel="stylesheet" href="/css/servicios.css">
    <link rel="stylesheet" href="/css/home.css">

</head>
    
    <body>
        <header>
            <div class="nav-container">
                <a href="/">
                    <div class="logo">
                        <img src="img/pololitosBlanco.png" alt="Logo pololitos">
                    </div>
                </a>
                <nav>
                    <ul class="nav-links">
                        <li><a href="/servicios">Servicios</a></li>
                        <!-- Agregar la opción Mis Servicios solo si el usuario está logueado -->
                        <c:choose>
                            <c:when test="${not empty sessionScope.usuarioEnSesion}">
                                <li><a href="/mis-servicios">Mis Servicios</a></li>
                            </c:when>
                        </c:choose>
                        <c:choose>
                            <c:when test="${not empty sessionScope.usuarioEnSesion}">
                                <li><a href="/mis-solicitudes-enviadas">Enviadas</a></li>
                            </c:when>
                        </c:choose>
                        <c:choose>
                            <c:when test="${not empty sessionScope.usuarioEnSesion}">
                                <li><a href="/mis-solicitudes-recibidas">Recibidas</a></li>
                            </c:when>
                        </c:choose>
                    </ul>
                </nav>
            </div>
            <div class="user-info">
                <form action="/buscar-servicios" method="get">
                    <div class="circle-busqueda" id="busqueda-container">
                        <input type="text" name="query" id="busqueda-input" placeholder="¿Qué servicio buscas?">
                        <button type="submit" id="busqueda-btn">
                            <img src="img/busqueda.png" alt="lupa de busqueda" id="busqueda-icon">
                        </button>
                    </div>
                </form>

                <c:choose>
                    <c:when test="${not empty sessionScope.usuarioEnSesion}">
                        <a href="/perfilUsuario">
                            <img src="${sessionScope.usuarioEnSesion.fotoPerfil}" alt="Foto de perfil"
                                width="40" height="40" style="border-radius: 50%;">
                        </a>
                        <a href="/servicios/publicar"><button>Crear Servicio</button></a>
                        <a href="/logout"><button>Cerrar Sesión</button></a>
                    </c:when>

                    <c:otherwise>
                        <a href="/login"><button>Iniciar sesión</button></a>
                        <a href="/registro"><button>Regístrate</button></a>
                    </c:otherwise>
                </c:choose>
            </div>
        </header>
        <main>
            <div class="filter-container">
                <label for="categoryFilter">Filtrar por categoría:</label>
                <select id="categoryFilter" onchange="filterByCategory()">
                    <option value="">Seleccionar categoría</option>
                    <c:forEach var="categoria" items="${categorias}">
                        <option value="${categoria.id}" ${param.categoriaId == categoria.id ? 'selected' : ''}>
                            ${categoria.nombre}
                        </option>
                    </c:forEach>
                </select>
            </div>
    
            <div class="services-container">
                <h1>Servicios por Categoría</h1>
                <c:forEach var="categoria" items="${categorias}">
                    <c:if test="${empty param.categoriaId or param.categoriaId == categoria.id}">
                        <h2 class="category-title">${categoria.nombre}</h2>
                        <c:if test="${empty categoria.servicios}">
                            <p class="no-services-msg">No hay servicios disponibles en esta categoría.</p>
                        </c:if>
                        <div class="services-list">
                            <c:forEach var="servicio" items="${categoria.servicios}">
                                <div class="service-card-wrapper">
                                    <div class="service-card">
                                        <img src="${servicio.imgUrl}" class="service-image" alt="${servicio.nombre}">
                                        <div class="service-info">
                                            <h5 class="service-title">${servicio.nombre}</h5>
                                            <p class="service-price"><strong>Precio:</strong> $${servicio.precio}</p>
                                            <p class="service-author"><small>Autor: ${servicio.usuario.nombre}</small></p>
                                            <div>
                                                <c:choose>
                                                <c:when test="${empty usuarioSesion or usuarioSesion.id ne servicio.usuario.id}">
                                                    <a href="${pageContext.request.contextPath}/servicio/detalles/${servicio.id}"
                                                        class="btn-request-service">
                                                        <i class="fas fa-hand-paper"></i> Solicitar Servicio
                                                    </a>
                                                    <button class="btn-contact-seller" data-bs-toggle="modal"
                                                        data-bs-target="#contactModal"
                                                        onclick="openModal('${servicio.usuario.nombre}', '${servicio.nombre}')">
                                                        Contactar con el Vendedor
                                                    </button>
                                                </c:when>
                                                <c:otherwise>
                                                    <a href="${pageContext.request.contextPath}/servicio/detalles/${servicio.id}"
                                                        class="btn-view-service">
                                                        <i class="fas fa-eye"></i> Ver
                                                    </a>
                                                </c:otherwise>
                                            </c:choose>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:if>
                </c:forEach>
            </div>
        </main>

        <footer>
            <p>Pololitos &copy; 2025, Todos los derechos reservados</p>
            <ul class="nav-footer">
                <li><a href="/contacto">Contacto</a></li>
                <li><a href="/nosotros">Nosotros</a></li>
            </ul>
        </footer>

        <script>
            function filterByCategory() {
                var selectedCategory = document.getElementById("categoryFilter").value;
                var url = "/servicios";
                if (selectedCategory) {
                    url += "?categoriaId=" + selectedCategory;
                }
                window.location.href = url;
            }
        </script>
    </body>
    
    </html>