<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Mostrar Usuario</title>
<link rel="stylesheet" href="/css/mostrarUsuario.css">
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
            <div class="circle-busqueda">
                <input type="text" placeholder="¿Qué servicio buscas?">
                <a href=""><img src="img/busqueda.png" alt="lupa de busqueda"></a>
            </div>

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
        <div class="main-container">
            <!-- Tarjeta de perfil -->
            <div class="profile-card">
                <img src="${usuario.fotoPerfil}" alt="Foto de perfil">
                <div class="container-info">
                    <h1 class="name">${usuario.nombre} ${usuario.apellido}</h1>
                    <p class="city">Ciudad: ${usuario.ciudad}</p>
                    <p class="contact-info">
                        Teléfono: <a href="tel:${usuario.telefono}" class="link">${usuario.telefono}</a>
                    </p>
                    <p class="contact-info">
                        Correo: <a href="mailto:${usuario.email}" class="link">${usuario.email}</a>
                    </p>
                    <a href="/editarPerfil" class="edit-button">Editar Perfil</a>
                </div>
            </div>

    
            <!-- Carrusel de servicios -->
            <div class="carousel-container">
                <h2>Servicios ofrecidos</h2>
                <div class="carousel-wrapper">
                    <button class="carousel-btn prev" onclick="moveCarousel(-1)">&#10094;</button>
                    <div class="carousel">
                        <c:forEach var="servicio" items="${servicios}">
                            <div class="service-card">
                                <img src="${servicio.imgUrl}" class="service-image" alt="${servicio.nombre}">
                                <div class="service-info">
                                    <h3>${servicio.nombre}</h3>
                                    <p><strong>Precio:</strong> $${servicio.precio}</p>
                                    <p><strong>Ubicación:</strong> ${servicio.ciudad}</p>
                                    <div class="service-actions">
                                        <form action="${pageContext.request.contextPath}/eliminar-servicio/${servicio.id}" method="post">
                                            <button type="submit" class="btn btn-danger" onclick="return confirm('¿Estás seguro de que quieres eliminar este servicio?');">
                                                <i class="bi bi-trash"></i>
                                            </button>
                                        </form>
                                    <div class="btn-container">
                                            <!-- Botón de editar con icono de lápiz -->
                                        <form action="${pageContext.request.contextPath}/eliminar-servicio/${servicio.id}" method="post" style="display:inline;">
                                            <button type="submit" class="btn btn-danger" onclick="return confirm('¿Estás seguro de que quieres eliminar este servicio?');">
                                                <i class="bi bi-trash"></i>
                                            </button>
                                        </form>
                                        <!-- Botón de ojo para ver detalles con icono de ojo -->
                                        <a href="${pageContext.request.contextPath}/servicio/detalles/${servicio.id}" class="btn btn-info">
                                            <i class="bi bi-eye"></i>
                                        </a>
                                        <a href="${pageContext.request.contextPath}/editar-servicio/${servicio.id}" class="btn btn-info">
                                            <i class="bi bi-pencil"></i>
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                    <button class="carousel-btn next" onclick="moveCarousel(1)">&#10095;</button>
                </div>
            </div>

        </div>
    </main>    
    <footer>
        <p>Pololitos &copy; 2025. Todos los derechos reservados</p> 
        <ul class="nav-footer">
            <li><a href="/contacto">Contacto</a></li>
            <li><a href="/nosotros">Nosotros</a></li>
        </ul>
    </footer>
</body>
</html>