<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Mostrar Usuario</title>
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
                    <li><a href="#">Servicios</a></li>
                    <li><a href="/contacto">Contacto</a></li>
                    <li><a href="/nosotros">Nosotros</a></li>
                </ul>
            </nav>
        </div>
        <div class="user-info">
            <a href=""><img src="img/busqueda.png" alt=""></a>
            <a href=""><img src="img/user.png" alt="Usuario"></a>
            <button>Cerrar Sesión</button>
        </div>
    </header>
    <main>
        <div class="profile-card">
            <h1 class="name">Nombre Apellido</h1>
            <p class="city">Ciudad</p>
            <p class="contact-info">
                Teléfono: <a href="tel:+123456789" class="link">+123456789</a>
            </p>
            <p class="contact-info">
                Perfil: <a href="https://www.ejemplo.com" class="link" target="_blank">ejemplo.com</a>
            </p>
            <p class="contact-info">
                Correo: <a href="mailto:correo@ejemplo.com" class="link">correo@ejemplo.com</a>
            </p>
            <button class="edit-button">Editar Perfil</button>
        </div>
        
    </main>
    <footer>
        <p>Pololitos &copy; 2025, Todos los derechos reservados</p>
    </footer>
</body>
</html>