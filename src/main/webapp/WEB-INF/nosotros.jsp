<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
   <meta charset="UTF-8">
   <title>Nosotros</title>
   <meta name="viewport" content="width=device-width, initial-scale=1">
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
   <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
   <link href="https://fonts.googleapis.com/css2?family=Quicksand&display=swap" rel="stylesheet">
   <style>
      body {
         font-family: 'Quicksand', sans-serif;
         background-color: #1e1e1e;
         color: white;
         display: flex;
         flex-direction: column;
         min-height: 100vh;
      }
      main {
         flex: 1;
         padding: 4rem 2rem;
      }
   </style>
</head>
<body>

   <%@ include file="/WEB-INF/componentes/nav.jsp" %>

<main class="container text-center">
    <h1 class="mb-4">¿Quiénes somos?</h1>
    <p class="lead">
       Somos una empresa que busca conectar a personas que necesitan ayuda con tareas y profesionales dispuestos a ayudar. <br>
       Facilitamos el día a día de nuestros usuarios promoviendo la colaboración y eficiencia.
    </p>
 
    <a href="/servicios" class="btn btn-outline-light mt-4">
       <i class="bi bi-arrow-left"></i> Volver a Servicios
    </a>
 </main>
 

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
