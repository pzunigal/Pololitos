<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="es">
<head>
   <meta charset="UTF-8">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <title>Iniciar Sesión</title>

   <!-- Fuentes -->
   <link href="https://fonts.googleapis.com/css2?family=Quicksand&display=swap" rel="stylesheet">
   <!-- Bootstrap & Icons -->
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
   <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

   <style>
      body {
         font-family: 'Quicksand', sans-serif;
         background-image: url('https://c1.wallpaperflare.com/path/427/745/192/notebook-natural-laptop-macbook-497500668a927f46aa19fafb668d8702.jpg');
         background-size: cover;
         background-position: center;
         color: white;
         min-height: 100vh;
         display: flex;
         flex-direction: column;
      }

      .login-wrapper {
         flex: 1;
         display: flex;
         justify-content: center;
         align-items: center;
         padding-top: 80px;
      }

      .login-container {
         background-color: rgba(0,0,0,0.75);
         padding: 40px;
         border-radius: 12px;
         width: 100%;
         max-width: 400px;
         color: white;
      }

      .form-label {
         margin-top: 10px;
         color: white;
      }

      .form-control {
         background-color: #2c2c2c;
         color: white;
         border: 1px solid #555;
      }

      .form-control::placeholder {
         color: #bbb;
      }

      .btn-primary {
         width: 100%;
         margin-top: 15px;
      }

      .btn-google {
         background-color: #fff;
         color: #444;
         border: none;
         width: 100%;
         margin-top: 10px;
         display: flex;
         align-items: center;
         justify-content: center;
         gap: 8px;
         font-weight: bold;
         border-radius: 4px;
      }

      .btn-google img {
         width: 20px;
         height: 20px;
      }

      footer {
         background-color: rgba(15, 16, 20, 0.95);
         color: #ddd;
         text-align: center;
         padding: 12px 0;
         font-size: 15px;
         font-weight: 300;
      }

      .nav-footer {
         display: flex;
         justify-content: center;
         gap: 15px;
         list-style: none;
         padding: 0;
         margin-top: 5px;
      }

      .nav-footer a {
         color: #bbb;
         text-decoration: none;
         font-size: 14px;
         transition: color 0.3s ease;
      }

      .nav-footer a:hover {
         color: #fff;
      }
   </style>
</head>
<body>

<!-- Navbar Bootstrap -->
<%@ include file="/WEB-INF/componentes/nav.jsp" %>
<!-- Login Form -->
<div class="login-wrapper container">
   <div class="row w-100">
      <div class="col-lg-6 d-flex align-items-center justify-content-center">
         <img src="/img/pololitos.png" alt="Logo pololitos" class="img-logo" style="max-width: 500px;">
      </div>
      <div class="col-lg-6">
         <div class="login-container">
            <h2 class="text-center mb-4">Iniciar Sesión</h2>
            <form:form action="/iniciarSesion" method="POST" modelAttribute="loginUsuario">
               <div class="mb-3">
                  <form:label path="emailLogin" class="form-label">Correo Electrónico</form:label>
                  <form:input path="emailLogin" class="form-control" />
                  <form:errors path="emailLogin" class="text-danger" />
               </div>
               <div class="mb-3">
                  <form:label path="passwordLogin" class="form-label">Contraseña</form:label>
                  <form:input path="passwordLogin" type="password" class="form-control" />
                  <form:errors path="passwordLogin" class="text-danger" />
               </div>
               <button type="submit" class="btn btn-primary">Ingresar</button>
            </form:form>
            <button class="btn btn-google">
               <img src="https://res.cloudinary.com/dwz4chwv7/image/upload/v1742869751/google_yqrlgh.png" alt="Google Logo">
               Acceder con Google
            </button>
            <p class="text-center mt-3">¿No tienes una cuenta? <a href="/registro" class="text-warning">Regístrate</a></p>
         </div>
      </div>
   </div>
</div>

<!-- Footer -->
<footer class="mt-auto">
   <p class="mb-1">Pololitos &copy; 2025, Todos los derechos reservados</p> 
   <ul class="nav-footer">
      <li><a href="/contacto">Contacto</a></li>
      <li><a href="/nosotros">Nosotros</a></li>
   </ul>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
