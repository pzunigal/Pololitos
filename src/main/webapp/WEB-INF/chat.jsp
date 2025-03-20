<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chat</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css">
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

<div class="container mt-5">
    <div class="chat-container">
        <h2 class="text-center">Chat</h2>
        <p class="text-center">Conversación entre proveedor y cliente</p>

        <div class="chat-box">
            <c:forEach var="mensaje" items="${mensajes}">
                <div class="message ${mensaje.usuario.id == solicitanteId ? 'sent' : 'received'}">
                    ${mensaje.contenido}
                </div>
            </c:forEach>
        </div>
        

        <!-- Formulario para enviar mensajes -->
        <form class="mt-3" id="mensaje-form">
            <input type="hidden" id="chatId" value="${chatId}">
            <div class="mb-3">
                <textarea class="form-control" id="mensaje-input" rows="2" placeholder="Escribe un mensaje..."></textarea>
            </div>
            <button type="submit" class="btn btn-primary w-100">Enviar</button>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
<script>
document.getElementById("mensaje-form").addEventListener("submit", function(event) {
    event.preventDefault();

    let chatId = document.getElementById("chatId").value;
    let mensajeInput = document.getElementById("mensaje-input").value;

    if (mensajeInput.trim() === "") return;

    let mensajeData = {
        chatId: chatId,
        contenido: mensajeInput,
        usuario: { id: "USER_ID" }  // Reemplazar con el ID del usuario autenticado
    };

    fetch("/crear-mensaje", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(mensajeData)
    }).then(response => response.text()).then(data => {
        console.log("Mensaje enviado:", data);
        document.getElementById("mensaje-input").value = "";
        cargarMensajes(chatId);
    });
});

// Cargar mensajes en tiempo real cada 2 segundos
function cargarMensajes(chatId) {
    fetch(`/chat-mensajes/${chatId}`)
        .then(response => response.json())
        .then(mensajes => {
            let chatBox = document.getElementById("chat-box");
            chatBox.innerHTML = ""; // Limpiar mensajes anteriores
            mensajes.forEach(mensaje => {
                let div = document.createElement("div");
                div.classList.add("message", mensaje.usuario.id === "USER_ID" ? "sent" : "received");
                div.textContent = mensaje.contenido;
                chatBox.appendChild(div);
            });
            chatBox.scrollTop = chatBox.scrollHeight; // Auto-scroll
        });
}

// Obtener mensajes cada 2 segundos
setInterval(() => {
    let chatId = document.getElementById("chatId").value;
    if (chatId) {
        cargarMensajes(chatId);
    }
}, 2000);
</script>
</body>
</html>
