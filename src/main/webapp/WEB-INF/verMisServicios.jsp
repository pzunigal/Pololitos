<%@ taglib uri="http://www.springframework.org/tags" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mis Servicios</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
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
                                <p class="card-text">${servicio.descripcion}</p>
                                <p><strong>Precio:</strong> $${servicio.precio}</p>
                                <p><strong>Ubicación:</strong> ${servicio.ciudad}</p>
                                <a href="${pageContext.request.contextPath}/editar-servicio/${servicio.id}" class="btn btn-warning">Editar</a>
                                <form action="${pageContext.request.contextPath}/eliminar-servicio/${servicio.id}" method="post" style="display:inline;">
                                    <button type="submit" class="btn btn-danger" onclick="return confirm('¿Estás seguro de que quieres eliminar este servicio?');">
                                        Eliminar
                                    </button>
                                </form>
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
