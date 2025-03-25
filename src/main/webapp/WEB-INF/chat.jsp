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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css"
      rel="stylesheet"
    />
    <link
      href="https://fonts.googleapis.com/css2?family=Quicksand&display=swap"
      rel="stylesheet"
    />
    <link rel="stylesheet" href="<c:url value='/css/views/chat.css' />" />

</head>
<body class="body-without-bg">
    <%@ include file="/WEB-INF/componentes/layout/nav.jsp" %>

<main>
    <div class="servicio-container">
        <div class="servicio-info">
            <h2>Nombre de servicio</h2>
            <p>Descripcion de servicio
                Lorem ipsum dolor sit amet consectetur adipisicing elit. Est enim necessitatibus modi suscipit minus. Rem reprehenderit adipisci recusandae voluptas ducimus maxime molestiae voluptatem ad. Expedita cumque in magni incidunt saepe!
            </p>
        </div>
        <img src="/img/work.jpg" alt="">
        <button>Ver servicio</button>
    </div>
    <div class="container">
    <div class="chat-container">
        
        <div class="header-chat">
            <img src="/img/user.png" alt="">
            <div class="info-user">
                <h2>Nombre</h2>
                <p>Servicio que ofrece</p>
            </div>
            
        </div>
        

        <div class="chat-box" id="chat-box"></div>

        <form class="mensaje-form" id="mensaje-form">
            <input type="hidden" id="chatId" value="${chatId}">
            <input type="hidden" id="usuarioId" value="${sessionScope.usuarioEnSesion.id}">
            <input type="hidden" id="nombreUsuario" value="${sessionScope.usuarioEnSesion.nombre}">
        
            <textarea class="form-control" id="mensaje-input" rows="1" placeholder="Escribe un mensaje..."></textarea>
            
            <button type="submit" class="enviar-btn">
                <i class="fas fa-paper-plane"></i>
            </button>
        </form>
    </div>
</div>
</main>
<footer>
  <button onclick="volverAtrasRecargando()">
    <i class="fa-solid fa-arrow-left"></i>
    Volver
  </button>
  
</footer>
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
    function volverAtrasRecargando() {
    window.history.back(); // retrocede
    setTimeout(() => {
      location.reload(); // recarga la página al llegar
    }, 100); // pequeño delay para que alcance a cambiar la URL
  }

</script>
</body>
</html>