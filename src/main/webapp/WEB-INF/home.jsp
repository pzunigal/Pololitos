<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Pololitos</title>

    <!-- Fuentes personalizadas -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans:ital,wght@0,100..900;1,100..900&family=Quicksand:wght@300..700&family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&family=Winky+Sans:ital,wght@0,300..900;1,300..900&display=swap" rel="stylesheet">

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        body {
            font-family: 'Quicksand', 'Roboto', 'Noto Sans', 'Winky Sans', sans-serif;
            min-height: 100vh;
            background-image: url('https://c1.wallpaperflare.com/path/427/745/192/notebook-natural-laptop-macbook-497500668a927f46aa19fafb668d8702.jpg');
            background-size: cover;
            background-position: center;
            display: flex;
            flex-direction: column;
            color: white;
        }

        .card img {
            height: 200px;
            object-fit: cover;
        }

        .carousel-container {
            position: relative;
            overflow-x: hidden;
        }

        .cards-wrapper {
            display: flex;
            overflow-x: auto;
            scroll-behavior: smooth;
        }

        .cards {
            display: flex;
            gap: 1rem;
            padding: 1rem;
        }

        .card {
            min-width: 250px;
            background-color: #1e1e1e;
            color: white;
        }

        .carousel-btn {
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            z-index: 2;
            background-color: rgba(0, 0, 0, 0.6);
            border: none;
            color: white;
            font-size: 2rem;
            padding: 0 10px;
            cursor: pointer;
        }

        .carousel-btn.prev {
            left: 0;
        }

        .carousel-btn.next {
            right: 0;
        }
    </style>
</head>

<body class="d-flex flex-column">

    <!-- Navbar -->
    <%@ include file="/WEB-INF/componentes/nav.jsp" %>
    <!-- Hero -->
    <main class="container text-center my-5">
        <h1 class="mb-3">Publica un Pololo.<br>Genera Ingresos Con Trabajos Pequeños.</h1>
        <p class="lead mb-4">Conectamos a personas que buscan ayuda con servicios locales dispuestos a brindar soluciones</p>
        <a href="/servicios" class="btn btn-primary btn-lg px-4">Buscar Servicios</a>

        <!-- Sección Publicidad -->
        <div class="row justify-content-center my-5">
            <div class="col-md-10 bg-dark text-white rounded p-4 d-flex flex-wrap align-items-center">
                <img src="<c:url value='/img/work.jpg' />" alt="Publicidad" class="img-fluid rounded me-4" style="max-width: 250px;">
                <div>
                    <h2>¡Destaca tu Pololito y Gana Más!</h2>
                    <p>Haz que más clientes te encuentren y multiplica tus oportunidades de ingresos.</p>
                    <ul>
                        <li>Más visibilidad para tu servicio</li>
                        <li>Aumenta tus contrataciones</li>
                        <li>Invierte poco, gana más</li>
                    </ul>
                    <a href="/contacto" class="btn btn-warning">Solicitar Publicidad</a>
                </div>
            </div>
        </div>

        <!-- Carrusel Últimos Servicios -->
        <div class="section mb-5">
            <h2 class="text-center mb-4">Nuevos servicios que podrían interesarte</h2>
            <div class="carousel-container">
                <button class="carousel-btn prev" onclick="moverIzquierda()">&#10094;</button>
                <div class="cards-wrapper">
                    <div class="cards">
                        <c:forEach var="servicio" items="${ultimosServicios}">
                            <div class="card">
                                <img src="${servicio.imgUrl}" alt="${servicio.nombre}" class="card-img-top">
                                <div class="card-body d-flex flex-column">
                                    <h5 class="card-title">${servicio.nombre}</h5>
                                    <p class="card-text mb-1"><strong>$${servicio.precio}</strong></p>
                                    <p class="card-text">${servicio.ciudad}</p>
                                    <div class="mt-auto">
                                        <c:choose>
                                            <c:when test="${empty usuarioSesion or usuarioSesion.id ne servicio.usuario.id}">
                                                <a href="${pageContext.request.contextPath}/servicio/detalles/${servicio.id}" class="btn btn-primary btn-sm">Solicitar Servicio</a>
                                            </c:when>
                                            <c:otherwise>
                                                <a href="${pageContext.request.contextPath}/servicio/detalles/${servicio.id}" class="btn btn-outline-info btn-sm">Ver mi publicación</a>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
                <button class="carousel-btn next" onclick="moverDerecha()">&#10095;</button>
            </div>
        </div>
    </main>

    <!-- Footer -->
    <footer class="bg-dark text-white text-center py-3 mt-auto">
        <p class="mb-1">Pololitos &copy; 2025. Todos los derechos reservados</p>
        <ul class="nav justify-content-center">
            <li class="nav-item"><a class="nav-link text-white" href="/contacto">Contacto</a></li>
            <li class="nav-item"><a class="nav-link text-white" href="/nosotros">Nosotros</a></li>
        </ul>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function moverDerecha() {
            document.querySelector(".cards-wrapper").scrollBy({ left: 300, behavior: "smooth" });
        }

        function moverIzquierda() {
            document.querySelector(".cards-wrapper").scrollBy({ left: -300, behavior: "smooth" });
        }
    </script>
</body>
</html>
