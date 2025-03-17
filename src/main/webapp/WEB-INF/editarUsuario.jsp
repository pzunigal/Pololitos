<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
            <div class="logo">
                <img src="img/pololitosBlanco.png" alt="Logo pololitos">
            </div>
            <nav>
                <ul class="nav-links">
                    <li><a href="/">Inicio</a></li>
                    <li><a href="#">Servicios</a></li>
                    <li><a href="/contacto">Contacto</a></li>
                    <li><a href="/nosotros">Nosotros</a></li>
                </ul>
            </nav>
        </div>
        <div class="user-info">
            <a href=""><img src="img/busqueda.png" alt=""></a>
            <a href=""><img src="img/user.png" alt="Usuario"></a>
            <button>Cerrar Sesión</button>
        </div>
    </header>
    <main>
        <div class="profile-card">
            <h1 class="name">Editar Perfil</h1>
            <form action="#" method="post">
                <label for="name">Nombre:</label>
                <input type="text" id="name" name="name" class="input-field" placeholder="Ingresa tu nombre" required>

                <label for="name">Apellido:</label>
                <input type="text" id="name" name="name" class="input-field" placeholder="Ingresa tu apellido" required>
                
                <label for="city">Ciudad:</label>
                <input type="text" id="city" name="city" class="input-field" placeholder="Ingresa tu ciudad" required>
                
                <label for="phone">Teléfono:</label>
                <input type="tel" id="phone" name="phone" class="input-field" placeholder="Ingresa tu numero de telefono: Ej.+(56)9 1414 2424" required>
                
                <label for="profile">Perfil:</label>
                <input type="url" id="profile" name="profile" class="input-field" placeholder="Ingresa la url de una imagen para tu perfil" required>
                
                <label for="password">Contraseña:</label>
                <input type="password" id="password" name="password" class="input-field" placeholder="Ingresa tu nueva contraseña" required>

                <label for="password">Confirmar Contraseña:</label>
                <input type="password" id="password" name="password" class="input-field" placeholder="Confirma tu nueva contraseña" required>
                
                <button type="submit" class="edit-button">Guardar Cambios</button>
            </form>
        </div>
    </main>
    <footer>
        <p>Pololitos &copy; 2025, Todos los derechos reservados</p>
    </footer>
</body>
</html>