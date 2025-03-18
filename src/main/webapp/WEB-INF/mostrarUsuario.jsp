<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Mostrar Usuario</title>
<link rel="stylesheet" href="/css/dashboard.css">
</head>
<body>
	<header>
        <div class="nav-container">
            <a href="/"><div class="logo">
                    <img src="img/pololitosBlanco.png" alt="Logo pololitos"></div></a>
            <nav>
                <ul class="nav-links">
                    <li><a href="/servicios">Servicios</a></li>
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
                    <a href="/perfilUsuario">
                        <img src="${sessionScope.usuarioEnSesion.fotoPerfil}" alt="Foto de perfil" class="profile-image">
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
        <div class="profile-card">
            <img src="${usuario.fotoPerfil}" alt="Foto de perfil">
            <h1 class="name">${usuario.nombre} ${usuario.apellido}</h1>
            <p class="city">${usuario.ciudad}</p>
            <p class="contact-info">
                Teléfono: <a href="tel:${usuario.telefono}" class="link">${usuario.telefono}</a>
            </p>
            <p class="contact-info">
                Correo: <a href="mailto:${usuario.email}" class="link">${usuario.email}</a>
            </p>
            <a href="/editarPerfil" class="edit-button">Editar Perfil</a>
        </div>
        <!-- Añadir la lista de servicios que ofrece visible para el propio usuario y otros,
        Añadir la lista de servicios que ha solicitado visible solo para el propio usuario-->
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