<%@ taglib uri="http://www.springframework.org/tags" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Detalles del Servicio</title>
    <!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"> -->
    <link rel="stylesheet" href="/css/global.css">
</head>
<body>
    <header>
        <div class="nav-container">
            <a href="/">
                <div class="logoPololitos">
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
                    <input type="text" name="query" id="busqueda-input" placeholder="Buscar servicios...">
                    <button type="submit" id="busqueda-btn">
                        <img src="/img/busqueda.png" alt="lupa de busqueda" id="busqueda-icon">
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
                    <a href="/logout"><button>Cerrar Sesion</button></a>
                </c:when>

                <c:otherwise>
                    <a href="/login"><button>Iniciar sesion</button></a>
                    <a href="/registro"><button>Registrate</button></a>
                </c:otherwise>
            </c:choose>
        </div>
    </header>
    <main>
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
                                <p><strong>Ubicacion:</strong> ${servicio.ciudad}</p>
                                <p><strong>Fecha de publicacion:</strong> ${servicio.createdAt}</p>
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
                                        <p><strong>Ubicacion:</strong> ${servicio.ciudad}</p>
                                        <p><strong>Fecha de publicacion:</strong> ${servicio.createdAt}</p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="card">
                                    <div class="card-body">
                                        <h5 class="card-title">Enviar Solicitud</h5>
                                        <form action="${pageContext.request.contextPath}/crear-solicitud" method="post">
                                            <div class="form-group">
                                                <textarea class="form-control" name="mensaje" placeholder="Escribe aqui un mensaje..." required></textarea>
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
        <!-- Sección de Reseñas -->
<section class="resenas-section mt-5">

    <!-- Promedio de calificaciones -->
    <c:if test="${not empty promedio}">
        <div class="card mb-4">
            <div class="card-body text-center">
                <h5>Promedio de calificaciones</h5>
                <div class="promedio-star">
                    <c:forEach begin="1" end="5" var="i">
                        <c:choose>
                            <c:when test="${i <= promedio}">
                                <span class="star filled">&#9733;</span>
                            </c:when>
                            <c:otherwise>
                                <span class="star">&#9733;</span>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                    <span class="promedio-num">
                        (<fmt:formatNumber value="${promedio}" maxFractionDigits="1"/> / 5)
                    </span>
                </div>
            </div>
        </div>
    </c:if>

    <!-- Formulario de reseña -->
    <c:if test="${not isAuthorInSesion}">
        <div class="card mb-4">
            <div class="card-body">
                <h5 class="mb-3">Deja tu reseña</h5>
                <form action="${pageContext.request.contextPath}/publicar-resena" method="post">
                    <input type="hidden" name="servicioId" value="${servicio.id}" />
                    
                    <div class="form-group star-rating mb-3">
                        <label class="form-label">Calificación:</label>
                        <div class="stars">
                            <input type="radio" id="star5" name="calificacion" value="5" required />
                            <label for="star5" class="star">&#9733;</label>
                            <input type="radio" id="star4" name="calificacion" value="4" />
                            <label for="star4" class="star">&#9733;</label>
                            <input type="radio" id="star3" name="calificacion" value="3" />
                            <label for="star3" class="star">&#9733;</label>
                            <input type="radio" id="star2" name="calificacion" value="2" />
                            <label for="star2" class="star">&#9733;</label>
                            <input type="radio" id="star1" name="calificacion" value="1" />
                            <label for="star1" class="star">&#9733;</label>
                        </div>
                    </div>

                    <div class="form-group mb-3">
                        <label for="comentario">Comentario:</label>
                        <textarea name="comentario" rows="3" class="form-control" placeholder="Escribe tu opinión..."></textarea>
                    </div>

                    <button type="submit" class="btn btn-success">Enviar reseña</button>
                </form>
            </div>
        </div>
    </c:if>

    <!-- Lista de reseñas -->
    <div class="card">
        <div class="card-body">
            <h5 class="mb-3">Calificaciones recientes</h5>
            <c:forEach var="resena" items="${resenas}">
                <div class="resena-item mb-3">
                    <p class="mb-1">
                        <strong>${resena.usuario.nombre}</strong>
                        <span class="estrellas-user">
                            <c:forEach begin="1" end="5" var="i">
                                <c:choose>
                                    <c:when test="${i <= resena.calificacion}">
                                        <span class="star filled">&#9733;</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="star">&#9733;</span>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                        </span>
                    </p>
                    <c:if test="${not empty resena.comentario}">
                        <p class="resena-comentario">${resena.comentario}</p>
                    </c:if>
                    <hr style="border-color: #777;">
                </div>
            </c:forEach>
        </div>
    </div>
</section>

    </main>
 
    <footer>
        <p>Pololitos &copy; 2025, Todos los derechos reservados</p>
            <ul class="nav-footer">
                <li><a href="/contacto">Contacto</a></li>
                <li><a href="/nosotros">Nosotros</a></li>
            </ul>
    </footer>
</body>
</html>
