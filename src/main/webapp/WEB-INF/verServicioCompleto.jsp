<%@ taglib uri="http://www.springframework.org/tags" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Detalles del Servicio</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

    <div class="container">
        <h1 class="text-center my-4">Detalles del Servicio</h1>

        <c:if test="${not empty servicio}">
            <c:choose>
                <c:when test="${isAuthorInSesion}">
                    <!-- Si el usuario es el mismo que el autor -->
                    <div class="card">
                        <img src="${servicio.imgUrl}" class="card-img-top" alt="${servicio.nombre}">
                        <div class="card-body">
                            <h5 class="card-title text-primary">${servicio.nombre}</h5>
                            <p class="card-text">${servicio.descripcion}</p>
                            <p><strong>Precio:</strong> $${servicio.precio}</p>
                            <p><strong>Ubicación:</strong> ${servicio.ciudad}</p>
                            <p><strong>Fecha de publicación:</strong> ${servicio.createdAt}</p>
                            <a href="javascript:history.back()" class="btn btn-secondary">Volver</a>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <!-- Si el usuario no es el mismo que el autor -->
                    <div class="row">
                        <div class="col-md-6">
                            <div class="card">
                                <img src="${servicio.imgUrl}" class="card-img-top" alt="${servicio.nombre}">
                                <div class="card-body">
                                    <h5 class="card-title text-primary">${servicio.nombre}</h5>
                                    <p class="card-text">${servicio.descripcion}</p>
                                    <p><strong>Precio:</strong> $${servicio.precio}</p>
                                    <p><strong>Ubicación:</strong> ${servicio.ciudad}</p>
                                    <p><strong>Fecha de publicación:</strong> ${servicio.createdAt}</p>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="card">
                                <div class="card-body">
                                    <h5 class="card-title">Enviar Solicitud</h5>
                                    <form action="${pageContext.request.contextPath}/crear-solicitud" method="post">
                                        <div class="form-group">
                                            <textarea class="form-control" name="mensaje" placeholder="Escribe aquí un mensaje..." required></textarea>
                                        </div>
                                        <input type="hidden" name="servicioId" value="<c:out value='${servicio.id}'/>" />
                                        <button type="submit" class="btn btn-primary mt-3">Enviar Solicitud</button>
                                    </form>
                                    
                                    
                                </div>
                            </div>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </c:if>
    </div>

</body>
</html>
