<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Pololitos</title>
<!-- CSS -->
    <link rel="stylesheet" href="/css/detalleServicios.css">
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
            <div class="circle-busqueda">
                <input type="text" placeholder="¿Qué servicio buscas?">
                <a href=""><img src="img/busqueda.png" alt="lupa de busqueda"></a>
            </div>
            
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
        <aside>
            <div>
                <h2>Titulo trabajo</h2>
                <p>Lorem ipsum dolor, sit amet consectetur adipisicing elit. Consequuntur asperiores veniam tempore necessitatibus, consequatur iusto excepturi corrupti voluptatibus. Vitae eaque dicta nihil facere. Non eaque quos quaerat, molestiae est eos.</p>
                <p>Direccion</p>
            </div>
            <div>
                <div class="user-box">
                    <img src="img/user.png" alt="user">
                    <p>Nombre Usuario</p>
                </div>
                <button>Contactar</button>
            </div>
        </aside>
        <section>
            <div><button> < </button></div>
            <img src="img/trabajo.jpg" alt="trabajo">
            <div><button> > </button></div>
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