<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

        <!DOCTYPE html>
        <html lang="es">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">

            <title>Contacto - Pololitos</title>

            <!-- Fuentes personalizadas -->
            <link rel="preconnect" href="https://fonts.googleapis.com">
            <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
            <link
                href="https://fonts.googleapis.com/css2?family=Noto+Sans:ital,wght@0,100..900;1,100..900&family=Quicksand:wght@300..700&family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&family=Winky+Sans:ital,wght@0,300..900;1,300..900&display=swap"
                rel="stylesheet">

            <!-- Bootstrap & Icons -->
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
            <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
            <link rel="stylesheet" href="<c:url value='/css/global.css' />" />
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
            </style>
        </head>

        <body class="d-flex flex-column">

            <!-- Navbar -->
            <%@ include file="/WEB-INF/componentes/layout/nav.jsp" %>

                <!-- Main content -->
                <main class="container my-5">
                    <div class="text-center mb-4">
                        <h1>Contáctanos - Pololitos</h1>
                        <p class="lead">¿Tienes dudas o quieres publicitar tu servicio? ¡Estamos aquí para ayudarte!</p>
                    </div>

                    <div class="row justify-content-around">
                        <!-- Formulario de contacto -->
                        <%@ include file="/WEB-INF/componentes/forms/contactForm.jsp" %>

                            <!-- Información de contacto -->
                            <%@ include file="/WEB-INF/componentes/cards/contactInfo.jsp" %>
                    </div>

                    </div>
                </main>

                <!-- Footer -->
                <%@ include file="/WEB-INF/componentes/layout/footer.jsp" %>

                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>