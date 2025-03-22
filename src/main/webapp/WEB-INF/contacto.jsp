<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Contacto</title>
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
        <section class="contacto">
            <h1>Contáctanos - Pololitos</h1>
            <p>En <strong>Pololitos</strong>, conectamos a personas que necesitan ayuda con sus tareas con profesionales que pueden hacer su vida más fácil y eficiente. ¡Estamos aquí para ayudarte! Completa el formulario o usa nuestros datos de contacto.</p>
            
            <div class="contacto-contenido">
                <form action="#" method="POST">
                    <label for="nombre">Nombre:</label>
                    <input type="text" id="nombre" name="nombre" placeholder="Tu nombre" required>
                    
                    <label for="email">Correo electrónico:</label>
                    <input type="email" id="email" name="email" placeholder="tuemail@ejemplo.com" required>
                    
                    <label for="telefono">Teléfono (opcional):</label>
                    <input type="tel" id="telefono" name="telefono" placeholder="123-456-7890">
                    
                    <label for="mensaje">¿En qué te podemos ayudar?</label>
                    <textarea id="mensaje" name="mensaje" rows="5" placeholder="Describe tu necesidad o tarea..." required></textarea>
                    
                    <button type="submit">Enviar mensaje</button>
                </form>
                
                <div class="info-contacto">
                    <h2>Otras formas de contactarnos</h2>
                    <p><strong>Email:</strong> hola@pololitos.com</p>
                    <p><strong>Teléfono:</strong> +123 456 7890</p>
                    <p><strong>Horario:</strong> Lunes a Viernes, 9:00 - 18:00</p>
                    <p>¡Conéctate con nosotros y dejemos que los profesionales hagan el trabajo por ti!</p>
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