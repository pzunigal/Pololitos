<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Editar Usuario</title>
<link rel="stylesheet" href="/css/dashboard.css">

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
            <div class="circle-busqueda">
                <input type="text" placeholder="¿Qué servicio buscas?">
                <a href=""><img src="img/busqueda.png" alt="lupa de busqueda"></a>
            </div>

            <c:choose>
                <c:when test="${not empty sessionScope.usuarioEnSesion}">
                    <a href="/perfilUsuario">
                        <img src="${sessionScope.usuarioEnSesion.fotoPerfil}" alt="Foto de perfil"
                            width="40" height="40" style="border-radius: 50%;">
                    </a>
                    <a href="/servicios/publicar"><button>Crear Servicio</button></a>
                    <a href="/logout"><button>Cerrar Sesión</button></a>
                </c:when>


            </c:choose>
        </div>
    </header>
    <main>
        <div class="profile-card">
            <h1 class="name">Editar Perfil</h1>
            <form action="/actualizarPerfil" method="post">
                <label for="name">Nombre:</label>
                <input type="text" id="name" name="name" class="input-field" placeholder="Ingresa tu nombre" required>

                <label for="name">Apellido:</label>
                <input type="text" id="name" name="name" class="input-field" placeholder="Ingresa tu apellido" required>
                
                <label for="city">Ciudad:</label>
                <input type="text" id="city" name="city" class="input-field" placeholder="Ingresa tu ciudad" required>
                
                <label for="phone">Teléfono:</label>
                <input type="tel" id="phone" name="phone" class="input-field" placeholder="Ingresa tu numero de telefono: Ej.+(56)9 1414 2424" required>
                
                <label for="profile">Perfil:</label>
                <input type="url" id="profile" name="profile" class="input-field" placeholder="Ingresa la url de una imagen para tu perfil" required>
                
                <label for="password">Contraseña:</label>
                <input type="password" id="password" name="password" class="input-field" placeholder="Ingresa tu nueva contraseña" required>

                <label for="password">Confirmar Contraseña:</label>
                <input type="password" id="password" name="password" class="input-field" placeholder="Confirma tu nueva contraseña" required>
                
                <button type="submit" class="edit-button">Guardar Cambios</button>
            </form>
        </div>
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