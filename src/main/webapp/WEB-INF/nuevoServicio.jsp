<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Publicar Servicio</title>
    <link rel="stylesheet" href="/css/servicios.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
</head>
<body>

<header>
    <div class="nav-container">
        <a href="/">
            <div class="logo">
                <img src="/img/pololitosBlanco.png" alt="Logo pololitos">
            </div>
        </a>
        <nav>
            <ul class="nav-links">
                <li><a href="/servicios">Servicios</a></li>
                <c:if test="${not empty sessionScope.usuarioEnSesion}">
                    <li><a href="/mis-servicios">Mis Servicios</a></li>
                    <li><a href="/mis-solicitudes-enviadas">Enviadas</a></li>
                    <li><a href="/mis-solicitudes-recibidas">Recibidas</a></li>
                </c:if>
            </ul>
        </nav>
    </div>
    <div class="user-info">
        <div class="circle-busqueda">
            <input type="text" placeholder="¿Qué servicio buscas?">
            <a href=""><img src="/img/busqueda.png" alt="lupa de búsqueda"></a>
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

<main class="servicio-form-container">
    <h2>Publicar un nuevo servicio</h2>

    <c:if test="${not empty error}">
        <div class="alerta-error">${error}</div>
    </c:if>

    <div class="servicio-card">
        <div class="form-header">
            <h3><i class="fas fa-plus-circle"></i> Publicar Servicio</h3>
        </div>

        <form:form modelAttribute="servicio" action="/publicar" method="POST" class="form-servicio">

            <div class="form-grupo">
                <label for="nombre">Nombre del Servicio:</label>
                <form:input path="nombre" class="input-servicio" />
                <form:errors path="nombre" cssClass="error-texto" />
            </div>

            <div class="form-grupo">
                <label for="descripcion">Descripción:</label>
                <form:textarea path="descripcion" class="input-servicio" rows="4" />
                <form:errors path="descripcion" cssClass="error-texto" />
            </div>

            <div class="form-grupo">
                <label for="precio">Precio:</label>
                <form:input path="precio" type="number" step="0.01" class="input-servicio" />
                <form:errors path="precio" cssClass="error-texto" />
            </div>

            <div class="form-grupo">
                <label for="ciudad">Ciudad:</label>
                <form:input path="ciudad" class="input-servicio" />
                <form:errors path="ciudad" cssClass="error-texto" />
            </div>

            <div class="form-grupo">
                <label for="imgUrl">URL de la Foto del Servicio:</label>
                <form:input path="imgUrl" class="input-servicio" />
                <form:errors path="imgUrl" cssClass="error-texto" />
            </div>

            <div class="form-grupo">
                <label for="categoria">Categoría:</label>
                <form:select path="categoria.id" class="input-servicio">
                    <form:option value="" label="Seleccione una categoría" />
                    <c:forEach var="categoria" items="${categorias}">
                        <form:option value="${categoria.id}" label="${categoria.nombre}" />
                    </c:forEach>
                </form:select>
                <form:errors path="categoria" cssClass="error-texto" />
            </div>

            <div class="form-boton">
                <button type="submit" class="btn-publicar">
                    <i class="fas fa-upload"></i> Publicar Servicio
                </button>
            </div>

        </form:form>
    </div>
</main>

</body>
</html>
