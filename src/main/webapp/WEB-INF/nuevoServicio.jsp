<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Publicar Servicio</title>
    <link rel="stylesheet" href="/css/navbar.css">
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
                            

                            <form:form modelAttribute="servicio" action="/publicar" method="POST" class="needs-validation">
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
                                    <label for="imgUrl" class="form-label">URL de la Foto del Servicio:</label>
                                    <form:input path="imgUrl" type="text" class="form-control" placeholder="Ingrese la URL de la imagen" required="true"/>
                                    <form:errors path="imgUrl" class="text-danger"/>
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
