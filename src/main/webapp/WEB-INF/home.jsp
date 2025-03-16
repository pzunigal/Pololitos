<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Pololitos</title>
<!-- CSS -->
<!--<link rel="stylesheet" href="/css/dashboard.css">-->
<link rel="stylesheet" href="/css/home.css">
<!-- BOOTSTRAP -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<!-- FONT AWESOME (iconos) -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
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
            </nav>
        </div>
        <div class="user-info">
            <div class="circle-busqueda"><input type="text" placeholder="¿Que necesitas hacer?"><a href=""><img src="img/busqueda.png" alt=""></a></div>
            <a href=""><img src="img/user.png" alt="Usuario"></a>
            <button>Cerrar Sesión</button>
        </div>
    </header>
    <main>
        <div class="container">
            <div class="content">
                <h1>Publica un Pololo. <br>Alguien lo hará por ti.</h1>
                <p>Conectamos personas que necesitan ayuda con tareas y las conectamos con profesionales</p>
                <button>SOLICITAR ANUNCIO</button>
            </div>
        </div>

        <div class="section">
            <h2>Empleos Recomendados</h2>
            <div class="cards">
                <div class="card">
                    <img src="img/work.jpg" alt="">
                    <h2>Fontanero</h2>
                    <p>Ciudad: </p>
                </div>
                <div class="card">
                    <img src="img/work.jpg" alt="">
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