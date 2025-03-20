<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
            <input type="text" placeholder="¿Qué servicio buscas?">
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
        <h2 class="text-center">${chat.nombre}</h2> <!-- Nombre del chat -->
        <p class="text-center">Conversación entre proveedor y cliente</p>

        <div class="chat-box" id="chat-box">
            <!-- Placeholder de la fecha de inicio de la conversación -->
            <c:if test="${not empty chat.fechaCreacion}">
                <div class="text-center text-muted my-2">
                    <small>
                        Inicio de la conversación: 
                        <fmt:formatDate value="${chat.fechaCreacion}" pattern="dd MMMM yyyy"/>
                    </small>
                </div>
            </c:if>

            <c:forEach var="mensaje" items="${mensajes}">
                <div class="message ${mensaje.usuario.id == solicitanteId ? 'sent' : 'received'}">
                    ${mensaje.contenido}
                </div>
            </c:forEach>
        </div>

        <form class="mt-3" id="mensaje-form">
            <input type="hidden" id="chatId" value="${chatId}">
            <div class="mb-3">
                <textarea class="form-control" id="mensaje-input" rows="2" placeholder="Escribe un mensaje..."></textarea>
            </div>
            <button type="submit" class="btn btn-primary w-100">Enviar</button>
        </form>
    </div>
</div>


<script>
document.getElementById("mensaje-form").addEventListener("submit", function(event) {
    event.preventDefault();
    let chatId = document.getElementById("chatId").value;
    let mensajeInput = document.getElementById("mensaje-input");
    let mensajeTexto = mensajeInput.value.trim();
    if (!mensajeTexto) return;
    let mensajeData = { chatId: chatId, contenido: mensajeTexto };
    fetch("/crear-mensaje", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(mensajeData)
    }).then(() => {
        mensajeInput.value = "";
        cargarMensajes(chatId);
    });
});

function cargarMensajes(chatId) {
    fetch(`/chat-mensajes/${chatId}`)
        .then(response => response.json())
        .then(mensajes => {
            let chatBox = document.getElementById("chat-box");
            chatBox.innerHTML = "";
            mensajes.forEach(mensaje => {
                let div = document.createElement("div");
                div.classList.add("message", mensaje.usuario.id == "USER_ID" ? "sent" : "received");
                div.textContent = mensaje.contenido;
                chatBox.appendChild(div);
            });
            chatBox.scrollTop = chatBox.scrollHeight;
        });
}
setInterval(() => {
    let chatId = document.getElementById("chatId").value;
    if (chatId) cargarMensajes(chatId);
}, 2000);
</script>

</body>
</html>