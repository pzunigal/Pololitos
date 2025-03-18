<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

        <!DOCTYPE html>
        <html lang="es">

        <head>
            <meta charset="UTF-8">
            <title>Mis Servicios</title>
            <!-- BOOTSTRAP -->
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
            <!-- FontAwesome para los íconos -->
            <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"
                rel="stylesheet">

            <style>
                /* Custom Styles */
                .card img {
                    max-height: 200px;
                    object-fit: cover;
                }

                .card {
                    margin-bottom: 20px;
                }

                footer {
                    background-color: #f8f9fa;
                    padding: 20px 0;
                }

                .footer-nav {
                    list-style-type: none;
                    padding-left: 0;
                    text-align: center;
                }

                .footer-nav li {
                    display: inline;
                    margin: 0 10px;
                }

                .footer-nav li a {
                    text-decoration: none;
                    color: #007bff;
                }

                .footer-nav li a:hover {
                    text-decoration: underline;
                }

                .card-body .action-buttons {
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                }
            </style>
        </head>

        <body>

            <header class="bg-dark text-white">
                <div class="container d-flex justify-content-between align-items-center py-3">
                    <a href="/" class="d-flex align-items-center">
                        <img src="img/pololitosBlanco.png" alt="Logo pololitos" style="height: 40px;">
                    </a>
                    <nav>
                        <ul class="nav">
                            <li class="nav-item"><a href="/mis-servicios" class="nav-link text-white">Mis Servicios</a>
                            </li>
                            <c:choose>
                                <c:when test="${not empty sessionScope.usuarioEnSesion}">
                                    <li class="nav-item"><a href="/logout" class="nav-link text-white">Cerrar sesión</a>
                                    </li>
                                </c:when>
                                <c:otherwise>
                                    <li class="nav-item"><a href="/login"
                                            class="nav-link btn btn-primary text-white">Iniciar sesión</a></li>
                                    <li class="nav-item"><a href="/registro"
                                            class="nav-link btn btn-outline-light">Regístrate</a></li>
                                </c:otherwise>
                            </c:choose>
                        </ul>
                    </nav>
                </div>
            </header>

            <main>
                <div class="container mt-5">
                    <h1 class="mb-4">Mis Servicios</h1>
                    <c:choose>
                        <c:when test="${not empty servicios}">
                            <div class="row">
                                <c:forEach var="servicio" items="${servicios}">
                                    <div class="col-md-4 mb-4">
                                        <div class="card shadow-sm">
                                            <!-- Imagen Responsiva -->
                                            <img src="${servicio.imgUrl}" alt="${servicio.nombre}"
                                                class="card-img-top img-fluid">
                                            <div class="card-body">
                                                <h5 class="card-title">${servicio.nombre}</h5>
                                                <p class="card-text">${servicio.descripcion}</p>
                                                <p class="card-text"><strong>Precio: $${servicio.precio}</strong></p>

                                                <!-- Botones de acción -->
                                                <div class="action-buttons">
                                                    <a href="<c:url value='/editar-servicio/${servicio.id}' />"
                                                        class="btn btn-warning">
                                                        <i class="fas fa-pencil-alt"></i> Editar
                                                    </a>
                                                    <a href="javascript:void(0);" class="btn btn-danger"
                                                        onclick="openDeleteModal(`${servicio.id}`);">
                                                        <i class="fas fa-trash-alt"></i> Eliminar
                                                    </a>

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <p>No tienes servicios publicados.</p>
                        </c:otherwise>
                    </c:choose>
                </div>
            </main>

            <footer>
                <div class="container">
                    <p class="text-center">Pololitos &copy; 2025, Todos los derechos reservados</p>
                    <ul class="footer-nav">
                        <li><a href="/contacto">Contacto</a></li>
                        <li><a href="/nosotros">Nosotros</a></li>
                    </ul>
                </div>
            </footer>
            <!-- Modal de confirmación de eliminación -->
            <div class="modal fade" id="confirmDeleteModal" tabindex="-1" aria-labelledby="confirmDeleteModalLabel"
                aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="confirmDeleteModalLabel">Confirmación de eliminación</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"
                                aria-label="Cerrar"></button>
                        </div>
                        <div class="modal-body">
                            <p>¿Estás seguro que quieres borrar tu servicio? Si es así, escribe "borrar mi servicio"
                                para confirmar.</p>
                            <input type="text" id="confirmText" class="form-control"
                                placeholder="Escribe 'borrar mi servicio'">
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                            <button type="button" class="btn btn-danger" id="confirmDeleteButton">Eliminar</button>
                        </div>
                    </div>
                </div>
            </div>

            <script>
                // Función para abrir el modal y asignar el ID del servicio
                function openDeleteModal(serviceId) {
                    serviceIdToDelete = serviceId; // Asigna el ID del servicio
                    console.log("ID DEL SERVICIO A ELIMINAR: ", serviceIdToDelete);
                    new bootstrap.Modal(document.getElementById('confirmDeleteModal')).show();
                }

                // Manejo del botón de eliminación en el modal
                document.getElementById('confirmDeleteButton').addEventListener('click', function () {
                    const confirmText = document.getElementById('confirmText').value.trim().toLowerCase();

                    // Validación de la entrada
                    if (confirmText === 'borrar mi servicio') {
                        // Si la validación pasa, envía una solicitud DELETE al servidor
                        fetch(`/api/servicios/${serviceIdToDelete}`, {  // Cambia la URL al nuevo endpoint REST
                            method: 'DELETE',
                            headers: {
                                'Content-Type': 'application/json'
                            },
                        })
                            .then(response => {
                                if (response.ok) {
                                    // Si la eliminación fue exitosa, recarga la página
                                    window.location.reload();
                                } else {
                                    response.text().then(errorMessage => {
                                        console.error('Error al eliminar el servicio:', errorMessage);
                                        alert('Hubo un error al intentar eliminar el servicio. Verifica la consola para más detalles.');
                                    });
                                }
                            })
                            .catch(err => {
                                console.error('Error en la comunicación con el servidor:', err);
                                alert('Hubo un error en la comunicación con el servidor. Verifica la consola para más detalles.');
                            });
                    } else {
                        alert('Por favor, escribe "borrar mi servicio" para confirmar la eliminación.');
                    }
                });

            </script>



            <!-- BOOTSTRAP JS -->
            <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"></script>
        </body>

        </html>