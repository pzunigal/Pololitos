<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link rel="stylesheet" href="/css/login-registro.css">
    </head>
<body>
    <a href="/">
        <div class="logo">
            <img src="img/pololitosBlanco.png" alt="Logo pololitos">
        </div>
    </a>
    <div class="divider"></div>
    <div class="login-container">
        <h2>Iniciar Sesión</h2>
        <form:form action="/iniciarSesion" method="POST" modelAttribute="loginUsuario">
            <div class="input-group">
                <form:label path="emailLogin">Dirección de email</form:label>
                <form:input path="emailLogin" cssClass="error-text"/>
                <form:errors path="emailLogin"/>
            </div>
            <div class="input-group">
                <form:label path="passwordLogin">Contraseña</form:label>
                <form:input path="passwordLogin" type="password"/>
                <form:errors path="passwordLogin"/>
            </div>            
            <button type="submit">Ingresar</button>
        </form:form>
        <p>¿No tienes una cuenta? <a href="/registro">Registrate</a></p>
    </div>
    <footer>
        <p>Pololitos &copy; 2025, Todos los derechos reservados</p> 
        <ul class="nav-footer">
            <li><a href="/contacto">Contacto</a></li>
            <li><a href="/nosotros">Nosotros</a></li>
        </ul>
    </footer>
</body>
</html>