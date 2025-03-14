<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Pololitos</title>
<!-- CSS -->
<!--<link rel="stylesheet" href="/css/dashboard.css">-->
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
        </div>
        <div class="user-info">
            <a href=""><img src="img/busqueda.png" alt=""></a>
            <a href=""><img src="img/user.png" alt="Usuario"></a>
            <button>Cerrar Sesión</button>
        </div>
    </header>
    <main class="row">
        <div class="col-8">
            <c:forEach items="$servicios" var="servicio">
                <div class="card" style="width: 18rem;">
                    <img src="${servicio.fotoServicio}" class="card-img-top" alt="...">
                    <div class="card-body">
                        <h5 class="card-title"><a href="/home/${servicio.id}">${servicio.titulo}</a></h5>
                        <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
                    </div>
                  </div>
                  <div class="card-footer text-end">
                    <c:if test="${servicio.creador.id == usuarioEnSesion.id }" >
                        <a href="/editar/${servicio.id}" ><i class="fa-solid fa-pen"></i></a>
                    </c:if>
            </c:forEach>
        </div>
    </main>
    <footer>
        <p>Pololitos &copy; 2025, Todos los derechos reservados</p>
    </footer>
</body>
</html>