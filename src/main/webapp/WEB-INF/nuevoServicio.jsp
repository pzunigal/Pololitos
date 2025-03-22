<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Publicar Servicio</title>
    <link rel="stylesheet" href="/css/nuevoServicio.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <style>
        .preview-container {
            margin-top: 10px;
        }

        .preview-image {
            max-width: 300px;
            max-height: 300px;
            display: none;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.2);
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
                    <c:if test="${not empty sessionScope.usuarioEnSesion}">
                        <li><a href="/mis-servicios">Mis Servicios</a></li>
                        <li><a href="/mis-solicitudes-enviadas">Enviadas</a></li>
                        <li><a href="/mis-solicitudes-recibidas">Recibidas</a></li>
                    </c:if>
                </ul>
            </nav>
        </div>
        <div class="user-info">
            <form action="/buscar-servicios" method="get">
                <div class="circle-busqueda" id="busqueda-container">
                    <input type="text" name="query" id="busqueda-input" placeholder="¿Qué servicio buscas?">
                    <button type="submit" id="busqueda-btn">
                        <img src="${pageContext.request.contextPath}/img/busqueda.png" alt="Buscar" id="busqueda-icon">
                    </button>
                </div>
            </form>
            <c:choose>
                <c:when test="${not empty sessionScope.usuarioEnSesion}">
                    <a href="/perfilUsuario">
                        <img src="${sessionScope.usuarioEnSesion.fotoPerfil}" alt="Perfil" width="40" height="40" style="border-radius: 50%;">
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
        <div class="form-container">
            <h1>Publicar nuevo servicio</h1>

            <c:if test="${not empty error}">
                <div class="alert alert-danger" role="alert">
                    ${error}
                </div>
            </c:if>

            <form:form modelAttribute="servicio" action="/publicar" method="POST" enctype="multipart/form-data">
                <div class="mb-3">
                    <label for="nombre" class="form-label">Nombre del Servicio:</label>
                    <form:input path="nombre" class="form-control" required="true"/>
                    <form:errors path="nombre" class="text-danger"/>
                </div>

                <div class="mb-3">
                    <label for="descripcion" class="form-label">Descripción:</label>
                    <form:textarea path="descripcion" class="form-control" rows="4" required="true"/>
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
                    <label for="file" class="form-label">Foto del Servicio:</label>
                    <input type="file" name="file" id="fileInput" class="form-control" accept="image/*" required />
                    <div class="preview-container">
                        <img id="previewImage" class="preview-image" alt="Vista previa de imagen" />
                    </div>
                </div>

                <div class="mb-3">
                    <label for="categoria" class="form-label">Categoría:</label>
                    <form:select path="categoria.id" class="form-control" required="true">
                        <form:option value="" label="Seleccione una categoría"/>
                        <c:forEach var="categoria" items="${categorias}">
                            <form:option value="${categoria.id}" label="${categoria.nombre}"/>
                        </c:forEach>
                    </form:select>
                    <form:errors path="categoria" class="text-danger"/>
                </div>

                <div class="d-grid">
                    <button type="submit" class="btn btn-success">
                        <i class="fas fa-upload"></i> Publicar Servicio
                    </button>
                </div>
            </form:form>
        </div>
    </main>

    <footer>
        <p>Pololitos &copy; 2025. Todos los derechos reservados</p>
        <ul class="nav-footer">
            <li><a href="/contacto">Contacto</a></li>
            <li><a href="/nosotros">Nosotros</a></li>
        </ul>
    </footer>

    <script>
        const fileInput = document.getElementById("fileInput");
        const previewImage = document.getElementById("previewImage");

        fileInput.addEventListener("change", function () {
            const file = this.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function (e) {
                    previewImage.src = e.target.result;
                    previewImage.style.display = "block";
                }
                reader.readAsDataURL(file);
            } else {
                previewImage.style.display = "none";
                previewImage.src = "";
            }
        });
    </script>
</body>
</html>
