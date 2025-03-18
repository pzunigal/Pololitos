<%@ taglib uri="http://www.springframework.org/tags" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Detalles del Servicio</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="/css/main.css">
</head>
<body>

    <div class="container">
        <h1 class="text-center my-4">Detalles del Servicio</h1>

        <c:if test="${not empty servicio}">
            <div class="card card-profile-service">
                <img src="${servicio.imgUrl}" class="card-img-top img-card-profile-service" alt="${servicio.nombre}">
                <div class="card-body">
                    <div class="section">
                        <h5 class="card-title text-primary">${servicio.nombre}</h5>
                    </div>

                    <div class="section">
                        <p class="card-text">${servicio.descripcion}</p>
                    </div>

                    <div class="section">
                        <p><strong>Precio:</strong> $${servicio.precio}</p>
                    </div>

                    <div class="section">
                        <p><strong>Ubicación:</strong> ${servicio.ciudad}</p>
                    </div>

                    <div class="section">
                        <p><strong>Fecha de publicación:</strong> ${servicio.createdAt}</p>
                    </div>

                    <h3 class="mt-3">Comentarios</h3>

                    <button onclick="window.history.back()" class="btn btn-secondary btn-custom">Volver</button>
                    <button class="btn btn-primary btn-custom" data-bs-toggle="modal" data-bs-target="#chatModal">
                        <i class="fas fa-comment-alt"></i> Contactar al Vendedor
                    </button>
                </div>
            </div>
        </c:if>
    </div>

    <!-- Modal de Chat -->
    <div class="modal fade" id="chatModal" tabindex="-1" aria-labelledby="chatModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="chatModalLabel">Chat con el Vendedor</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="chat-box">
                        <!-- Mensajes de chat -->
                    </div>
                    <div class="input-group mt-3">
                        <input type="text" class="form-control" placeholder="Escribe un mensaje..." id="chatMessage">
                        <button class="btn btn-primary" onclick="sendMessage()">Enviar</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS y Popper.js -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"></script>
    <script src="/js/detallesServicio.js"></script>
    <script>
        function sendMessage() {
    var message = document.getElementById("chatMessage").value;
    if (message.trim() !== "") {
        var chatBox = document.querySelector(".chat-box");
        var newMessage = document.createElement("p");
        newMessage.textContent = "Tú: " + message;
        chatBox.appendChild(newMessage);
        document.getElementById("chatMessage").value = "";
        chatBox.scrollTop = chatBox.scrollHeight;
    }
}
    </script>
</body>
</html>
