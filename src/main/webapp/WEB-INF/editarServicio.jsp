<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Editar Servicio</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
</head>
<body>

<header class="bg-dark text-white">
    <div class="container d-flex justify-content-between align-items-center py-3">
        <a href="/" class="d-flex align-items-center">
            <img src="${pageContext.request.contextPath}/img/pololitosBlanco.png" alt="Logo pololitos" style="height: 40px;">
        </a>
        <nav>
            <ul class="nav">
                <li class="nav-item"><a href="/mis-servicios" class="nav-link text-white">Mis Servicios</a></li>
            </ul>
        </nav>
    </div>
</header>

<main>
    <div class="container mt-5">
        <h1>Editar Servicio</h1>
        <form action="/actualizar-servicio/${servicio.id}" method="post">
            <input type="hidden" name="_method" value="PATCH"> <!-- Emula PATCH en JSP -->
        
            <div class="mb-3">
                <label for="nombre" class="form-label">Nombre</label>
                <input type="text" class="form-control" id="nombre" name="nombre" value="${servicio.nombre}" required>
            </div>
        
            <div class="mb-3">
                <label for="descripcion" class="form-label">Descripción</label>
                <textarea class="form-control" id="descripcion" name="descripcion" required>${servicio.descripcion}</textarea>
            </div>
        
            <div class="mb-3">
                <label for="precio" class="form-label">Precio</label>
                <input type="number" class="form-control" id="precio" name="precio" value="${servicio.precio}" required>
            </div>
        
            <div class="mb-3">
                <label for="ciudad" class="form-label">Ciudad</label>
                <input type="text" class="form-control" id="ciudad" name="ciudad" value="${servicio.ciudad}" required>
            </div>
        
            <div class="mb-3">
                <label for="fechaPublicacion" class="form-label">Fecha de Publicación</label>
                <input type="text" class="form-control" id="fechaPublicacion" name="fechaPublicacion" value="${servicio.fechaPublicacion}" disabled>
            </div>
        
            <div class="mb-3">
                <label for="categoria" class="form-label">Categoría</label>
                <select class="form-select" id="categoria" name="categoria" required>
                    <c:forEach var="categoria" items="${categorias}">
                        <option value="${categoria.id}" ${categoria.id == servicio.categoria.id ? 'selected' : ''}>
                            ${categoria.nombre}
                        </option>
                    </c:forEach>
                </select>
            </div>
        
            <div class="mb-3">
                <label for="imgUrl" class="form-label">URL de la imagen</label>
                <input type="text" class="form-control" id="imgUrl" name="imgUrl" value="${servicio.imgUrl}" required>
            </div>
        
            <div class="d-flex gap-3">
                <button type="submit" class="btn btn-primary">Actualizar Servicio</button>
                <a href="/mis-servicios" class="btn btn-secondary">Volver</a>
            </div>
        </form>
        
    </div>
</main>

<footer>
    <div class="container">
        <p class="text-center">Pololitos &copy; 2025, Todos los derechos reservados</p>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"></script>
</body>
</html>
