<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
            <!DOCTYPE html>
            <html lang="es">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Registro</title>
                <link rel="stylesheet" href="/css/login-registro.css">
            </head>

            <body>
                <div class="fila-contenedor">
                    <a href="/"><img src="img/pololitos.png" alt="Logo pololitos" class="img-logo"></a>
                    <div class="divider"></div>
                    <div class="login-container">
                        <h2>Crear Cuenta</h2>
                        <form:form action="" method="POST" modelAttribute="nuevoUsuario" enctype="multipart/form-data">
                            <div class="input-group-two">
                                <div class="input-group">
                                    <form:label path="nombre">Nombre:</form:label>
                                    <form:input path="nombre" />
                                    <form:errors path="nombre" class="text-danger" />
                                </div>
                                <div class="input-group">
                                    <form:label path="apellido">Apellido:</form:label>
                                    <form:input path="apellido" />
                                    <form:errors path="apellido" class="text-danger" />
                                </div>
                            </div>
                            <div class="input-group-two">
                                <div class="input-group">
                                    <form:label path="ciudad">Ciudad:</form:label>
                                    <form:input path="ciudad" />
                                    <form:errors path="ciudad" class="text-danger" />
                                </div>
                                <div class="input-group">
                                    <form:label path="telefono">Telefono:</form:label>
                                    <form:input path="telefono" />
                                    <form:errors path="telefono" class="text-danger" />
                                </div>
                            </div>
                            <div class="input-group">
                                <form:label path="email">Correo:</form:label>
                                <form:input path="email" />
                                <form:errors path="email" class="text-danger" />
                            </div>
                            <div class="input-group">
                                <form:label path="fotoPerfilArchivo">Foto de Perfil:</form:label>
                                <form:input path="fotoPerfilArchivo" type="file" accept="image/*" />
                                <form:errors path="fotoPerfilArchivo" class="text-danger" />
                                <img id="preview" style="display:none; max-width: 150px; margin-top: 10px;">

                                <img id="preview" style="display:none; max-width: 150px; margin-top: 10px;">
                            </div>
                            <div class="input-group-two">
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
                            </div>
                            <p class="miniTexto">Al crear una cuenta muestras tu conformidad con nuestros Términos de
                                uso y nuestra Política de privacidad, confirmando además que tienes 18 años o más.</p>
                            <button type="submit">Crear Cuenta</button>
                        </form:form>
                        <p>¿Ya tienes una cuenta? <a href="/login">Acceder</a></p>
                    </div>
                </div>
                <footer>
                    <p>Pololitos &copy; 2025, Todos los derechos reservados</p>
                    <ul class="nav-footer">
                        <li><a href="/contacto">Contacto</a></li>
                        <li><a href="/nosotros">Nosotros</a></li>
                    </ul>
                </footer>
                <script>
                    document.getElementById('fotoPerfil').addEventListener('change', function (event) {
                        const preview = document.getElementById('preview');
                        const file = event.target.files[0];
                        if (file) {
                            const reader = new FileReader();
                            reader.onload = function (e) {
                                preview.src = e.target.result;
                                preview.style.display = 'block';
                            }
                            reader.readAsDataURL(file);
                        } else {
                            preview.style.display = 'none';
                        }
                    });
                </script>
            </body>

            </html>