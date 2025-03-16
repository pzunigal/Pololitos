<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Document</title>
        <link rel="stylesheet" href="css/buscar.css">
    </head>
    <body>
        <header>
            <div class="nav-container">
                <div class="logo">
                    <img src="img/pololitosBlanco.png" alt="Logo pololitos">
                </div>
                <nav>
                    <ul class="nav-links">
                        <li><a href="#">Inicio</a></li>
                        <li><a href="#">Servicios</a></li>
                        <li><a href="#">Contacto</a></li>
                        <li><a href="#">Nosotros</a></li>
                    </ul>
            </div>
            <div class="user-info">
                <a href=""><img src="img/busqueda.png" alt=""></a>
                <a href=""><img src="img/user.png" alt="Usuario"></a>
                <button>Cerrar Sesión</button>
            </div>
        </header>
        <main>
            <div class="search-wrapper">
                <div class="search-container">
                    <input type="text" class="search-input" placeholder="Buscar empleos...">
                    <button class="search-button">
                        <img src="img/busqueda.png" alt="">
                    </button>
                </div>
            </div>
            <div class="section">
                <h2>Empleos Encontrados</h2>
                <div class="cards">
                    <img src="img/trabajo.jpg" alt="Imagen de la card">
                    <div>
                    <h3 class="cards-title">Título de la Card</h3>
                    <p class="cards-category">Categoría: Ejemplo</p>
                    <p class="cards-address">Dirección: Calle Falsa 123</p>
                </div>
                </div>
            </div>
        </main>
        <footer>
            <p>Pololitos &copy; 2025, Todos los derechos reservados</p>
        </footer>
    </body>
    </html>