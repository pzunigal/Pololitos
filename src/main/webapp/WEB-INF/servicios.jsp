<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Servicios</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
</head>
<body>
    <div class="container mt-5">
        <h1>Servicios por Categoría</h1>
        
        <c:forEach var="categoria" items="${categorias}">
            <h2 class="mt-4">${categoria.nombre}</h2>
            
            <c:if test="${empty categoria.servicios}">
                <p>No hay servicios disponibles en esta categoría.</p>
            </c:if>
            
            <div class="row">
                <c:forEach var="servicio" items="${categoria.servicios}">
                    <div class="col-md-4 mb-4">
                        <div class="card">
                            <img src="${servicio.imgUrl}" class="card-img-top" alt="${servicio.nombre}">
                            <div class="card-body">
                                <h5 class="card-title">${servicio.nombre}</h5>
                                <p class="card-text">${servicio.descripcion}</p>
                                <p class="card-text"><strong>Precio:</strong> $${servicio.precio}</p>
                                <p class="card-text"><small class="text-muted">Autor: ${servicio.usuario.nombre}</small></p>
                                
                                <a href="solicitarServicio?id=${servicio.id}" class="btn btn-primary">
                                    <i class="fas fa-hand-paper"></i> Solicitar Servicio
                                </a>
                                
                                <button class="btn btn-success mt-2" data-bs-toggle="modal" data-bs-target="#contactModal" 
                                    onclick="openModal('${servicio.usuario.nombre}', '${servicio.nombre}')">
                                    <i class="fas fa-comment-alt"></i> Contactar con el Vendedor
                                </button>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:forEach>
    </div>

    <!-- Modal -->
    <div class="modal fade" id="contactModal" tabindex="-1" aria-labelledby="contactModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="contactModalLabel">Chat con el Vendedor</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                </div>
                <div class="modal-body">
                    <p><strong>Vendedor:</strong> <span id="modalVendedor"></span></p>
                    <p><strong>Servicio:</strong> <span id="modalServicio"></span></p>
                    
                    <!-- Espacio para mostrar mensajes -->
                    <div id="chatMessages" class="border rounded p-3 mb-3" style="height: 250px; overflow-y: auto; background-color: #f8f9fa;">
                        <div class="text-start"><strong>Vendedor:</strong> Hola, ¿cómo puedo ayudarte?</div>
                        <div class="text-end"><strong>Tú:</strong> Me interesa este servicio, ¿qué incluye?</div>
                        <div class="text-start"><strong>Vendedor:</strong> Incluye todo lo necesario para que puedas usarlo sin problemas.</div>
                    </div>

                    <!-- Input para enviar mensaje -->
                    <div class="input-group">
                        <input type="text" id="messageInput" class="form-control" placeholder="Escribe tu mensaje...">
                        <button class="btn btn-primary" onclick="sendMessage()">
                            <i class="fa-solid fa-paper-plane"></i>
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        function openModal(vendedorNombre, servicioTitulo) {
            document.getElementById('modalVendedor').innerText = vendedorNombre;
            document.getElementById('modalServicio').innerText = servicioTitulo;
            document.getElementById('chatMessages').innerHTML = `
                <div class="text-start"><strong>${vendedorNombre}:</strong> Hola, ¿cómo puedo ayudarte?</div>
                <div class="text-end"><strong>Tú:</strong> Me interesa este servicio, ¿qué incluye?</div>
                <div class="text-start"><strong>${vendedorNombre}:</strong> Incluye todo lo necesario para que puedas usarlo sin problemas.</div>
            `;
        }

        function sendMessage() {
            let messageInput = document.getElementById('messageInput');
            let messageText = messageInput.value.trim();
            if (messageText !== "") {
                let chatMessages = document.getElementById('chatMessages');
                let newMessage = document.createElement("div");
                newMessage.classList.add("text-end");
                newMessage.innerHTML = `<strong>Tú:</strong> ${messageText}`;
                chatMessages.appendChild(newMessage);
                chatMessages.scrollTop = chatMessages.scrollHeight;
                messageInput.value = "";
            }
        }
    </script>
</body>
</html>
