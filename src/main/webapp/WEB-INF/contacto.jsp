<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Contacto - Pololitos</title>

    <!-- Fuentes personalizadas -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans:ital,wght@0,100..900;1,100..900&family=Quicksand:wght@300..700&family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&family=Winky+Sans:ital,wght@0,300..900;1,300..900&display=swap" rel="stylesheet">

    <!-- Bootstrap & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        body {
            font-family: 'Quicksand', 'Roboto', 'Noto Sans', 'Winky Sans', sans-serif;
            min-height: 100vh;
            background-image: url('https://c1.wallpaperflare.com/path/427/745/192/notebook-natural-laptop-macbook-497500668a927f46aa19fafb668d8702.jpg');
            background-size: cover;
            background-position: center;
            display: flex;
            flex-direction: column;
            color: white;
        }

        .form-control, .form-select {
            background-color: #f8f9fa;
        }

        .contact-box {
            background-color: rgba(0,0,0,0.8);
            padding: 2rem;
            border-radius: 1rem;
        }
    </style>
</head>

<body class="d-flex flex-column">

    <!-- Navbar -->
    <%@ include file="/WEB-INF/componentes/nav.jsp" %>

    <!-- Main content -->
    <main class="container my-5">
        <div class="text-center mb-4">
            <h1>Contáctanos - Pololitos</h1>
            <p class="lead">¿Tienes dudas o quieres publicitar tu servicio? ¡Estamos aquí para ayudarte!</p>
        </div>

        <div class="row justify-content-center">
            <div class="col-md-8 contact-box">
                <form action="#" method="POST">
                    <div class="mb-3">
                        <label for="nombre" class="form-label">Nombre:</label>
                        <input type="text" class="form-control" id="nombre" name="nombre" placeholder="Tu nombre" required>
                    </div>
                    <div class="mb-3">
                        <label for="email" class="form-label">Correo electrónico:</label>
                        <input type="email" class="form-control" id="email" name="email" placeholder="tuemail@ejemplo.com" required>
                    </div>
                    <div class="mb-3">
                        <label for="telefono" class="form-label">Teléfono (opcional):</label>
                        <input type="tel" class="form-control" id="telefono" name="telefono" placeholder="123-456-7890">
                    </div>
                    <div class="mb-3">
                        <label for="mensaje" class="form-label">¿En qué te podemos ayudar?</label>
                        <textarea class="form-control" id="mensaje" name="mensaje" rows="5" placeholder="Describe tu necesidad o tarea..." required></textarea>
                    </div>
                    <div class="text-center">
                        <button type="submit" class="btn btn-warning btn-lg px-5">Enviar mensaje</button>
                    </div>
                </form>
            </div>

            <div class="col-md-4 mt-5 mt-md-0 contact-box">
                <h4>Otras formas de contactarnos</h4>
                <p><strong>Email:</strong> hola@pololitos.com</p>
                <p><strong>Teléfono:</strong> +123 456 7890</p>
                <p><strong>Horario:</strong> Lunes a Viernes, 9:00 - 18:00</p>
                <p>¡Conéctate con nosotros y deja que los profesionales hagan el trabajo por ti!</p>
            </div>
        </div>
    </main>

    <!-- Footer -->
    <footer class="bg-dark text-white text-center py-3 mt-auto">
        <p class="mb-1">Pololitos &copy; 2025. Todos los derechos reservados</p>
        <ul class="nav justify-content-center">
            <li class="nav-item"><a class="nav-link text-white" href="/contacto">Contacto</a></li>
            <li class="nav-item"><a class="nav-link text-white" href="/nosotros">Nosotros</a></li>
        </ul>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
