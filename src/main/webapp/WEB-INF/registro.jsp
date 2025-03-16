<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registro</title>
    <link rel="stylesheet" href="/css/styles.css">
    </head>
<body>
    <img src="img/pololitos.png" alt="Logo pololitos" class="img-logo">
    <div class="divider"></div>
    <div class="login-container">
        <h2>Crear Cuenta</h2>
        <form:form action="" method="POST" modelAttribute="nuevoUsuario">
        	<div class="input-group-two">
                <div class="input-group">
                    <form:label path="nombre">Nombre:</form:label>
                    <form:input path="nombre"/>
                    <form:errors path="nombre"/>
                </div>
                <div class="input-group">
                    <form:label path="apellido">Apellido:</form:label>
                    <form:input path="apellido"/>
                    <form:errors path="apellido"/>
                </div>
            </div>
            <div class="input-group-two">
                <div class="input-group">
                    <form:label path="direccion">Ciudad:</form:label>
                    <form:input path="direccion"/>
                    <form:errors path="direccion"/>
                </div>
                <div class="input-group">
                    <form:label path="telefono">Telefono:</form:label>
                    <form:input path="telefono"/>
                    <form:errors path="telefono"/>
                </div>
            </div> 
            <div class="input-group">
                <form:label path="fotoPerfil">URL perfil:</form:label>
                <form:input path="fotoPerfil"/>
                <form:errors path="fotoPerfil"/>
            </div>
            <div class="input-group">
                <form:label path="email" >E-mail:</form:label>
				<form:input path="email" class="form-control" />
				<form:errors path="email" class="text-danger" />
            </div>
            <div class="input-group">
                <form:label path="password">Password:</form:label>
				<form:password path="password" class="form-control" />
				<form:errors path="password" class="text-danger" />
            </div>
            <div class="input-group">
                <form:label path="confirmacion">Confirmacion:</form:label>
				<form:password path="confirmacion" class="form-control" />
				<form:errors path="confirmacion" class="text-danger" />
            </div>
            <p class="miniTexto">Al crear una cuenta muestras tu conformidad con nuestros Términos de uso y nuestra Política de privacidad, confirmando además que tienes 18 años o más.</p>
            <button type="submit">Crear Cuenta</button>
        </form:form>
        <p>¿Ya tienes una cuenta? <a href="/login">Acceder</a></p>
    </div>
    <footer>
        <p>Pololitos &copy; 2025, Todos los derechos reservados</p>
    </footer>
</body>
</html>