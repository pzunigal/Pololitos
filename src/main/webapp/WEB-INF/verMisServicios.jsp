<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mis Servicios</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Agregar Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="/css/home.css">
    <style>
        /* Custom Styles */
        body {
            font-family: Arial, sans-serif;
        }

        h1 {
            margin-bottom: 20px;
            text-align: center;
            color: #333;
        }

        .alert {
            margin-top: 20px;
        }

        .card {
            margin-bottom: 20px;
        }

        .card-img-top {
            object-fit: cover;
            height: 200px; /* Forcing a vertical image */
        }

        .footer-nav {
            list-style-type: none;
            padding-left: 0;
            text-align: center;
        }

        .footer-nav li {
            display: inline;
            margin: 0 10px;
        }

        .footer-nav li a {
            text-decoration: none;
            color: #007bff;
        }

        .footer-nav li a:hover {
            text-decoration: underline;
        }

        .container {
            padding: 20px;
        }
    </style>
</head>
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
<body>

    <div class="container">
        <h1>Mis Servicios</h1>

        <c:if test="${not empty error}">
            <div class="alert alert-danger">Hubo un error al intentar eliminar el servicio.</div>
        </c:if>

        <c:if test="${not empty servicios}">
            <div class="row">
                <c:forEach var="servicio" items="${servicios}">
                    <div class="col-md-4">
                        <div class="card">
                            <img src="${servicio.imgUrl}" class="card-img-top" alt="${servicio.nombre}">
                            <div class="card-body">
                                <h5 class="card-title">${servicio.nombre}</h5>
                                <p><strong>Precio:</strong> $${servicio.precio}</p>
                                <p><strong>Ubicación:</strong> ${servicio.ciudad}</p>
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
        </c:if>

        <c:if test="${empty servicios}">
            <p>No tienes servicios publicados.</p>
        </c:if>

        <a href="${pageContext.request.contextPath}/servicios/publicar" class="btn btn-primary">Publicar un nuevo servicio</a>
    </div>

    <footer>
        <div class="container">
            <ul class="footer-nav">
                <li><a href="/contacto">Contacto</a></li>
                <li><a href="/nosotros">Nosotros</a></li>
            </ul>
        </div>
    </footer>

</body>
</html>
