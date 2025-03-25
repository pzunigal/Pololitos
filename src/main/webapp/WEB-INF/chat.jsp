<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chat</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="/css/home.css">
    <style>
        .chat-container {
            max-width: 600px;
            margin: 20px auto;
            padding: 20px;
            border: 2px solid #3498db;
            border-radius: 10px;
            background-color: #ecf0f1;
        }
        .chat-box {
            height: 300px;
            overflow-y: scroll;
            border: 1px solid #ccc;
            padding: 10px;
            background: white;
        }
        .message {
            margin: 5px 0;
            padding: 8px;
            border-radius: 5px;
        }
        .sent {
            background-color: #3498db;
            color: white;
            text-align: right;
        }
        .received {
            background-color: #2ecc71;
            color: white;
            text-align: left;
        }
    </style>
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
        <div class="circle-busqueda">
            <input type="text" placeholder="Buscar">
            <a href=""><img src="img/busqueda.png" alt="lupa de busqueda"></a>
        </div>
        <c:choose>
            <c:when test="${not empty sessionScope.usuarioEnSesion}">
                <a href="/perfilUsuario">
                    <img src="${sessionScope.usuarioEnSesion.fotoPerfil}" alt="Foto de perfil" width="40" height="40" style="border-radius: 50%;">
                </a>
                <a href="/servicios/publicar"><button>Crear Servicio</button></a>
                <a href="/logout"><button>Cerrar Sesión</button></a>
            </c:when>
            <c:otherwise>
                <a href="/login"><button>Iniciar sesión</button></a>
                <a href="/registro"><button>Regístrate</button></a>
            </c:otherwise>
        </c:choose>
    </div>
</header>

<div class="container mt-5">
    <div class="chat-container">
        <h2 class="text-center">${chat.nombre}</h2>
        <p class="text-center">Conversación entre proveedor y cliente</p>

        <div class="chat-box" id="chat-box"></div>

        <form class="mt-3" id="mensaje-form">
            <input type="hidden" id="chatId" value="${chatId}">
            <input type="hidden" id="usuarioId" value="${sessionScope.usuarioEnSesion.id}">
            <input type="hidden" id="nombreUsuario" value="${sessionScope.usuarioEnSesion.nombre}">
            <div class="mb-3">
                <textarea class="form-control" id="mensaje-input" rows="2" placeholder="Escribe un mensaje..."></textarea>
            </div>
            <button type="submit" class="btn btn-primary w-100">Enviar</button>
        </form>
    </div>
</div>

<script src="https://www.gstatic.com/firebasejs/9.6.1/firebase-app-compat.js"></script>
<script src="https://www.gstatic.com/firebasejs/9.6.1/firebase-database-compat.js"></script>
<script>
    const firebaseConfig = {
        apiKey: "",
        authDomain: "pololitos-a96fb.firebaseapp.com",
        databaseURL: "https://pololitos-a96fb-default-rtdb.firebaseio.com",
        projectId: "pololitos-a96fb",
        storageBucket: "pololitos-a96fb.appspot.com",
        messagingSenderId: "",
        appId: ""
    };
    firebase.initializeApp(firebaseConfig);
    const db = firebase.database();

    const chatId = document.getElementById("chatId").value;
    const usuarioId = parseInt(document.getElementById("usuarioId").value);
    const nombreUsuario = document.getElementById("nombreUsuario").value;

    const chatBox = document.getElementById("chat-box");
    const mensajeForm = document.getElementById("mensaje-form");
    const mensajeInput = document.getElementById("mensaje-input");

    const mensajesRef = db.ref("chats/" + chatId + "/mensajes");

    mensajesRef.on("child_added", function(snapshot) {
        const mensaje = snapshot.val();
        const div = document.createElement("div");
        div.className = "message " + (mensaje.usuarioId === usuarioId ? "sent" : "received");

        if (mensaje.usuarioId !== usuarioId) {
            const nombre = document.createElement("span");
            nombre.className = "nombre-usuario";
            nombre.textContent = mensaje.nombreUsuario + ":";
            div.appendChild(nombre);
        }

        const contenido = document.createElement("span");
        contenido.textContent = mensaje.contenido;
        div.appendChild(contenido);

        chatBox.appendChild(div);
        chatBox.scrollTop = chatBox.scrollHeight;
    });

    mensajeForm.addEventListener("submit", function(e) {
        e.preventDefault();
        enviarMensaje();
    });

    mensajeInput.addEventListener("keydown", function(e) {
        if (e.key === "Enter" && !e.shiftKey) {
            e.preventDefault(); // Evita el salto de línea
            enviarMensaje();
        }
    });

    function enviarMensaje() {
        const contenido = mensajeInput.value.trim();
        if (contenido !== "") {
            const nuevoMensaje = {
                contenido: contenido,
                usuarioId: usuarioId,
                nombreUsuario: nombreUsuario,
                createdAt: new Date().toISOString()
            };
            mensajesRef.push(nuevoMensaje);
            mensajeInput.value = "";
        }
    }
</script>
</body>
</html>
