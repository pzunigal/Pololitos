<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Publicar Servicio</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-4">
        <h2>Publicar un Nuevo Servicio</h2>
        
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>

        <form:form modelAttribute="servicio" action="/servicios/publicar" method="post" class="mt-3">
            <div class="mb-3">
                <label for="nombre" class="form-label">Nombre del Servicio:</label>
                <form:input path="nombre" class="form-control" required="true"/>
                <form:errors path="nombre" class="text-danger"/>
            </div>
            
            <div class="mb-3">
                <label for="descripcion" class="form-label">Descripción:</label>
                <form:textarea path="descripcion" class="form-control" required="true"/>
                <form:errors path="descripcion" class="text-danger"/>
            </div>
            
            <div class="mb-3">
                <label for="precio" class="form-label">Precio:</label>
                <form:input path="precio" type="number" step="0.01" class="form-control" required="true"/>
                <form:errors path="precio" class="text-danger"/>
            </div>
            
            <div class="mb-3">
                <label for="ciudad" class="form-label">Ciudad:</label>
                <form:input path="ciudad" class="form-control"/>
                <form:errors path="ciudad" class="text-danger"/>
            </div>

            <div class="mb-3">
                <label for="fotoServicio" class="form-label">Foto del servicio:</label>
                <form:input path="fotoServicio" class="form-control"/>
                <form:errors path="fotoServicio" class="text-danger"/>
            </div>
            
            <div class="mb-3">
                <label for="categoria" class="form-label">Categoría:</label>
                <form:select path="categoria.id" class="form-control" required="true">
                    <form:option value="" label="Seleccione una categoría"/>
                    <c:forEach var="categoria" items="${categorias}">
                        <form:option value="${categoria.id}" label="${categoria.nombre}"/>
                    </c:forEach>
                </form:select>
                <!-- Definir lista de categorias -->
                <form:errors path="categoria" class="text-danger"/>
            </div>
            
            <button type="submit" class="btn btn-primary">Publicar Servicio</button>
        </form:form>
    </div>
</body>
</html>
