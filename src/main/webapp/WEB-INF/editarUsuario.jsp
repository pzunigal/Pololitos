<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Editar Usuario</title>
    <link rel="stylesheet" href="/css/dashboard.css">
</head>
<body>
    <header>
        <div class="nav-container">
            <a href="/">
                <div class="logo">
                    <img src="img/pololitosBlanco.png" alt="Logo pololitos">
                </div>
            </a>
            <nav>
                <ul class="nav-links">
                    <li><a href="/servicios">Servicios</a></li>
                    <c:if test="${not empty sessionScope.usuarioEnSesion}">
                        <li><a href="/mis-servicios">Mis Servicios</a></li>
                        <li><a href="/mis-solicitudes-enviadas">Enviadas</a></li>
                        <li><a href="/mis-solicitudes-recibidas">Recibidas</a></li>
                    </c:if>
                </ul>
            </nav>
        </div>
        <div class="user-info">
            <form action="/buscar-servicios" method="get">
                <div class="circle-busqueda" id="busqueda-container">
                    <input type="text" name="query" id="busqueda-input" placeholder="¿Qué servicio buscas?">
                    <button type="submit" id="busqueda-btn">
                        <img src="img/busqueda.png" alt="lupa de busqueda" id="busqueda-icon">
                    </button>
                </div>
            </form>
            <c:if test="${not empty sessionScope.usuarioEnSesion}">
                <a href="/perfilUsuario">
                    <img src="${sessionScope.usuarioEnSesion.fotoPerfil}" alt="Foto de perfil"
                         width="40" height="40" style="border-radius: 50%;">
                </a>
                <a href="/servicios/publicar"><button>Crear Servicio</button></a>
                <a href="/logout"><button>Cerrar Sesión</button></a>
            </c:if>
        </div>
    </header>

    <main>
        <div class="profile-card">
            <h1 class="name">Editar Perfil</h1>
            <form method="post" action="/actualizarPerfil" enctype="multipart/form-data">
                <input type="hidden" name="_method" value="PATCH" />

                <label for="nombre">Nombre:</label>
                <input type="text" name="nombre" value="${usuario.nombre}" class="input-field" placeholder="Nombre completo" required />

                <label for="apellido">Apellido:</label>
                <input type="text" name="apellido" value="${usuario.apellido}" class="input-field" placeholder="Apellido" required />

                <label for="ciudad">Ciudad:</label>
                <input type="text" name="ciudad" value="${usuario.ciudad}" class="input-field" placeholder="Ciudad" required />

                <label for="telefono">Teléfono:</label>
                <input type="text" name="telefono" value="${usuario.telefono}" class="input-field" placeholder="Ej. +56912345678" required />

                <label>Imagen actual:</label><br>
                <img src="${usuario.fotoPerfil}" alt="Imagen actual" style="max-width: 200px; margin-bottom: 10px;"><br>

                <label for="fotoPerfilArchivo">Nueva imagen (opcional):</label>
                <input type="file" id="fotoPerfilArchivo" name="fotoPerfilArchivo" accept="image/*" class="input-field">
                <img id="preview" style="display:none; max-width: 200px; margin-top: 10px;"><br>

                <button type="submit" class="edit-button">Guardar Cambios</button>
            </form>
        </div>
    </main>

    <footer>
        <p>Pololitos &copy; 2025. Todos los derechos reservados</p>
        <ul class="nav-footer">
            <li><a href="/contacto">Contacto</a></li>
            <li><a href="/nosotros">Nosotros</a></li>
        </ul>
    </footer>

    <script>
        document.getElementById('fotoPerfilArchivo').addEventListener('change', function(event) {
            const preview = document.getElementById('preview');
            const file = event.target.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    preview.src = e.target.result;
                    preview.style.display = 'block';
                };
                reader.readAsDataURL(file);
            } else {
                preview.style.display = 'none';
            }
        });
    </script>
</body>
</html>
