<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Pololitos</title>
<!-- CSS -->
<link rel="stylesheet" href="/css/home.css">
<!-- BOOTSTRAP -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- FONT AWESOME (iconos) -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
</head>
<body>
	<header>
        <div class="nav-container">
            <div class="logo">
                <img src="img/pololitosBlanco.png" alt="Logo pololitos">
            </div>
            <nav>
                <ul class="nav-links">
                    <li><a href="/">Inicio</a></li>
                    <li><a href="#">Mi Perfil</a></li>
                    <li><a href="/contacto">Contacto</a></li>
                    <li><a href="/nosotros">Nosotros</a></li>
                </ul>
            </nav>
        </div>
        <div class="user-info">
            <div class="circle-busqueda">
                <input type="text" placeholder="¿Qué servicio buscas?">
                <a href=""><img src="img/busqueda.png" alt="lupa de busqueda"></a>
            </div>
            
            <c:choose>
                <c:when test="${not empty sessionScope.usuarioEnSesion}">
                    <span>Bienvenido, ${sessionScope.usuarioEnSesion.nombre} ${sessionScope.usuarioEnSesion.apellido}</span>
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
                <h1>Publica un Pololo. <br>Alguien lo hará por ti.</h1>
                <p>Conectamos a personas que buscan ayuda con expertos dispuestos a brindar soluciones</p>
                <button>SOLICITAR ANUNCIO</button>
            </div>
        </div>

        <div class="section">
            <h2>Empleos Recomendados</h2>
            <div class="cards">
                <div class="card">
                    <img src="img/trabajo.jpg" alt="">
                    <h2>Fontanero</h2>
                    <p>Ciudad: </p>
                </div>
                <div class="card">
                    <img src="img/trabajo.jpg" alt="">
                    <h2>Fontanero</h2>
                    <p>Ciudad: </p>
                </div>
            </div>
        </div>
    </main>

    <footer>
        <p>Pololitos &copy; 2025, Todos los derechos reservados</p>
    </footer>
</body>
</html>
