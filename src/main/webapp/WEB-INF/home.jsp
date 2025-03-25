<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Pololitos</title>
    <!-- CSS -->
    <link rel="stylesheet" href="/css/home.css">
</head>
    <body>
        <header>
            <div class="nav-container">
                <a href="/">
                    <div class="logo">
                        <img src="img/pololitosBlanco.png" alt="Logo pololitos">
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

        <main>
            <div class="container">
                <div class="content">
                    <h1>Publica un Pololo. <br>Genera Ingresos Con Trabajos Pequeños.</h1>
                    <p>Conectamos a personas que buscan ayuda con servicios locales dispuestos a brindar soluciones</p>
                    <a href="/servicios"><button>Buscar Servicios</button></a>
                </div>
                <div class="empleo-destacado-container">
                    <div class="empleo-destacado">
                        <div class="empleo-destacado-info">
                            <img src="img/work.jpg" alt="Empleo Destacado">
                            <div class="empleo-destacado-text">
                                <h2>¡Destaca tu Pololito y Gana Más!</h2>
                                <p>Haz que más clientes te encuentren y multiplica tus oportunidades de ingresos.</p>
                                <ul>
                                    <li>Más visibilidad para tu servicio</li>
                                    <li>Aumenta tus contrataciones</li>
                                    <li>Invierte poco, gana más</li>
                                </ul>
                                <a href="/contacto"><button class="btn-publicidad">Solicitar Publicidad</button></a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="section" id="empleosRecomendados">
                <h2 class="section-title">Nuevos servicios que podrían interesarte</h2>
                <div class="carousel-container">
                    <button class="carousel-btn prev" onclick="moverIzquierda()">&#10094;</button>
                    <div class="cards-wrapper">
                        <div class="cards">
                            <c:forEach var="servicio" items="${ultimosServicios}">
                                <div class="card">
                                    <h2>${servicio.nombre}</h2>
                                    <a href="${pageContext.request.contextPath}/servicio/detalles/${servicio.id}" class="service-link">
                                        <img src="${servicio.imgUrl}" class="card-img-top img-card-profile-service" alt="${servicio.nombre}">
                                        <p>$${servicio.precio}</p>
                                        <p>${servicio.ciudad}</p>
                                    </a>                                    
                                    <c:choose>
                                        <c:when test="${empty usuarioSesion or usuarioSesion.id ne servicio.usuario.id}">
                                            <a href="${pageContext.request.contextPath}/servicio/detalles/${servicio.id}" class="btn btn-primary">
                                                <p class="button-solicitar-servicio">Solicitar Servicio</p> 
                                            </a>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="btn-container">
                                                <a href="${pageContext.request.contextPath}/servicio/detalles/${servicio.id}" class="btn btn-yellow">
                                                    Ver mi publicación
                                                </a>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                    <button class="carousel-btn next" onclick="moverDerecha()">&#10095;</button>
                </div>
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
            document.addEventListener("DOMContentLoaded", function () {
                const categorias = document.querySelectorAll(".categoria");
                let visibles = 0;

                categorias.forEach(categoria => {
                    const count = parseInt(categoria.getAttribute("data-count"), 10);
                    if (count === 0 || visibles >= 1) {
                        categoria.style.display = "none"; // Oculta si no tiene servicios o ya hay 2 visibles
                    } else {
                        visibles++;
                    }
                });
            });

            function moverDerecha() {
            document.querySelector(".cards-wrapper").scrollBy({ left: 300, behavior: "smooth" });
            }

            function moverIzquierda() {
            document.querySelector(".cards-wrapper").scrollBy({ left: -300, behavior: "smooth" });
            }
        </script>
    </body>
</html>