<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Nosotros</title>
<link rel="stylesheet" href="/css/nosotros.css">
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
                <nav>
                    <ul class="nav-links">
                        <li><a href="/servicios">Servicios</a></li>
                        <!-- Agregar la opción Mis Servicios solo si el usuario está logueado -->
                        <c:choose>
                            <c:when test="${not empty sessionScope.usuarioEnSesion}">
                                <li><a href="/mis-servicios">Mis Servicios</a></li>
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
                        <img src="${sessionScope.usuarioEnSesion.fotoPerfil}" alt="Foto de perfil" width="40" height="40" style="border-radius: 50%;">
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
        <div class="container-nosotros">
            <div class="content-nosotros">
                <h1>¿Quienes somos?</h1>
                <p>Somos una empresa que busca conectar a personas que necesitan ayuda con tareas y las conectamos con profesionales que pueden ayudarles. Nuestro objetivo es facilitar la vida de las personas y ayudar a que puedan realizar sus tareas de manera más eficiente.</p>
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
</body>
</html>