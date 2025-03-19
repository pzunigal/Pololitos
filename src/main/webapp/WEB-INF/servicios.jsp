<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Servicios</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h1>Servicios por Categoría</h1>
        
        <!-- Iterar sobre las categorías -->
        <c:forEach var="categoria" items="${categorias}">
            <h2 class="mt-4">${categoria.nombre}</h2>
            
            <!-- Verificar si la categoría tiene servicios -->
            <c:if test="${empty categoria.servicios}">
                <p>No hay servicios disponibles en esta categoría.</p>
            </c:if>
            
            <div class="row">
                <!-- Iterar sobre los servicios de cada categoría -->
                <c:forEach var="servicio" items="${categoria.servicios}">
                    <div class="col-md-4 mb-4">
                        <div class="card">
                            <img src="${servicio.imgUrl}" class="card-img-top" alt="${servicio.nombre}">
                            <div class="card-body">
                                <h5 class="card-title">${servicio.nombre}</h5>
                                <p class="card-text">${servicio.descripcion}</p>
                                <p class="card-text"><strong>Precio:</strong> $${servicio.precio}</p>
                                <p class="card-text"><small class="text-muted">Autor: ${servicio.usuario.nombre}</small></p>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:forEach>
        
    </div>
</body>
</html>
