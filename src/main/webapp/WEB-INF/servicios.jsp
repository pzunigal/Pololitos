<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Servicios</title>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link rel="stylesheet" href="/css/servicios.css">
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
                        <!-- Agregar la opción Mis Servicios solo si el usuario está logueado -->
                        <c:choose>
                            <c:when test="${not empty sessionScope.usuarioEnSesion}">
                                <li><a href="/mis-servicios">Mis Servicios</a></li>
                            </c:when>
                        </c:choose>
                        <c:choose>
                            <c:when test="${not empty sessionScope.usuarioEnSesion}">
                                <li><a href="/mis-solicitudes-enviadas">Enviadas</a></li>
                            </c:when>
                        </c:choose>
                        <c:choose>
                            <c:when test="${not empty sessionScope.usuarioEnSesion}">
                                <li><a href="/mis-solicitudes-recibidas">Recibidas</a></li>
                            </c:when>
                        </c:choose>
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
                            <img src="${sessionScope.usuarioEnSesion.fotoPerfil}" alt="Foto de perfil"
                                width="40" height="40" style="border-radius: 50%;">
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
<main>
    <div class="services-container">
        <h1>Servicios por Categoría</h1>
        <c:forEach var="categoria" items="${categorias}">
            <h2 class="category-title">${categoria.nombre}</h2>
            <c:if test="${empty categoria.servicios}">
                <p class="no-services-msg">No hay servicios disponibles en esta categoría.</p>
            </c:if>
            <div class="services-list">
                <c:forEach var="servicio" items="${categoria.servicios}">
                    <div class="service-card-wrapper">
                        <div class="service-card">
                            <img src="${servicio.imgUrl}" class="service-image" alt="${servicio.nombre}">
                            <div class="service-info">
                                <h5 class="service-title">${servicio.nombre}</h5>
                                
                                <p class="service-price"><strong>Precio:</strong> $${servicio.precio}</p>
                                <p class="service-author"><small>Autor: ${servicio.usuario.nombre}</small></p>

                                <c:choose>
                                    <c:when test="${empty usuarioSesion or usuarioSesion.id ne servicio.usuario.id}">
                                        <a href="${pageContext.request.contextPath}/servicio/detalles/${servicio.id}"
                                            class="btn-request-service">
                                            <i class="fas fa-hand-paper"></i> Solicitar Servicio
                                        </a>
                                        <button class="btn-contact-seller" data-bs-toggle="modal"
                                            data-bs-target="#contactModal"
                                            onclick="openModal('${servicio.usuario.nombre}', '${servicio.nombre}')">
                                            <i class="fas fa-comment-alt"></i> Contactar con el Vendedor
                                        </button>
                                    </c:when>

                                    <c:otherwise>
                                        <a href="${pageContext.request.contextPath}/servicio/detalles/${servicio.id}"
                                            class="btn-view-service">
                                            <i class="fas fa-eye"></i> Ver
                                        </a>
                                    </c:otherwise>
                                </c:choose>

                                
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

                    <div id="chatMessages" class="border rounded p-3 mb-3"
                        style="height: 250px; overflow-y: auto; background-color: #f8f9fa;">
                        <div class="text-start"><strong>Vendedor:</strong> Hola, ¿cómo puedo ayudarte?</div>
                        <div class="text-end"><strong>Tú:</strong> Me interesa este servicio, ¿qué incluye?</div>
                        <div class="text-start"><strong>Vendedor:</strong> Incluye todo lo necesario para que puedas
                            usarlo sin problemas.</div>
                    </div>

                    <div class="input-group">
                        <input type="text" id="messageInput" class="form-control"
                            placeholder="Escribe tu mensaje...">
                        <button class="btn btn-primary" onclick="sendMessage()">
                            <i class="fa-solid fa-paper-plane"></i>
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

        <footer>
            <p>Pololitos &copy; 2025, Todos los derechos reservados</p>
            <ul class="nav-footer">
                <li><a href="/contacto">Contacto</a></li>
                <li><a href="/nosotros">Nosotros</a></li>
            </ul>
        </footer>

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
                    newMessage.innerHTML = <strong>Tú:</strong> ${messageText};
                    chatMessages.appendChild(newMessage);
                    chatMessages.scrollTop = chatMessages.scrollHeight;
                    messageInput.value = "";
                }
            }
        </script>
    </body>
    
    </html>