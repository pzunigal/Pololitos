<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Publicar Servicio</title>
    
    <!-- Bootstrap 5 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <!-- FontAwesome para iconos -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <!-- SweetAlert2 para alertas -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <style>
        body {
            background-color: #f8f9fa;
        }
        .card {
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>
<body>
    <div class="container mt-4">
        <h2>Publicar un nuevo servicio</h2>
        
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>

        <div class="container mt-5">
            <div class="row justify-content-center">
                <div class="col-md-8">
                    <div class="card">
                        <div class="card-header bg-primary text-white text-center">
                            <h3><i class="fas fa-plus-circle"></i> Publicar un Nuevo Servicio</h3>
                        </div>
                        <div class="card-body">
                            

                            <form:form modelAttribute="servicio" action="/publicar" method="POST" class="needs-validation" enctype="multipart/form-data"> 
                                <div class="mb-3">
                                    <label for="nombre" class="form-label">Nombre del Servicio:</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-briefcase"></i></span>
                                        <form:input path="nombre" class="form-control" required="true"/>
                                    </div>
                                    <form:errors path="nombre" class="text-danger"/>
                                </div>

                                <div class="mb-3">
                                    <label for="descripcion" class="form-label">Descripción:</label>
                                    <form:textarea path="descripcion" class="form-control" rows="4" required="true"/>
                                    <form:errors path="descripcion" class="text-danger"/>
                                </div>

                                <div class="mb-3">
                                    <label for="precio" class="form-label">Precio:</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-dollar-sign"></i></span>
                                        <form:input path="precio" type="number" step="0.01" class="form-control" required="true"/>
                                    </div>
                                    <form:errors path="precio" class="text-danger"/>
                                </div>

                                <div class="mb-3">
                                    <label for="ciudad" class="form-label">Ciudad:</label>
                                    <form:input path="ciudad" class="form-control"/>
                                    <form:errors path="ciudad" class="text-danger"/>
                                </div>

                                <div class="mb-3">
                                    <label for="imageUrl" class="form-label">Foto del Servicio:</label>
                                    <form:input path="imgUrl" type="file" class="form-control" accept="image/*" />
                                    <form:errors path="imgUrl" class="text-danger"/>
                                    <img id="preview" class="mt-3 img-thumbnail" style="display:none; max-width: 200px;">
                                </div>

                                <div class="mb-3">
                                    <label for="categoria" class="form-label">Categoría:</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-list-alt"></i></span>
                                        <form:select path="categoria.id" class="form-control" required="true">
                                            <form:option value="" label="Seleccione una categoría"/>
                                            <c:forEach var="categoria" items="${categorias}">
                                                <form:option value="${categoria.id}" label="${categoria.nombre}"/>
                                            </c:forEach>
                                        </form:select>
                                    </div>
                                    <form:errors path="categoria" class="text-danger"/>
                                </div>

                                <div class="d-grid">
                                    <button type="submit" class="btn btn-success">
                                        <i class="fas fa-upload"></i> Publicar Servicio
                                    </button>
                                </div>
                            </form:form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap Bundle (JS incluido) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
